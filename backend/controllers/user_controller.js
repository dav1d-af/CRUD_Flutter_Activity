const Student = require('../models/student_schema');

// Create a user
exports.createUser = async (req, res) => {
  try {
    const newStudent = new Student(req.body);
    const savedStudent = await newStudent.save();
    res.status(200).json({ message: `Record of ${savedStudent.firstName} ${savedStudent.lastName} has been added.`, data: savedStudent });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: error.message });
  }
};

// List all users for a specific year
exports.getYearUsers = async (req, res) => {
  const { year } = req.query;
  if (!year) {
    return res.status(400).json({ error: 'Year query parameter is required' });
  }
  const validYears = [1, 2, 3, 4, 5];
  if (!validYears.includes(parseInt(year))) {
    return res.status(400).json({ error: 'Invalid year parameter. Must be between 1 and 5.' });
  }
  try {
    const students = await Student.find({ year: parseInt(year) });
    res.status(200).json(students);
  } catch (error) {
    console.error('Query error:', error);
    res.status(500).json({ error: 'Database query error' });
  }
};

// List all users
exports.getAllUsers = async (req, res) => {
  try {
    const students = await Student.find();
    res.status(200).json(students);
  } catch (error) {
    console.error('Query error:', error);
    res.status(500).json({ error: 'Database query error' });
  }
};

// Update a user by ID
exports.updateUser = async (req, res) => {
  try {
    const { id } = req.params; 
    const updatedData = req.body; 

    const result = await Student.findByIdAndUpdate(id, updatedData, { new: true });

    if (!result) {
      return res.status(404).json({ error: 'Student not found' });
    }

    res.status(200).json({ message: 'Student updated successfully', data: result });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Database update error' });
  }
};



// Delete a user by ID
exports.deleteUser = async (req, res) => {
  try {
    const { id } = req.params;
    console.log(id);
    const result = await Student.findByIdAndDelete(id);
    
    if (!result) {
      return res.status(404).json({ error: 'Student not found' });
    }

    res.status(200).json({ message: 'Student deleted successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Database delete error' });
  }
};



