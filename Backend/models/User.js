const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  firstName: String,
  lastName: String,
  email: { type: String, unique: true },
  username: { type: String, unique: true },
  password: String,
  mobile: String,
  uniqueCode: { type: String, unique: true },
});

module.exports = mongoose.model('User', userSchema);
