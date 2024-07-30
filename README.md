# asr_app

Flutter Front End for Bako: Voice-based Reading Assistance

## Getting Started

BambaraASR is a mobile application designed to help users improve their pronunciation and reading of phrases in the Bambara language. The application allows users to record their voice while reading a phrase displayed on the screen and then receive feedback on their pronunciation.

Key Features
Voice Recording:

Users can start and stop recording their voice by pressing a microphone button.
An application state indicates whether recording is in progress or if a recording is available for playback.
Playback and Correction:

After recording, the user can listen to their recording by pressing a playback button.
The application provides feedback on the user's reading, highlighting correctly pronounced words and offering corrections for those that are not.
User Interface (UI):

A simple and clean interface with clear buttons for recording, playback, and sending recordings.
The application uses a drawer (side menu) to offer simple navigation to other parts of the application.
Technical Components
State Management: The application state is managed with state variables in the widgets, allowing the user interface to change based on user actions (e.g., starting/stopping recording, displaying corrections).
