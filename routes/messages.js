const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
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
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                'SELECT * FROM Message WHERE receiver_id = ? AND message_id IS NOT IN (SELECT parent_message_id FROM Message)  ORDER BY time DESC LIMIT 10;',
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
                'SELECT * FROM Message WHERE receiver_id = ? AND time < (SELECT time FROM Message WHERE message_id = ?) ORDER BY id DESC LIMIT 10;',
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
                'SELECT * FROM GroupMessage WHERE group_id IN (SELECT group_id FROM GroupParticipant WHERE user_id = ?) AND group_message_id IS NOT IN (SELECT parent_message_id FROM GroupMessage)  ORDER BY time DESC LIMIT 10;',
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


router.get('/messages/:userId', getMessageForUser);
router.get('/groupmessages/:userId', getGroupMessageForUser);






module.exports = router;