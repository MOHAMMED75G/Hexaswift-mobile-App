from flask import Flask, request, jsonify
from flask_bcrypt import Bcrypt
from flask_cors import CORS
import pymongo
import jwt

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Connect to MongoDB
client = pymongo.MongoClient("mongodb+srv://mohamedgharab:helloworld@cluster0.tfqpsea.mongodb.net/?retryWrites=true&w=majority")
db = client["cluster0"]
users_collection = db["users"]

bcrypt = Bcrypt(app)

# Secret key for JWT
app.config['SECRET_KEY'] = 'helloworld'

# Signup route
@app.route('/signup', methods=['POST'])
def signup():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({'message': 'Username and password are required'}), 400

    existing_user = users_collection.find_one({'username': username})
    if existing_user:
        return jsonify({'message': 'Username already exists'}), 400

    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    users_collection.insert_one({'username': username, 'password': hashed_password})
    return jsonify({'message': 'User registered successfully'}), 200

# Login route
@app.route('/login', methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    if not username or not password:
        return jsonify({'message': 'Username and password are required'}), 400

    user = users_collection.find_one({'username': username})
    if not user or not bcrypt.check_password_hash(user['password'], password):
        return jsonify({'message': 'Invalid credentials'}), 400

    token = jwt.encode({'userId': str(user['_id'])}, app.config['SECRET_KEY'])
    return jsonify({'token': token}), 200


if __name__ == '__main__':
    app.run(debug=True)
