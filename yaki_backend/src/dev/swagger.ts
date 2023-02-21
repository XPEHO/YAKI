require('dotenv').config()
const swaggerAutogen = require('swagger-autogen')();

const doc = {

  info: {
    version: "1.0.0",
    title: 'Node API YAKI',
    description: 'Working localization delcaration app',
  },
  host: `${process.env.Swagger_host}`,
  schemes: [`${process.env.Swagger_schemes}`],
};

const outputFile = './src/dev/swagger.json';
const endpointsFiles = ['./src/server.ts'];

/* NOTE: if you use the express Router, you must pass in the 
   'endpointsFiles' only the root file where the route starts,
   such as index.js, app.js, routes.js, ... */

swaggerAutogen(outputFile, endpointsFiles, doc);