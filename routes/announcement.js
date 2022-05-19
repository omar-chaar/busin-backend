const express = require('express')
const jwt = require('jsonwebtoken')
const bcrypt = require('bcrypt');
const router = express.Router()
const mysql = require('../lib/mysql').pool



function createAnnouncement(req, res, next){
    const body = req.body.body;
    const senderId = req.body.senderId;
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'INSERT INTO Announcement (announcement_body, sender_id) VALUES (?, ?);',
            [body, senderId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }
                res.locals.announcementId = results.insertId;
                next();
            }
        );
    });
}

function addAnnouncementReceivers(req, res){
    const announcementId = res.locals.announcementId;
    const companyId = req.body.companyId;
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'INSERT INTO AnnouncementReceiver (announcement_id,receiver_id, time_saw, has_seen) SELECT ?, User.user_id, null, false FROM Company INNER JOIN Department ON Department.company_id = Company.company_id INNER JOIN User ON Department.department_id = User.department_id WHERE Company.company_id = ?;',
            [announcementId, companyId],
            (err, results) => {
                connection.release();
                if(err){
                    return res.status(500).send({
                        error: err
                    });
                }
                return res.status(200).send({response: 'AnnouncementReceiver created.', data: {id: results.insertId, announcementId: announcementId, receiverId: receiverId}});
            }
        );
    });

}


function getAllAnnouncementsByUser (req, rep){
    const userId = req.params.userId;
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT User.* FROM User INNER JOIN Department where Department.department_id = ?;', [id],
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

router.post('/create', createAnnouncement, addAnnouncementReceivers);
router.get('/get-all-announcements-by-user/:userId', getAllAnnouncementsByUser);

module.exports = router;