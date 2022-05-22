const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { request } = require('../main');
const router = express.Router()
const mysql = require('../lib/mysql').pool

//TODO: TEST THIS FUNCTION
function getMessageForUser(req, res) {
    const userId = req.params.userId;
    const lastMessageId = req.query.lastMessageId;
    if (!userId) {
        return res.status(400).send({
            error: 'Missing userId.'
        });
    }
    if (!lastMessageId) {
        //send the last 10 messages
        mysql.getConnection((err, connection) => {
            if (err) {
                console.log(err)
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                "SELECT message_id, sender_id, receiver_id, time, message_body, parent_message_id, was_seen, name, surname, profile_picture from Message INNER JOIN User ON receiver_id = user_id OR sender_id = user_id where message_id not in (SELECT parent_message_id FROM Message WHERE parent_message_id is not null) and (receiver_id = ? OR sender_id = ?) and user_id != ?;",
                [userId, userId, userId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }

                    console.log(results)
                    const chats = {};
                    results.forEach(message => {
                        const chatId = message.sender_id + message.receiver_id;
                        if (!chats[chatId]) {
                            chats[chatId] = [];
                            chats[chatId].push(message);
                        }
                        else{
                            chats[chatId].push(message);
                        }
                    });

                    Object.values(chats).forEach(chat => {
                        chat.sort((a, b) => {
                            return new Date(a.time) - new Date(b.time);
                        });
                    });

                    return res.status(200).send({
                        messages: chats
                    });
                }
            );
        });
    } else {
        //send the messages after the lastMessageId
        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                //get time from lastMessageId and check next 10 messages
                'SELECT * FROM Message WHERE (receiver_id = ? OR sender_id = ?) AND time < (SELECT time FROM Message WHERE message_id = ?) ORDER BY id DESC LIMIT 10;',
                [userId, userId, lastMessageId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }
                    return res.status(200).send({
                        messages: results
                    });

                }
            );
        }
        );
    }
}

function getGroupMessageForUser(req, res) {
    const userId = req.params.userId;
    const lastMessageId = req.query.lastMessageId;
    if (!userId) {
        return res.status(400).send({
            error: 'Missing userId.'
        });
    }
    if (!lastMessageId) {
        //send the last 10 messages
        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                'SELECT * FROM GroupMessage WHERE group_id IN (SELECT group_id FROM GroupParticipant WHERE user_id = ?) AND group_message_id NOT IN (SELECT parent_message_id FROM GroupMessage WHERE NOT NULL)  ORDER BY time DESC LIMIT 10;',
                [userId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }
                    return res.status(200).send({
                        messages: results
                    });
                }
            );
        });
    } else {
        //send the messages after the lastMessageId
        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                //get time from lastMessageId and check next 10 messages
                'SELECT * FROM GroupMessage WHERE group_id IN (SELECT group_id FROM GroupParticipant WHERE user_id = ?) AND time < (SELECT time FROM GroupMessage WHERE group_message_id = ?) ORDER BY id DESC LIMIT 10;',
                [userId, lastMessageId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }
                    return res.status(200).send({
                        messages: results
                    });

                }
            );
        }
        );
    }
}


function getParentMessage(req, res) {
    const messageId = req.params.messageId;
    if (!messageId) {
        return res.status(400).send({
            error: 'Missing messageId.'
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT TOP * FROM Message WHERE message_id = (SELECT parent_message_id FROM Message WHERE message_id = ?) LIMIT 1;',
            [messageId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }
                return res.status(200).send({
                    messages: results
                });
            }
        );
    }
    );
}
function wasSeen(req,res){
    const userId = req.params.userId;
    const user2Id = req.params.user2Id;
    if (!userId || !user2Id) {
        return res.status(400).send({ error: 'Missing userId.' });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({ error: err });
        }
        connection.query(
            'UPDATE Message SET was_seen = 1 WHERE (receiver_id = ? AND sender_id = ?) OR (receiver_id = ? AND sender_id = ?) AND was_seen = 0;',
            [userId, user2Id, user2Id, userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({ error: err });
                }
                return res.status(200).send({
                    messages: results
                });
            });
    });
}




router.get('/get-messages/:userId', getMessageForUser);
router.get('/groupmessages/:userId', getGroupMessageForUser);
router.get('/parentmessage/:messageId', getParentMessage);
router.put('/was-seen/:userId/:user2Id', wasSeen);
// router.post('/insert-message', insertMessage);





module.exports = router;