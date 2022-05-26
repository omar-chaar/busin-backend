const express = require("express");
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const { connect } = require("./user");
const router = express.Router();
const mysql = require("../lib/mysql").pool;
const adminAuth = require("../middlewares/adminAuthorization");
const userAuth = require("../middlewares/userAuthorization");

//Creates an announcement to send to the whole company
function createAnnouncement(req, res, next) {
    const title = req.body.title;
    const body = req.body.body;
    const senderId = req.body.senderId;
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "INSERT INTO Announcement (announcement_title, announcement_body, sender_id) VALUES (?, ?, ?);",
            [title, body, senderId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
                res.locals.announcementId = results.insertId;
                connection.query(
                    "SELECT Company.company_id FROM Company INNER JOIN Department ON Department.company_id = Company.company_id INNER JOIN User ON Department.department_id = User.department_id WHERE User.user_id = ?;",
                    [senderId],
                    (err, results) => {
                        connection.release();
                        if (err) {
                            return res.status(500).send({
                                error: err,
                            });
                        }
                        res.locals.companyId = results[0].company_id;
                        next();
                    }
                ); //end of inner query
            }
        ); //end of query
    }); //end of mysql.getConnection
} //end of createAnnouncement

//function necessary to create a new announcement
function addAnnouncementReceivers(req, res) {
    const announcementId = res.locals.announcementId;
    const companyId = res.locals.companyId;
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "INSERT INTO AnnouncementReceiver (announcement_id, receiver_id, has_seen) SELECT ?, User.user_id, 0 FROM User INNER JOIN Department ON Department.department_id = User.department_id INNER JOIN Company ON Department.company_id = Company.company_id WHERE Company.company_id = ?;",
            [announcementId, companyId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
                return res.status(200).send({
                    response: "AnnouncementReceiver created.",
                    data: {
                        id: results.insertId,
                        announcementId: announcementId,
                        body: req.body.body,
                        title: req.body.title,
                        sender: req.body.senderId,
                    },//end of data
                });//end of return
            }
        ); //end of query
    }); //end of mysql.getConnection
} //end of addAnnouncementReceivers

function getAllAnnouncementsForUser(req, res) {
    const userId = req.params.userId;
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "SELECT * FROM Announcement INNER JOIN AnnouncementReceiver where Announcement.announcement_id = AnnouncementReceiver.announcement_id AND receiver_id = ? ORDER BY time ASC;",
            [userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }

                return res
                    .status(200)
                    .send({ response: "Users found.", data: results });
            }
        ); //end of query
    }); //end of mysql.getConnection
} //end of getAllAnnouncementsForUser

//get first 10 announcements for a user
function getFirstTenAnnouncementsForUser(req, res) {
    const userId = req.params.userId;
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "SELECT * FROM Announcement INNER JOIN AnnouncementReceiver where Announcement.announcement_id = AnnouncementReceiver.announcement_id AND receiver_id = ? ORDER BY time DESC LIMIT 10;",
            [userId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }

                return res
                    .status(200)
                    .send({ response: "Announcements found.", data: results });
            }
        ); //end of query
    }); //end of mysql.getConnection
} //end of getFirstTenAnnouncementsForUser

//get next 10 announcements according to time
function getNextTenAnnouncementsForUser(req, res) {
    const userId = req.params.userId;
    const announcementId = req.body.announcementId;
    mysql.getConnection((err, connection) => {
        if (err) {
            return res.status(500).send({
                error: err,
            });
        }
        connection.query(
            "SELECT * FROM Announcement INNER JOIN AnnouncementReceiver where Announcement.announcement_id = AnnouncementReceiver.announcement_id AND receiver_id = ? AND time < (SELECT time FROM Announcement WHERE announcement_id = ?) ORDER BY time DESC LIMIT 10;",
            [userId, announcementId],
            (err, results) => {
                connection.release();
                if (err) {
                    return res.status(500).send({
                        error: err,
                    });
                }
                console.log(userId + " " + announcementId);
                return res.status(200).send({
                    response: "Announcements found.",                    
                    data: results,
                });
                
            }
        ); //end of query
    }); //end of mysql.getConnection
} //end of getNextTenAnnouncementsForUser



router.post("/create", adminAuth, createAnnouncement, addAnnouncementReceivers);
router.get("/get-all-announcements-for-user/:userId", userAuth, getAllAnnouncementsForUser);
router.get("/get-first-ten-announcements-for-user/:userId", userAuth, getFirstTenAnnouncementsForUser);
router.post("/get-next-ten-announcements-for-user/:userId", userAuth, getNextTenAnnouncementsForUser);

module.exports = router;
