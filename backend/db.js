const mongoose = require('mongoose');
require('dotenv').config();

const mongoURI = "mongodb+srv://general_user:ishkolarium2024@cluster0.hhmgu.mongodb.net/crud_activity?retryWrites=true&w=majority&appName=Cluster0";
console.log("MongoDB URI:", mongoURI);


const connectDB = async () => {
  try {
    await mongoose.connect(mongoURI, {
      serverSelectionTimeoutMS: 20000,
    });
    console.log("MongoDB connected successfully");
  } catch (err) {
    console.error("Error connecting to MongoDB:", err.message);
    process.exit(1);
  }
};

module.exports = connectDB;
