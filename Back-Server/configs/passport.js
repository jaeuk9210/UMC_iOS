const { Strategy: JWTStrategy, ExtractJwt } = require("passport-jwt");
const User = require("../models/User");
const passport = require("passport");

var opts = {};

opts.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
opts.secretOrKey = process.env.JWT_PRIVATE;

passport.use(
  new JWTStrategy(opts, (jwt_payload, done) => {
    console.log(jwt_payload);
    User.findOne({ _id: jwt_payload.id })
      .then((user) => {
        if (user) {
          return done(null, user);
        } else {
          return done(null, false);
        }
      })
      .catch((err) => {
        if (err) {
          return done(err, false);
        }
      });
  })
);
