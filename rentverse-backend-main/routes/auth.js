// backend/routes/auth.js (or wherever your login route is)
import express from 'express';
import bcrypt from 'bcrypt';
import db from '../prisma/client.js'; // or your database client
import jwt from 'jsonwebtoken';

const router = express.Router();

const generateJwt = (user) => {
  return jwt.sign(
    {
      id: user.id,
      email: user.email,
      role: user.role,
    },
    process.env.JWT_SECRET,
    { expiresIn: '7d' }
  );
};


router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await db.users.findUnique({ where: { email } });
    if (!user) return res.status(401).json({ message: 'Invalid credentials' });

    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(401).json({ message: 'Invalid credentials' });

    // Generate JWT token or return user info
    const token = generateJwt(user); // your JWT function
    res.json({ token, role: user.role });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

export default router;
