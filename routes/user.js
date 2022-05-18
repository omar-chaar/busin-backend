const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const router = express.Router()
const mysql = require('../lib/mysql').pool

//functions

function generateToken(req, res){
    const departmentId = req.query.departamentId;
    const position = req.query.position;
    const admin = req.query.admin || false;

    if(!departmentId || !position){
        return res.status(400).send({
            error: 'Missing departament or position'
        });
    }

    const token = jwt.sign({
        departmentId,
        position,
        admin
    }, process.env.JWT_KEY, {
        expiresIn: '24h'
    })

    return res.status(200).send({response: 'Code successfully generated. You have 24h to use it.', data: token});
}

function validateToken(req, res){
    const token = req.query.token;
    if(!token){
        return res.status(400).send({
            error: 'Missing code.'
        });
    }

    jwt.verify(token, process.env.JWT_KEY, (err, decoded) => {
        if(err){
            return res.status(401).send({
                error: 'Invalid code.'
            });
        }

        return res.status(200).send({
            response: 'Code successfully validated.',
            data: token
        });
    });
}

function createUserFromToken(req, res){
    const token = req.body.token;
    const password = req.body.password;
    const email = req.body.email;
    const name = req.body.name;
    const surname = req.body.surname;
    let departmentId;
    let position;
    let admin;

    if(!token || !password || !email){
        return res.status(400).send({
            error: 'Missing code, password or email.'
        });
    }

    jwt.verify(token, process.env.JWT_KEY, (err, decoded) => {
        if(err){
            return res.status(401).send({
                error: 'Invalid code.'
            });
        }

        bcrypt.hash(password, 10, (err, hash) => {
            if(err){
                return res.status(500).send({
                    error: 'Error creating user.'
                });
            }

            departmentId = parseInt(decoded.departamentId);
            position = decoded.position;
            admin = decoded.admin;

            mysql.getConnection((err, connection) => {
                if(err){
                    return res.status(500).send({
                        error: 'Error creating user.'
                    });
                }
                connection.query(
                    'INSERT INTO User (department_id, position, email, password, name, surname) VALUES (?, ?, ?, ?, ?, ?);',
                    [departmentId, position, email, hash, name, surname],
                    (err, results) => {
                        connection.release();
                        console.log(err)
                        if(err){
                            return res.status(500).send({
                                error: 'Error creating user.'
                            });
                        }

                        return res.status(200).send({
                            response: 'User successfully created.'
                        });
                    }
                )
            })
        });
    });
}

//routes

router.get('/generate-token', generateToken); //this route will require admin authorization
router.get('/validate-token', validateToken);
router.post('/create-user', createUserFromToken);


module.exports = router;