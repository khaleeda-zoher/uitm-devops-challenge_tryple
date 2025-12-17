const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const { prisma } = require('../config/database');

// POST create alert
router.post('/', async (req, res) => {
  console.log('ALERT BODY:', req.body);
  console.log('ALERT USER:', req.user);

  try {
    const { userId, type, message } = req.body;

    if (!userId || !type || !message) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields',
      });
    }

    const alert = await prisma.alert.create({
      data: { user_id: userId, type, message },
    });

    res.json({ success: true, data: alert });
  } catch (err) {
    console.error('Create alert error:', err);
    res.status(500).json({ success: false, message: 'Failed to create alert' });
  }
});

// GET all alerts (with JWT check)
router.get('/', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res.status(401).json({ success: false, message: 'No token provided' });
    }

    const token = authHeader.replace('Bearer ', '');
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    if (decoded.role !== 'ADMIN') {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const alerts = await prisma.alert.findMany({
      orderBy: { created_at: 'desc' },
    });

    res.status(200).json({
      success: true,
      data: alerts,
    });
  } catch (err) {
    console.error('Get alerts error:', err);
    res.status(500).json({ success: false, message: 'Failed to fetch alerts' });
  }
});

module.exports = router;
