import prisma from '../prisma/client.js';

export async function createAlert({
  userId,
  severity,
  message,
  ruleKey
}) {
  return prisma.alert.create({
    data: {
      user_id: userId,
      severity,
      message,
      rule_key: ruleKey,
      resolved: false
    }
  });
}
