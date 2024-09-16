const express = require('express');
const router = express.Router();
const userController = require('../controllers/user_controller');

//user routes
router.post('/insertUser', userController.createUser);
router.get('/listUsers', userController.getYearUsers);
router.get('/listAllUsers', userController.getAllUsers);
// router.get('/profile/:id', userController.getUserProfile);
router.put('/updateUser/:id', userController.updateUser);
router.delete('/deleteUser/:id', userController.deleteUser);

module.exports = router;