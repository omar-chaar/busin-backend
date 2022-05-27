const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const { request } = require("../main");
const userAuthorization = require("../middlewares/userAuthorization");
const router = express.Router();
const mysql = require("../lib/mysql").pool;

//TODO: TEST THIS FUNCTION
function getMessageForUser(req, res) {
    const userId = req.params.userId;
    const lastMessageId = req.query.lastMessageId;
    if (!userId) {
        return res.status(400).send({
            error: "Missing userId.",
        });
    }
    if (!lastMessageId) {
        //send the last 10 messages
        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err,
                });
            }
            connection.query(
                "SELECT message_id, sender_id, receiver_id, time, message_body, parent_message_id, was_seen, user_id, name, surname, profile_picture from Message INNER JOIN User ON receiver_id = user_id OR sender_id = user_id where message_id not in (SELECT parent_message_id FROM Message WHERE parent_message_id is not null) and (receiver_id = ? OR sender_id = ?) and user_id != ? ORDER BY time DESC LIMIT 10;",
                [userId, userId, userId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err,
                        });
                    }

                   
                    const chats = [];
                    results.forEach((message) => {
                        const chatId = message.sender_id + message.receiver_id;
                        const chat = {
                            chatId: chatId,
                            chatMessageId: message.message_id,
                            chatMessage: message.message_body,
                            chatTime: message.time,
                            chatSenderId: message.sender_id,
                            chatReceiverId: message.receiver_id,
                            chatParentMessageId: message.parent_message_id,
                            chatWasSeen: message.was_seen,
                            user: {
                                id: message.user_id,
                                name: message.name,
                                surname: message.surname,
                                profile_picture: message.profile_picture,
                            },
                        };
                        if (!chats.find((chat) => chat.chatId === chatId)) chats.push(chat);
                    });

                    return res.status(200).send({
                        messages: chats,
                    });
                }
            );
        });
    } else {
        //send the messages after the lastMessageId
        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err,
                });
            }
            connection.query(
                //get time from lastMessageId and check next 10 messages
                "SELECT message_id, sender_id, receiver_id, time, message_body, parent_message_id, was_seen, name, surname, profile_picture from Message INNER JOIN User ON receiver_id = user_id OR sender_id = user_id where message_id not in (SELECT parent_message_id FROM Message WHERE parent_message_id is not null) AND time < (SELECT time FROM Message WHERE message_id = ?) and (receiver_id = ? OR sender_id = ?) and user_id != ? ORDER BY time DESC LIMIT 10;",
                [lastMessageId, userId, userId, userId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err,
                        });
                    }
                    return res.status(200).send({
                        messages: results,
                    });
                }
            );
        });
    }
}


function getParentMessage(req, res) {
    const messageId = req.params.messageId;
    const userId = req.query.userId;
    const user2Id = req.query.user2Id;

    if (!messageId) {
        return res.status(400).send({
            error: "Missing messageId.",
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            //get the next 10 messages using the time of last message id
            "SELECT * FROM Message WHERE (receiver_id = ? AND sender_id = ?) or (receiver_id = ? AND sender_id = ?) and time < (SELECT time FROM Message WHERE message_id = ?) ORDER BY time DESC LIMIT 10;",
            [userId, user2Id, user2Id, userId, messageId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
               
                return res.status(200).send({
                    messages: results,
                });
            }
        );
    });
}

function wasSeen(req, res) {
    const userId = req.params.userId;
    const user2Id = req.params.user2Id;
    if (!userId || !user2Id) {
        return res.status(400).send({ error: "Missing userId." });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({ error: err });
        }
        connection.query(
            "UPDATE Message SET was_seen = 1 WHERE (receiver_id = ? AND sender_id = ?) OR (sender_id = ? AND receiver_id = ?) AND was_seen = false;",
            [userId, user2Id, userId, user2Id],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({ error: err });
                }
                return res.status(200).send({
                    messages: results,
                });
            }
        );
    });
}


function insertMessage(req, res) {
    const message = req.body.message;
    const senderId = req.body.senderId;
    const receiverId = req.body.receiverId;
    const parentId = req.body.parentId;

    if (!message || !senderId || !receiverId) {
        return res.status(400).send({
            error: "Missing message or senderId or receiverId.",
        });
    }

    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "INSERT INTO Message (message_body, sender_id, receiver_id, time, parent_message_id) VALUES (?, ?, ?, NOW(), ?);",
            [message, senderId, receiverId, parentId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
                return res.status(200).send({
                    response: results.insertId,
                });
            }
        );
    });
}

//get first 10 messages
function getMessages(req, res) {
    const userId = req.params.userId;
    const user2Id = req.params.user2Id;
    if (!userId || !user2Id) {
        return res.status(400).send({
            error: "Missing userId or user2Id.",
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "SELECT * FROM Message WHERE (receiver_id = ? AND sender_id = ?) or (receiver_id = ? AND sender_id = ?) ORDER BY time DESC LIMIT 10;",
            [userId, user2Id, user2Id, userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }

                //order result by time and invert it
                results.reverse();

                return res.status(200).send({
                    messages: results,
                });
            }
        );
    });
}

//get number of unreads
function getUnread(req, res) {
    const receiverId = req.body.receiverId;
    const senderId = req.body.senderId;
    if (!userId || !user2Id) {
        return res.status(400).send({
            error: "Missing information",
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "SELECT COUNT(*) AS unread FROM Message WHERE (receiver_id = ? AND sender_id = ?) AND was_seen = false",
            [userId, user2Id, userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
                return res.status(200).send({
                    unread: results[0].unread,
                });
            }
        );
        
        
    });
}

function getNextTenMessages(req, res) {
    const userId = req.params.userId;
    const user2Id = req.params.user2Id;
    const lastMessageId = req.body.lastMessageId;
    if (!userId || !user2I || !lastMessageId) {
        return res.status(400).send({
            error: "Missing userId or user2Id or lastMessageId.",
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "SELECT message_id, body, sender_id, receiver_id, time, was_seen  FROM Message WHERE (receiver_id = ? AND sender_id = ?) or (receiver_id = ? AND sender_id = ?) AND time < (SELECT time FROM Message WHERE message_id = ?) ORDER BY time DESC LIMIT 10;",
            [userId, user2Id, user2Id, userId, lastMessageId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
                return res.status(200).send({
                    messages: results,
                });
            }
        );
    });

}

router.post("get-unread/", userAuthorization, getUnread);
router.get("/get-messages/:userId", getMessageForUser);
router.get("/parentmessage/:messageId", userAuthorization, getParentMessage);
router.put("/was-seen/:userId/:user2Id", userAuthorization, wasSeen);
router.post("/insert-message", userAuthorization, insertMessage);
router.get("/get-messages/:userId/:user2Id", userAuthorization, getMessages);
router.get("/get-next-ten-messages/:userId/:user2Id", userAuthorization, getNextTenMessages);

module.exports = router;
