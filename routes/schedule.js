const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const router = express.Router()
const mysql = require('../lib/mysql').pool

function editSchedule(req, res){
    const userId = req.params.userId;
    const start = req.body.start;
    const end = req.body.end;
    const date = req.body.date;

    if(!userId || !start || !end || !date){
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'UPDATE Schedule SET start = ?, end = ?, date = ? WHERE user_id = ?;',
            [start, end, date, userId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Schedule updated.', data: {id: results.insertId, start: start, end: end, date: date}});
            }
        );
    });
}



module.exports = router;