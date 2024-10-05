const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const session = require('express-session');
const authRoutes = require('./routes/authRoutes');
const profileRoutes = require('./routes/profileRoutes');

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(session({
  secret: 'your_secret_key',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false } // Set `secure: true` if using HTTPS
}));

// Routes
app.use('/api/auth', authRoutes);
app.use('/api', profileRoutes);

module.exports = app;
