const express = require("express");
const jwt = require("jsonwebtoken");
const kakaoAuth = require("../utils/KakaoAuth");
const User = require("../models/User");
const util = require("../utils/util");
const { compareSync } = require("bcrypt");

const router = express.Router();

// router.post("/kakao", async (req, res) => {
//   try {
//     let userEmail = "";
//     let userNickName = "";

//     if (req.body.access_token) {
//       const result = await kakaoAuth.getProfile(req.body.access_token);
//       const kakaoUser = JSON.parse(result).kakao_account;
//       userEmail = kakaoUser.email;
//       userNickName = kakaoUser.profile.nickname;
//     } else {
//       const user = jwt.verify(
//         req.headers.authorization,
//         process.env.JWT_SECRET,
//         {
//           ignoreExpiration: true,
//         }
//       );
//       userEmail = user.email;
//     }

//     let responseData = {
//       success: true,
//       user: "",
//     };

//     if (req.body.access_token) {
//       const token = jwt.sign(
//         {
//           id: user.id,
//           email: userEmail,
//         },
//         process.env.JWT_SECRET,
//         {
//           issuer: "jaeuk",
//         }
//       );
//       responseData = token;
//     }
//   } catch (err) {
//     return res.status(500).json({
//       isSuccess: false,
//       code: 500,
//       message: "실패",
//       result: err.toString(),
//     });
//   }
// });

router.post("/register", (req, res) => {
  User.create(req.body)
    .then((user) => {
      return res.status(200).json({
        isSuccess: true,
        code: 200,
        message: "계정 생성 완료",
        result: {
          user: {
            id: user._id,
            email: user.email,
          },
        },
      });
    })
    .catch((err) => {
      return res.status(200).json({
        isSuccess: false,
        code: 200,
        message: "계정 생성 실패",
        result: util.parseError(err),
      });
    });
});

router.post("/login", (req, res) => {
  User.findOne({ email: req.body.email })
    .select({ email: 1, password: 1 })
    .then((user) => {
      console.log(user);
      if (!user || !compareSync(req.body.password, user.password)) {
        return res.status(401).json({
          isSuccess: false,
          code: 401,
          message: "아이디 혹은 비밀번호가 틀림",
        });
      }

      const payload = {
        username: user.username,
        id: user._id,
      };

      const token = jwt.sign(payload, process.env.JWT_PRIVATE, {
        expiresIn: "1d",
      });

      return res.status(200).json({
        isSuccess: true,
        code: 200,
        message: "로그인 완료",
        result: {
          token: "Bearer " + token,
        },
      });
    });
});

module.exports = router;
