const { prisma } = require('../config/database');

async function logSecurityEvent({
  userId,
  action,
  status,
  ipAddress,
  userAgent,
}) {
  return prisma.securityLog.create({
    data: {
      user_id: userId,
      action,
      status,
      ip_address: ipAddress,
      user_agent: userAgent,
    },
  });
}

module.exports = { logSecurityEvent };
