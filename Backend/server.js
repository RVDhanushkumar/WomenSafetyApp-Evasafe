const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const session = require('express-session');

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(session({
  secret: 'bf11ae1bf9487788ff385bd5f046592d0e88d0a289dc8ec542a178982cb960b99c759b64e0b8bcfb3ce679abb68a3608913fde6317aadc5c43cc6a63dc101f39', // Change this to a strong secret key
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // Set secure: true if using HTTPS
}));

// Connect to MongoDB
const connectDB = async () => {
  try {
    await mongoose.connect('mongodb://localhost:27017/User_data', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB connected');
  } catch (err) {
    console.error('MongoDB connection failed:', err.message);
    process.exit(1);
  }
};

connectDB();

// Define User schema
const userSchema = new mongoose.Schema({
  firstName: String,
  lastName: String,
  email: { type: String, unique: true },
  username: { type: String, unique: true },
  password: String,
  mobile: String,
  uniqueCode: { type: String, unique: true },
});

const User = mongoose.model('User', userSchema);

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

// Register route
app.post('/register', async (req, res) => {
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

    // Hash the password
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
});

// Login route
app.post('/login', async (req, res) => {
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

    // Store user data in session
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
});

// Profile route
app.get('/profile', (req, res) => {
  if (req.session.user) {
    res.status(200).json(req.session.user);
  } else {
    res.status(401).json({ error: 'User not logged in' });
  }
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});