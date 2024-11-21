// routes.js

const express = require('express');
const router = express.Router();
const raspividStream = require('raspivid-stream');

router.post('/control', async (req, res) => {
    try {
      const { command } = req.body;
      if (!command) {
        throw new Error('Command is missing in the request body');
      }
      console.log('Received command:', command);
      // Implement your hexapod control logic here
      // For now, we'll just log the command received
      res.status(200).json({ message: 'Command received', command });
    } catch (err) {
      console.log('Error:', err);
      res.status(400).json({ error: err.message });
    }
  });
  router.get('/camera-feed', (req, res) => {
    // Set headers for MJPEG stream
    res.writeHead(200, {
      'Content-Type': 'multipart/x-mixed-replace; boundary=--myboundary',
      'Connection': 'close',
      'Pragma': 'no-cache',
      'Cache-Control': 'no-cache',
      'Expires': '0',
    });
  
    // Create raspivid stream and pipe it to the response
    const stream = raspividStream();
    stream.on('data', (data) => {
      res.write('--myboundary\r\n');
      res.write('Content-Type: image/jpeg\r\n');
      res.write(`Content-Length: ${data.length}\r\n`);
      res.write('\r\n');
      res.write(data, 'binary');
      res.write('\r\n');
    });
  });
module.exports = router;
