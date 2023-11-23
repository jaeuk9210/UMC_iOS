var express = require("express");
var router = express.Router();
var File = require("../models/File");

router.get("/:serverFileName", function (req, res) {
  File.findOne({
    serverFileName: req.params.serverFileName,
  })
    .then((file) => {
      var stream = file.getFileStream();
      if (stream) {
        res.writeHead(200, {
          "Content-Type": "application/octet-stream",
          "Content-Disposition":
            "attachment; filename=" + file.originalFileName,
        });
        stream.pipe(res);
      } else {
        res.statusCode = 404;
        res.end();
      }
    })
    .catch((err) => {
      if (err) return res.json(err);
    });
});

module.exports = router;
