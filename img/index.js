var express = require('express');
const url = require("url");
var router = express.Router();

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', {title: 'Express'});
});

router.get('/user', function (req, res, next) {
    var q = url.parse(req.url, true)
    let data
    console.log(q.query)
    if (q.query.page == 0){
        data = [{"id": 1, "name": "Igor"}, {"id": 2, "name": "Max"}]
    }else{
        data = [{"id": 3, "name": "Alex"}, {"id": 8, "name": "Pasha"}]
    }

        res.send(JSON.stringify(data));
});

router.get('/user/:id', function (req, res, next) {
    let data = [{"id": 1, "name": "Alex"}];
    //res.statusCode = 500;
    res.send(JSON.stringify(data));
});

router.post('/user', function (req, res, next) {
    console.log(req.body, "POST")
    res.send(JSON.stringify([{"id": 11, "name": "Igor"}]));
});

router.put('/user', function (req, res, next) {
    data = [{"id": 11, "name": "Max"}];
    console.log(req.body, "PUT")
    res.send(JSON.stringify(data));
});

router.delete('/user/:id', function (req, res, next) {
    data = [{"id": 1, "name": "Igor"}];
    res.send(JSON.stringify(data));
});

module.exports = router;
