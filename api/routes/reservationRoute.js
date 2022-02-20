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

router.post("/", function(req, res, next) {
  console.log("received request")
  // console.log(req.body)

  console.log(`${req.body.name} just reserved a table at ${req.body.site}`)



  res.status(200).send("Added Reservation");
});

module.exports = router;
