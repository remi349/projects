var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/cot', function(req, res, next) {
  res.send('HelloMaPoule');
});

module.exports =router;
