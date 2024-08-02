# asr_app
**Flutter Front End for "Bako: Voice-based Reading Assistance".**

Bako Reading App is a mobile application designed to help users (particularly kids) improve their pronunciation and reading skills in the Bambara language. 
The application allows users to record themselves while reading a book from [RobotsMali's Interactive children books](https://bloomlibrary.org/RobotsMali/) and then receive feedback on their pronunciation.
The application is based on an Automatic Speech Recognition Model trained by [oza-dev](https://huggingface.co/oza75)

## Key Features:
- Voice Recording: Users can start and stop recording their voice by pressing a microphone button. An application state indicates whether recording is in progress or if a recording is available for playback. 
- Playback and Correction: After recording, the user can listen to their recording by pressing a playback button. The application provides feedback on the user's reading, highlighting correctly pronounced words and offering a score at the end of each book/lesson.

## User Interface (UI):
A simple and clean interface with clear buttons for recording, playback, and sending recordings for the ASR model to transcript.
The application uses a drawer (side menu) to offer simple navigation to other parts of the application.

## Getting Started