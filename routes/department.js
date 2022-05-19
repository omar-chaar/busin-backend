const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const router = express.Router()
const mysql = require('../lib/mysql').pool

//functions

function createDepartment(req, res){
    const name = req.body.name;
    const owner = req.body.owner;

    if(!name || !owner){
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
            'INSERT INTO Department (name, company_id) VALUES (?, ?);',
            [name, owner],
            (err, results) => {
                connection.release();
                if(err){
                    console.log(err)
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Department created.', data: {id: results.insertId, name: name, owner: owner}});
            }
        );
    });
}

function updateDepartment(req, res){
    const id = req.body.id;
    const name = req.body.name;

    if(!id || !name){
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
            'UPDATE Department SET name = ? WHERE department_id = ?;',
            [name, id],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Department updated.'});
            }
        );
    });
}

function deleteDepartment(req, res){
    const id = req.params.id;

    if(!id){
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
            'DELETE FROM Department WHERE department_id = ?;',
            [id],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Department deleted.'});
            }
        );
    });
}

function getDepartment(req, res){
    const id = req.body.id;

    if(!id){
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
            'SELECT department_id, name FROM Department WHERE department_id = ?;',
            [id],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Department found.', data: results[0]});
            }
        );
    });
}

function getAllDepartments(req, res){
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT department_id, name, company_id FROM Department;',
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Department found.', data: results});
            }
        );
    });
}

//routes

router.post('/create', createDepartment);
router.put('/update', updateDepartment);
router.delete('/delete/:id', deleteDepartment);
router.get('/get', getDepartment);
router.get('/get-all', getAllDepartments);

module.exports = router;