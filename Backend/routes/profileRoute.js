// const express = require('express');
// const router = express.Router();
// const jwt = require('jsonwebtoken');
// const User = require('../models/User'); // Adjust path as needed

// // Middleware to authenticate token
// const authenticateToken = (req, res, next) => {
//   const authHeader = req.headers['authorization'];
//   const token = authHeader && authHeader.split(' ')[1];

//   if (token == null) return res.sendStatus(401);

//   jwt.verify(token, 'Dhanush', (err, user) => {
//     if (err) return res.sendStatus(403);
//     req.user = user;
//     next();
//   });
// };

// // Profile route
// router.get('/profile', authenticateToken, async (req, res) => {
//   try {
//     const user = await User.findById(req.user.userId);
//     if (!user) return res.status(404).json({ error: 'User not found' });

//     res.status(200).json({
//       firstName: user.firstName,
//       lastName: user.lastName,
//       email: user.email,
//       mobile: user.mobile,
//       uniqueCode: user.uniqueCode,
//     });
//   } catch (err) {
//     res.status(500).json({ error: 'Server error' });
//   }
// });

// module.exports = router;
