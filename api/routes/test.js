var express = require("express");
var router = express.Router();




// Parameters:
// {
//   "date": String ("Dec 02 2019 06:00"),
//   "table": table id,
// 	"name": String,
// 	"phone": String,
// 	"email": String
// }

router.get("/", function(req, res, next) {
  console.log("received request to /test")
  res.status(200).send("test worked");
});

module.exports = router;