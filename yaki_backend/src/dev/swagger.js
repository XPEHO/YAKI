"use strict";
const swaggerAutogen = require('swagger-autogen')();
const doc = {
    openapi: 3.0.0,
    info: {
        title: 'Node API YAKI',
        description: 'Working localization delcaration app',
    },
    host: 'localhost:3000',
    schemes: ['http'],
};
const outputFile = './swagger.json';
const endpointsFiles = ['./src/server.ts'];
/* NOTE: if you use the express Router, you must pass in the
   'endpointsFiles' only the root file where the route starts,
   such as index.js, app.js, routes.js, ... */
swaggerAutogen(outputFile, endpointsFiles, doc);
