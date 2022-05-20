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
            'INSERT INTO AnnouncementReceiver (announcement_id,receiver_id, has_seen) SELECT ?, User.user_id, false FROM Company INNER JOIN Department ON Department.company_id = Company.company_id INNER JOIN User ON Department.department_id = User.department_id WHERE Company.company_id = ?;',
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


function getAllAnnouncementsForUser (req, res){
    const userId = req.params.userId;
    mysql.getConnection((err, connection) => {
        if(err){
            return res.status(500).send({
                error: err
            });
        }
        connection.query(
            'SELECT * FROM Announcement INNER JOIN AnnouncementReceiver where Announcement.announcement_id = AnnouncementReceiver.announcement_id AND receiver_id = ?;', [userId],
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
router.get('/get-all-announcements-for-user/:userId', getAllAnnouncementsForUser);

module.exports = router;