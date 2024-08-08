# asr_app

**Flutter Front End for "Bako: Voice-based Reading Assistance".**

Bako Reading App is a mobile application designed to help users (particularly kids) improve their pronunciation and reading skills in the Bambara language. The application allows users to record themselves while reading a book from [RobotsMali's Interactive children books](https://bloomlibrary.org/RobotsMali/) and then receive feedback on their pronunciation. The application is based on an Automatic Speech Recognition Model trained by [oza-dev](https://huggingface.co/oza75).

## Key Features

- **CRUD:** Classical interface to Create, Update and Delete ReaderUsers
- **Voice Recording:** Users can start and stop recording their voice by pressing a microphone button. An application state indicates whether recording is in progress or if a recording is available for playback.
- **Playback and Correction:** After recording, the user can listen to their recording by pressing a playback button. 
- **ASR assisted reading evaluation:** The application provides feedback on the user's reading, highlighting correctly pronounced words and offering a score at the end of each book/lesson.
- **eGafew:** Include RobotsMali's eGafew

## User Interface (UI)

A simple and clean interface with clear buttons for recording, playback, and sending recordings for the ASR model to transcribe. The application uses a drawer (side menu) to offer simple navigation to other parts of the application.

## Getting Started

### Prerequisites

- Ensure you have Flutter installed. Follow the instructions at [Flutter Installation](https://flutter.dev/docs/get-started/install) to set it up on your machine.
- You'll need an Android or iOS device/emulator for running the app or a physical device for even better experience.
- BakoAPI Backend: Ensure that BakoAPI Django backend is running on a local server (This will not be needed once BakoAPI is deployed)

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com//mohpython/asr_app.git
   cd asr_app
   ```

2. **Install dependencies:**

   Run the following command in the project directory to install dependencies:

   ```bash
   flutter pub get
   ```

3. **Run the application:**

   Connect your device or start an emulator and run:

   ```bash
   flutter run
   ```

### Dependencies

This project uses the following Flutter dependencies:

- **cupertino_icons:** ^1.0.6 for iOS style icons.
- **shared_preferences:** ^2.0.13 for storing simple data on the device.
- **http:** ^1.2.0 for making network requests.
- **audioplayers:** ^5.2.1 for audio playback.
- **record:** ^4.4.4 for audio recording functionality.
- **collection:** ^1.18.0 for collections utilities.

### Directory Structure

The key directories and files in the project are:

- **lib/main.dart:** Entry point of the application.
- **lib/home.dart:** Home screen UI and logic.
- **lib/login.dart:** User login functionality.
- **lib/signup.dart:** User signup functionality.
- **lib/profile_page.dart:** User profile management.
- **lib/lesson_screen.dart:** UI and logic for reading sessions.
- **lib/test_model_api.dart:** Integration with the ASR model API.
- **lib/bako_api:** Contains API interaction logic:
    - `user.dart`: User-related API functions.
    - `asr_model.dart`: Function to infer the ASR model.
    - `lesson.dart`: Lesson-related API functions.

### Assets

The application includes the following assets:

- **assets/books/books.json:** JSON file containing book data.
- **assets/Thumbnails/:** Directory containing image assets for thumbnails.

## Contributing

If you'd like to contribute to this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Make your changes and commit them (`git commit -m 'Add YourFeature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```
