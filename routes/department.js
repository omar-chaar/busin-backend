const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const { route } = require('./user');
const router = express.Router()
const mysql = require('../lib/mysql').pool

//functions

function createDepartment(req, res){
    const name = req.body.name;
    const companyId = req.body.companyId;

    if(!name || !companyId){
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
            [name, companyId],
            (err, results) => {
                connection.release();
                if(err){
                    console.log(err)
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Department created.', data: {id: results.insertId, departmentName: name, companyId: companyId}});
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
    const companyId = req.param.companyId;
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT department_id, name, company_id FROM Department where company_id = ?;',
            [companyId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Departments found.', data: results});
            }
        );
    });
}

function getAllUsersByDepartment(req, res){
    const departmentId = req.params.departmentId;
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT User.* FROM User INNER JOIN Department where Department.department_id = ?;', [departmentId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({response: 'Users found.', data: results});
            }
        );
    });
}


//routes

router.post('/create', createDepartment);
router.put('/update', updateDepartment);
router.delete('/delete', deleteDepartment);
router.get('/get-name/:departmentId', getDepartment);
router.get('/get-departments/:companyId', getAllDepartments);
router.get('/get-users/:departmentId',getAllUsersByDepartment);

module.exports = router;