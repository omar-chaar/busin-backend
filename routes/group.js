const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const router = express.Router()
const mysql = require('../lib/mysql').pool

function getGroupName(req,res){
    const groupId = req.params.groupId;

    if(!groupId){
        return res.status(400).send({
            error: 'Missing group id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT name FROM Group WHERE group_id = ? LIMIT 1;',
            [groupId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Group name retrieved.', data: results[0].name});
            }
        );
    });
}

function getGroupParticipants(req,res){
    const groupId = req.params.groupId;

    if(!groupId){
        return res.status(400).send({
            error: 'Missing group id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT user_id FROM GroupParticipant INNER JOIN Group ON GroupParticipant.group_id = Group.group_id WHERE Group.group_id = ?;', 
            [groupId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Group participants retrieved.', data: results});
            }
        );
    });
}

//get group creation date
function getGroupCreationDate(req,res){
    const groupId = req.params.groupId;

    if(!groupId){
        return res.status(400).send({
            error: 'Missing group id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT group_creation_date FROM Group WHERE group_id = ? LIMIT 1;',
            [groupId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Group creation date retrieved.', data: results[0].group_creation_date});
            }
        );
    });
}

//add user to group
function addUserToGroup(req,res){
    const groupId = req.body.groupId;
    const userId = req.body.userId;

    if(!groupId || !userId){
        return res.status(400).send({
            error: 'Missing group id or user id.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){ 
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'INSERT INTO GroupParticipant (group_id, user_id) VALUES (?, ?);',
            [groupId, userId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'User added to group.'});
            }
        );
    });
}


router.get('/name/:id', getGroupName);
router.get('/participants/:id', getGroupParticipants);
router.get('/creation_date/:id', getGroupCreationDate);
router.post('/add_user', addUserToGroup);



module.exports = router;