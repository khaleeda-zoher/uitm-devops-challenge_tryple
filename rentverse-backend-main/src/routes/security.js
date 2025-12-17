const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const { prisma } = require('../config/database');

router.get('/logs', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader) {
      return res
        .status(401)
        .json({ success: false, message: 'No token provided' });
    }

    const token = authHeader.replace('Bearer ', '');
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    if (decoded.role !== 'ADMIN') {
      return res.status(403).json({ success: false, message: 'Unauthorized' });
    }

    const logs = await prisma.security_logs.findMany({
      orderBy: {
        created_at: 'desc', // ✅ FIXED
      },
    });

    res.status(200).json({
      success: true,
      data: logs,
    });
  } catch (err) {
    console.error('Get logs error:', err);
    res.status(500).json({ success: false, message: 'Failed to fetch logs' });
  }
});

module.exports = router;
