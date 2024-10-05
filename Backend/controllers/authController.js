const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');

// Generate the next unique code
const generateUniqueCode = async () => {
  try {
    const latestCode = await User.findOne().sort({ uniqueCode: -1 });
    if (latestCode) {
      return (parseInt(latestCode.uniqueCode) + 1).toString().padStart(6, '0');
    }
    return '123456';
  } catch (err) {
    console.error('Error generating unique code:', err);
    return '123456';
  }
};

// Register user
exports.register = async (req, res) => {
  const { firstName, lastName, email, username, password, mobile } = req.body;

  if (!firstName || !lastName || !email || !username || !password || !mobile) {
    return res.status(400).json({ error: 'Please fill in all fields' });
  }

  try {
    const existingUser = await User.findOne({ $or: [{ email }, { username }] });
    if (existingUser) {
      return res.status(409).json({ error: 'User already exists' });
    }

    const uniqueCode = await generateUniqueCode();
    const hashedPassword = await bcrypt.hash(password, 10);

    const newUser = new User({
      firstName,
      lastName,
      email,
      username,
      password: hashedPassword,
      mobile,
      uniqueCode,
    });

    await newUser.save();
    res.status(201).json({ message: 'User registered successfully' });
  } catch (err) {
    console.error('Error saving user:', err);
    res.status(500).json({ error: 'Failed to register user' });
  }
};

// Login user
exports.login = async (req, res) => {
  const { username, password } = req.body;

  if (!username || !password) {
    return res.status(400).json({ error: 'Username and password are required' });
  }

  try {
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ error: 'Invalid username or password' });
    }

    const token = jwt.sign({ userId: user._id }, 'Dhanush', { expiresIn: '1h' });
    req.session.user = {
      id: user._id,
      username: user.username,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      mobile: user.mobile,
      uniqueCode: user.uniqueCode,
    };

    res.status(200).json({ message: 'Login successful', token });
  } catch (err) {
    res.status(500).json({ error: 'Failed to login' });
  }
};
