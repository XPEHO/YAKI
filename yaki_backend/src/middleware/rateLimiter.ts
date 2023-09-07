const rateLimiter = require("express-rate-limit");
 
export const limiter = rateLimiter({
    max: 10,
    windowMS: 10000, // 10 seconds
    message: "You can't make any more requests at the moment. Try again later",
});
 
export const signInLimiter = rateLimiter({
    max: 3,
    windowMS: 10000, //10 seconds
    message: "Too many sign-in attempts. Try again later."
})
 
  