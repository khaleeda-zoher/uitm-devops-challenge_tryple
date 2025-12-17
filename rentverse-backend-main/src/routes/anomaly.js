const express = require('express');
const router = express.Router();
const { prisma } = require('../config/database');
const jwt = require('jsonwebtoken');
//import { logActivity } from '../services/activity.service.js';


// Simple anomaly detection rules
function detectAnomaly(activity) {
  const { activityType, metadata } = activity;

  // Example rule: LOGIN from unusual IP
  if (activityType === 'LOGIN' && metadata.ip !== '127.0.0.1') {
    return { 
        message: 'Login from unusual IP detected',
        severity: 'HIGH', // add severity here
        payload: metadata 
    };

  }

  // Example rule: more rules can be added here
  return null;
}


function getSeverity(activityType) {
  switch (activityType) {
    case 'LOGIN_FAILURE':
      return 'HIGH';
    case 'LOGIN':
      return 'MEDIUM';
    default:
      return 'LOW';
  }
}


// POST /security/anomaly
router.post('/', async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader) return res.status(401).json({ success: false, message: 'No token provided' });

    const token = authHeader.replace('Bearer ', '');
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    if (decoded.role !== 'ADMIN') return res.status(403).json({ success: false, message: 'Unauthorized' });

    const { userId, activityType, timestamp, metadata } = req.body;

    // Detect anomaly
    const alertMessage = detectAnomaly({ activityType, metadata });

    let createdAlert = null;
    if (alertMessage) {
      /*createdAlert = await prisma.alert.create({
        data: {
          user_id: userId,
          type: 'SECURITY',
          message: alertMessage,
        },
      });*/

      createdAlert = await prisma.alert.create({
        data: {
          user_id: userId,
          type: 'SECURITY',
          message: alertMessage,
          severity: getSeverity(activityType),
          payload: metadata, // store full details
        },
      });

    }

    /*res.json({
      success: true,
      status: alertMessage ? 'ANOMALY_DETECTED' : 'NORMAL',
      alert: createdAlert,
    });*/

    res.json({
      success: true,
      status: alertMessage ? 'ANOMALY_DETECTED' : 'NORMAL',
      alert: createdAlert,
      notification: alertMessage
      ? {
        message: alertMessage,
        severity: createdAlert.severity
        }
      : null
    });


  } catch (err) {
    console.error('Anomaly detection error:', err);
    res.status(500).json({ success: false, message: 'Failed to process anomaly' });
  }
});

module.exports = router;
