const express = require("express");
const mongoose = require("mongoose");
const passport = require("passport");

require("dotenv").config();

const app = express();

app.use(express.json());
// app.use(express.urlencoded({ etended: true }));
app.use(passport.initialize());

require("./configs/passport");

mongoose.connect(process.env.MONGO_DB);
var db = mongoose.connection;

db.once("open", function () {
  console.log("DB connnected");
});

db.on("error", function (err) {
  console.log("DB Error: ", err);
});

app.get("/", (req, res) => {
  res.send("Hello World");
});

app.use("/posts", require("./routes/posts"));
app.use("/users", require("./routes/users"));
app.use("/files", require("./routes/files"));

let port = 3000;
app.listen(port, function () {
  console.log("server on! http://localhose:" + port);
});
