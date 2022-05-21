const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const router = express.Router()
const mysql = require('../lib/mysql').pool

//functions

function generateCode(req, res) {
    const departmentId = req.body.departmentId;
    const position = req.body.position;
    const name = req.body.name;
    const surname = req.body.surname;
    const admin = req.body.admin || false;

    if (!departmentId || !position || !name || !surname) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    let length = 5, chars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz", code = "";
    for (var i = 0, n = chars.length; i < length; ++i) {
        code += chars.charAt(Math.floor(Math.random() * n
        ));
    }

    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'INSERT INTO User (name, surname, department_id, position, is_adm, is_owner, reg_code) VALUES (?, ?, ?, ?, ?, ?, ?);',
            [name, surname, departmentId, position, admin, false, code],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({ response: 'Code generated. Send it to the user so he can finish the registration.', data: code });
            }
        );
    });
}

function validateCode(req, res) {
    const code = req.query.token;

    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT reg_code FROM User WHERE reg_code = ?;',
            [code],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                if (results.length === 0) {
                    return res.status(400).send({
                        error: 'Invalid code.'
                    });
                }

                return res.status(200).send({ response: 'Code is valid.' });
            }
        );
    });
}

function createUserFromCode(req, res) {
    const password = req.body.password;
    const email = req.body.email;
    const code = req.body.code;

    if (!password || !email) {
        return res.status(400).send({
            error: 'Missing password or email.'
        });
    }

    bcrypt.hash(password, 10, (err, hash) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }

        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                'UPDATE User SET password = ?, email = ? WHERE reg_code = ?;',
                [hash, email, code],
                (err, results) => {
                    connection.release();
                    if (err) {
                        console.log(err)
                        return res.status(500).send({
                            error: 'Failed to register user. Try Again.'
                        });
                    }

                    return res.status(200).send({ response: 'User created.' });
                }
            )
        });
    });
}

function getUserData(req, res) {
    const userId = req.params.userId;
    if (!userId) {
        return res.status(400).send({
            error: 'Missing user id.'
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT name, surname, department_id, position, is_adm FROM User WHERE user_id = ?;',
            [userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                if (results.length === 0) {
                    return res.status(400).send({
                        error: 'User not found.'
                    });
                }

                return res.status(200).send({ response: 'User found.', data: results[0] });
            }
        );
    });
}
//routes

function editUserData(req, res) {
    const userId = req.params.userId;
    const name = req.body.name;
    const surname = req.body.surname;
    const departmentId = req.body.departmentId;
    const position = req.body.position;
    const admin = req.body.admin || false;

    if (!userId || !name || !surname || !departmentId || !position) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'UPDATE User SET name = ?, surname = ?, department_id = ?, position = ?, is_adm = ? WHERE user_id = ?;',
            [name, surname, departmentId, position, admin, userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({ response: 'User updated.' });
            }
        );
    });
}

function editUserEmail(req, res) {
    const userId = req.params.userId;
    const email = req.body.email;

    if (!userId || !email) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'UPDATE User SET email = ? WHERE user_id = ?;',
            [email, userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({ response: 'User updated.' });
            }
        );
    });
}

//Change use password in safe manner
function editUserPassword(req, res) {
    const userId = req.params.userId;
    const password = req.body.password;

    if (!userId || !password) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    bcrypt.hash(password, 10, (err, hash) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }

        mysql.getConnection((err, connection) => {
            if (err) {
                return res.status(500).send({
                    error: err
                });
            }
            connection.query(
                'UPDATE User SET password = ? WHERE user_id = ?;',
                [hash, userId],
                (err, results) => {
                    connection.release();
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }

                    return res.status(200).send({ response: 'User updated.' });
                }
            );
        });
    });

}

function updateUserImage(req, res) {
    const userId = req.params.userId;
    const image = req.body.image;

    if (!userId || !image) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }

    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'UPDATE User SET profile_picture = ? WHERE user_id = ?;',
            [image, userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                return res.status(200).send({ response: 'User updated.' });
            }
        );
    });
}


function getUserImage(req, res) {
    const userId = req.params.userId;
    if (!userId) {
        return res.status(400).send({
            error: 'Missing user id.'
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT profile_picture FROM User WHERE user_id = ?;',
            [userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                if (results.length === 0) {
                    return res.status(400).send({
                        error: 'User not found.'
                    });
                }

                return res.status(200).send({ response: 'User found.', data: results[0] });
            }
        );
    });
}

function userLogin(req, res) {
    const email = req.body.email;
    const password = req.body.password;

    if (!email || !password) {
        return res.status(400).send({
            error: 'Missing information.'
        });
    }
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT * FROM User WHERE email = ?',
            [email],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err
                    });
                }

                if (results.length === 0) {
                    return res.status(400).send({
                        error: 'Email incorrect.'
                    });
                }

                bcrypt.compare(password, results[0].password, (err, result) => {
                    if (err) {
                        return res.status(500).send({
                            error: err
                        });
                    }
                    console.log(result);
                    if (result) {
                        jwt.sign({ userId: results[0] }, process.env.JWT_KEY, (err, token) => {
                            if (err) {
                                return res.status(500).send({
                                    error: err
                                });
                            }

                            return res.status(200).send({ response: 'User found.', data: results[0], token: token });
                        });

                    } else return res.status(400).send({
                        error: 'Password incorrect.'
                    });
                });
            }
        );
    });

}

router.post('/generate-code', generateCode); //this route will require admin authorization
router.get('/validate-code', validateCode);
router.post('/create', createUserFromCode);
router.get('/get-user-data/:userId', getUserData);
router.put('/edit-user-data/:userId', editUserData);
router.put('/edit-user-email/:userId', editUserEmail);
router.put('/edit-user-password/:userId', editUserPassword);
router.put('/update-user-image/:userId', updateUserImage);
router.get('/get-user-image/:userId', getUserImage);
router.post('/login', userLogin);

module.exports = router;