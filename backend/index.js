// imports
require('dotenv').config();
const express = require('express');
const bodyParser = require('body-parser');
const userRoutes = require('./routes/user_routes');
const connectDB = require('./db');
const app = express();

connectDB();
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Use routes
app.use('/api', userRoutes);

const port = 3000;
app.listen(port,() => {
  console.log(`Server is running on ${port}`);
});
