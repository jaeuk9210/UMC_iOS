const mongoose = require("mongoose");

var postSchema = mongoose.Schema(
  {
    uploader: {
      type: mongoose.Schema.Types.ObjectId,
      ref: "user",
      required: true,
    },
    content: {
      type: String,
      required: [true, "You need to input the content."],
    },
    postImgURL: { type: String },
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date },
  },
  { versionKey: false }
);

var Post = mongoose.model("post", postSchema);
module.exports = Post;
