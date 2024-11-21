
# HexaSwift App

**HexaSwift** is a mobile application designed to remotely control a hexapod robot using a user-friendly interface. The app allows seamless connectivity and control through various features, ensuring a smooth and interactive robotics experience.

## Features

- **Remote Control**: Intuitive controls to navigate the hexapod robot.
- **Real-Time Connection**: Establish a connection to the robot and interact with it in real time.
- **Customizable Actions**: Program movements such as dance routines or specific maneuvers.
- **Feedback and Help**: Built-in support for user feedback and help documentation.
- **Livestream**: Monitor the robot's surroundings through integrated live streaming.

## Folder Structure

The project is organized as follows:

```
/lib
  - connection_page.dart    # Handles device connectivity setup
  - control_page.dart       # Main control interface for robot navigation
  - dance.dart              # Customizable dance routine controls
  - feedback.dart           # Manages user feedback
  - help.dart               # Help and support page
  - livestream.dart         # Live video streaming integration
  - login_page.dart         # User authentication interface
  - main.dart               # Application entry point
  - mainpage.dart           # Main dashboard of the app
  - tunisia.dart            # Regional customization module
  - welcome_page.dart       # Introductory welcome page
/server
  - app.py                  # Backend logic for API handling
  - routes.js               # Defines API endpoints
  - server.js               # Node.js server configuration
  - user.js                 # User authentication and management
  - file.env                # Environment variables
```

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/hexaswift.git
   cd hexaswift
   ```

2. Install dependencies:
   - For the server:
     ```bash
     cd server
     npm install
     ```
   - For the app:
     Use Flutter to manage dependencies:
     ```bash
     flutter pub get
     ```

3. Configure the environment file:
   Update the `file.env` with your API keys and configurations.

4. Run the app:
   - Start the server:
     ```bash
     cd server
     node server.js
     ```
   - Run the Flutter app:
     ```bash
     flutter run
     ```

## Usage

1. Launch the app and log in using the authentication screen.
2. Establish a connection with your hexapod robot using the **Connection Page**.
3. Control the robot through the **Control Page** or choose a predefined routine like **Dance**.
4. View live feedback and submit user feedback through the app.

## Requirements

- **Flutter SDK**: Version 3.x or higher
- **Node.js**: Version 14.x or higher
- **Hexapod Robot**: Compatible hardware
- **Dependencies**: See `pubspec.yaml` for Dart dependencies and `package.json` for server dependencies.

## Contributing

Contributions are welcome! Feel free to fork the repository, create a feature branch, and submit a pull request.  

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
