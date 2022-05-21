const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const router = express.Router()
const mysql = require('../lib/mysql').pool

function getGroupName(req,res){
    const groupId = req.body.groupId;

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
            'SELECT name FROM Group WHERE group_id = ?;',
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

router.get('/name', getGroupName);

module.exports = router;