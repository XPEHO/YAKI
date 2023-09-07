const rateLimiter = require("express-rate-limit");
const envMode = process.env.NODE_ENV; 
export const limiter = rateLimiter({
    max: (envMode === 'karate') ? 300: 10,
    windowMS: 10000, // 10 seconds
    message: "You can't make any more requests at the moment. Try again later",
});
 
export const signInLimiter = rateLimiter({
    max: (envMode === 'karate') ? 300: 3,
    windowMS: 10000, //10 seconds
    message: "Too many sign-in attempts. Try again later."
})
//if we are in a karate env we set the limit to 1000 to allow karate testing to spam requests.
  