exports.getProfile = (req, res) => {
    if (req.session.user) {
      res.status(200).json(req.session.user);
    } else {
      res.status(401).json({ error: 'User not logged in' });
    }
  };
  