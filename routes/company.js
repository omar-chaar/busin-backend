const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const router = express.Router()
const mysql = require('../lib/mysql').pool

function createCompany(req, res){
    const companyName = req.body.companyName;
    const name = req.body.name;
    const surname = req.body.surname;
    const email = req.body.email;
    const password = req.body.password;
    const position = req.body.position;

    if (!companyName || !name || !surname || !email || !password || !position) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    //encrypt password
    bcrypt.hash(password, 10, (err, hash) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        //create a company
        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                'INSERT INTO Company (name) VALUES (?);',
                [companyName],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }
                    //create a derpartment
                    mysql.getConnection((err, connection) => {
                        if (err) {
                            return res.status(500).send({
                                error: err
                            });
                        }
                        connection.query(
                            'INSERT INTO Department (name, company_id) VALUES (\'Owner\', (SELECT company_id FROM Company WHERE name = ?));',
                            [companyName],
                            (err, results) => {
                                connection.release();
                                if (err) {
                                    return res.status(500).send({
                                        error: err
                                    });
                                }
                                //create a user
                                mysql.getConnection((err, connection) => {
                                    if (err) {
                                        return res.status(500).send({
                                            error: err
                                        });
                                    }
                                    connection.query(
                                        'INSERT INTO User (name, surname, email, password, position, department_id) VALUES (?, ?, ?, ?, ?, (SELECT department_id FROM Department WHERE name = \'Owner\' AND company_id = (SELECT company_id FROM Company WHERE name = ?)));',
                                        [name, surname, email, hash, position, companyName],
                                        (err, results) => {
                                            connection.release();
                                            if (err) {
                                                return res.status(500).send({
                                                    error: err
                                                });
                                            }
                                            return res.status(200).send({
                                                response: 'Company, department and user created.'
                                            });
                                        }
                                    );
                                });
                            }
                        );
                    }
                );
            });
        });
    });
}

route.post('/create', createCompany);

module.exports = router;


