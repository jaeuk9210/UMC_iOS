const express = require("express");
const router = express.Router();
const multer = require("multer");
const upload = multer({ dest: "uploadedfiles/" });
const Post = require("../models/Post");
const File = require("../models/File");
const util = require("../utils/util");
const passport = require("passport");

router.post(
  "/",
  passport.authenticate("jwt", { session: false }),
  upload.single("attachment"),
  async (req, res) => {
    var attachment = req.file
      ? await File.createNewInstance(req.file, req.user._id)
      : undefined;

    req.body.postImgURL =
      process.env.SERVER_URL + "files/" + attachment.serverFileName;
    req.body.uploader = req.user._id;

    Post.create(req.body).then((post) => {
      if (attachment) {
        attachment.postId = post._id;
        attachment.save();
      }
      return res.status(200).json({
        isSuccess: true,
        code: 1000,
        message: "성공",
        result: post._id,
      });
    });
  }
);

router.get("/", (req, res) => {
  Post.find({})
    .sort("-createdAt")
    .populate({ path: "uploader" })
    .then((posts) => {
      return res.status(200).json({
        isSuccess: true,
        code: 1000,
        message: "성공",
        result: posts,
      });
    })
    .catch((err) => {
      return res.json(err);
    });
});

router.post("/");

module.exports = router;
