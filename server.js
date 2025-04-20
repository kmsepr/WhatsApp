const fs = require('fs');
const express = require('express');
const { Client, LocalAuth } = require('whatsapp-web.js');
const qrcode = require('qrcode-terminal');
const app = express();

const client = new Client({
    authStrategy: new LocalAuth()
});

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Show QR code in terminal
client.on('qr', (qr) => {
    console.log('Scan the QR Code below to login:');
    qrcode.generate(qr, { small: true });
});

// Ready event
client.on('ready', () => {
    console.log('WhatsApp client is ready!');
});

// Send message via POST /send
app.post('/send', async (req, res) => {
    const number = req.body.number + '@c.us';
    const message = req.body.message;
    try {
        await client.sendMessage(number, message);
        res.send('Message sent!');
    } catch (err) {
        res.status(500).send('Failed to send: ' + err.message);
    }
});

// Optional: Serve HTML form
app.get('/', (req, res) => {
    res.send(`
        <h2>Send WhatsApp Message</h2>
        <form method="POST" action="/send">
            <label>Phone Number:<br/>
            <input type="text" name="number" /></label><br/><br/>
            <label>Message:<br/>
            <textarea name="message" rows="5" cols="30"></textarea></label><br/><br/>
            <input type="submit" value="Send" />
        </form>
    `);
});

client.initialize();

const PORT = process.env.PORT || 80;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
