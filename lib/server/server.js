const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const app = express();
const port = 5000;

app.use(bodyParser.json());

mongoose.connect('mongodb+srv://mohamedgharab:helloworld@cluster0.tfqpsea.mongodb.net/?retryWrites=true&w=majority', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
})
  .then(() => console.log('Connected to MongoDB'))
  .catch(err => console.error('Error connecting to MongoDB:', err));

const userSchema = new mongoose.Schema({
  username: { type: String, unique: true, required: true },
  password: { type: String, required: true },
});

const User = mongoose.model('User', userSchema);

app.post('/signup', async (req, res) => {
  console.log('Request received:', req.body); 
  const { username, password } = req.body;
  
  if (!username || !password) {
    console.log( password);
    return res.status(400).send({ message: 'Username and password are required' });
   
  }
  
  try {
    const existingUser = await User.findOne({ username });
    if (existingUser) {
      
      return res.status(400).send({ message: 'Username already exists' });
    }
    
    const hashedPassword = await bcrypt.hash(password, 10);
    const user = new User({ username, password: hashedPassword });
    await user.save();
    console.log(`User registered successfully: ${username}`);
    res.status(200).send({ message: 'User registered successfully' });
  } catch (error) {
    console.error('Error during user registration:', error);
    res.status(400).send({ message: 'User registration failed', error });
  }
});

app.post('/api/login', async (req, res) => {
  const { username, password } = req.body;
  
  if (!username || !password) {
    return res.status(400).send({ message: 'Username and password are required' });
  }

  try {
    const user = await User.findOne({ username });
    if (!user) {
      return res.status(400).send({ message: 'User not found' });
    }
    
    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(400).send({ message: 'Invalid credentials' });
    }

    const token = jwt.sign({ userId: user._id }, 'your_jwt_secret', { expiresIn: '1h' });
    res.status(200).send({ token });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(400).send({ message: 'Login failed', error });
  }
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
