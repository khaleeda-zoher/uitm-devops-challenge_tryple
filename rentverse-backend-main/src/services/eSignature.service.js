const axios = require('axios');

/**
 * Generate e-signature QR code
 * @param {Object} params
 * @param {string} params.leaseId
 * @param {string} params.role
 * @param {string} params.name
 * @param {string} params.timestamp
 */
async function getSignatureQRCode({ leaseId, role, name, timestamp }) {
  console.log('ESIGN INPUT:', { leaseId, role, name, timestamp });

  if (!leaseId) {
    throw new Error('leaseId is required');
  }

  const esignUrl = process.env.E_SIGNATURE_API_URL;

  // 🔁 Fallback: no API configured → return null
  if (!esignUrl) {
    console.warn('⚠️ E-signature API not configured, skipping QR generation');
    return null;
  }

  try {
    const response = await axios.post(
      esignUrl,
      {
        leaseId,
        role,
        name,
        timestamp: timestamp || new Date().toISOString(),
      },
      {
        timeout: 10000,
        headers: {
          'Content-Type': 'application/json',
        },
      }
    );

    return response.data?.qrCode || null;
  } catch (error) {
    console.error('E-signature API error:', error.message);
    return null; // allow PDF generation to continue
  }
}

module.exports = { getSignatureQRCode };
