const mongoose = require('mongoose');

const studentSchema = new mongoose.Schema({
  firstName: { type: String, required: true },
  lastName: { type: String, required: true },
  course: { type: String, required: true },
  year: { type: Number, required: true },
  enrolled: { type: Boolean, default: true },
});

// Export the model
module.exports = mongoose.model('Student', studentSchema);
