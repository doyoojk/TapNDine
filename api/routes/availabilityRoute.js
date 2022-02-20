var express = require("express");
var router = express.Router();


// Parameters:
// {
//   "date": String ("Dec 02 2019 06:00")
// }

router.post("/", function(req, res, next) {
  console.log("request attempted");
  console.log(req.body);
  const dateTime = new Date(req.body.date);

});

module.exports = router;
