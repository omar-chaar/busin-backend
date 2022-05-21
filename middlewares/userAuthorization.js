const jwt = require('jsonwebtoken')

module.exports = (req, res, next) => {
    try{
        const token = req.headers.authorization.split(' ')[1]
        const decode = jwt.verify(token, process.env.JWT_KEY)
        req.user = decode
        if(req.user.userId) return next()
        return res.status(401).send({response: 'Forbidden'})
    }catch(erro){
        return res.status(401).send({response: 'Forbidden'})
    }
}