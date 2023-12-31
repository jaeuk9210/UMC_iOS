const mongoose = require("mongoose");
const bcrypt = require("bcrypt");

var userSchema = mongoose.Schema(
  {
    username: {
      type: String,
      required: [true, "Username is required!"],
      match: [/^.{4,12}$/, "Should be 4-12 characters!"],
      trim: true,
      unique: true,
    },
    password: {
      type: String,
      required: [true, "Password is required!"],
      select: false,
    },
    name: {
      type: String,
      required: [true, "Name is required!"],
      match: [/^.{2,12}$/, "Should be 2-12 characters!"],
      trim: true,
    },
    email: {
      type: String,
      required: [true, "Email is required!"],
      match: [
        /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,
        "Should be a vaild email address!",
      ],
      trim: true,
    },
  },
  {
    toObject: { virtuals: true },
    versionKey: false,
  }
);

userSchema
  .virtual("originalPassword")
  .get(function () {
    return this._originalPassword;
  })
  .set(function (value) {
    this._originalPassword = value;
  });

userSchema
  .virtual("currentPassword")
  .get(function () {
    return this._currentPassword;
  })
  .set(function (value) {
    this._currentPassword = value;
  });

userSchema
  .virtual("newPassword")
  .get(function () {
    return this._newPassword;
  })
  .set(function (value) {
    this._newPassword = value;
  });

var passwordRegex = /(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
var passwordRegexErrorMessage =
  "Should be minimum 8 characters of alphabet and number combination!";
userSchema.path("password").validate(function (v) {
  var user = this;

  if (user.isNew) {
    if (!passwordRegex.test(user.password)) {
      user.invalidate("password", passwordRegexErrorMessage);
    }
  }

  if (!user.isNew) {
    if (!user.currentPassword) {
      user.invalidate("currentPassword", "Current Password is required!");
    } else if (
      !bcrypt.compareSync(user.currentPassword, user.originalPassword)
    ) {
      user.invalidate("currentPassword", "Current Password is invalid!");
    }

    if (user.newPassword && !passwordRegex.test(user.newPassword)) {
      user.invalidate("newPassword", passwordRegexErrorMessage);
    }
  }
});

userSchema.pre("save", function (next) {
  var user = this;
  if (!user.isModified("password")) {
    return next();
  } else {
    user.password = bcrypt.hashSync(user.password, 10);
    return next();
  }
});

userSchema.methods.authenticate = function (password) {
  var user = this;
  return bcrypt.compareSync(password, user.password);
};

var User = mongoose.model("user", userSchema);
module.exports = User;
