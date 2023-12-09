# Remind - Reminder Application

[Watch Demo Video](https://iiitbac-my.sharepoint.com/:v:/g/personal/laxmi_sreenivas_iiitb_ac_in/EQNFL69VSXZDpKwLt82ZiMkBbLlJq5xRXC9OPTgh1FQD5Q?nav=eyJyZWZlcnJhbEluZm8iOnsicmVmZXJyYWxBcHAiOiJPbmVEcml2ZUZvckJ1c2luZXNzIiwicmVmZXJyYWxBcHBQbGF0Zm9ybSI6IldlYiIsInJlZmVycmFsTW9kZSI6InZpZXciLCJyZWZlcnJhbFZpZXciOiJNeUZpbGVzTGlua0NvcHkifX0&e=fYsPe9)

## Table of Contents
- [Project Overview](#project-overview)
- [Problem Definition](#problem-definition)
- [Project Analysis](#project-analysis)
  - [Login/Signup Screen](#login-signup-screen)
  - [Profile Page](#profile-page)
  - [Home Screen](#home-screen)
  - [Events Screen](#events-screen)
  - [Add Events Screen](#add-events-screen)
- [Setup](#setup)
  - [Prerequisites](#prerequisites)
  - [Clone the Repository](#clone-the-repository)
  - [Get Dependencies](#get-dependencies)
  - [USB Debugging](#usb-debugging)
  - [Run the App](#run-the-app)
  - [Build the App](#build-the-app)
- [References](#references)

## Project Overview

Welcome to Remind, a reminder application developed by B Laxmi Sreenivas. This project is hosted on GitHub at [https://github.com/Laxmi-Sreenivas/remind](https://github.com/Laxmi-Sreenivas/remind).

## Problem Definition

The project addresses secure authorization using OAuth, allowing users to grant limited access to their resources without exposing sensitive credentials. The OAuth implementation involves client registration, authorization requests, user authorization, token requests, and access token usage.

## Project Analysis

### Login/Signup Screen

- Traditional Login: Supports conventional email and password-based login.
- OAuth Integration: Provides a seamless login experience through integration with Google and Facebook OAuth.

### Profile Page

- User Information Display: Presents the username and date of account creation (collected during signup).
- Account Linking Buttons: Integrates platform linking buttons, allowing users to connect their accounts to Google and Facebook.

### Home Screen

- Horizontal Timeline: A vertical spread of times offering users a good overview of their day’s schedule.

### Events Screen

- Monthly Timeline View: Utilizes a calendar-based interface to present a monthly timeline, allowing users to plan and navigate through their upcoming events.
- Day’s Agenda Display: Displays the agenda for the selected day, providing users with a detailed overview of their scheduled events.

### Add Events Screen

- Event Addition Page: A dedicated page for users to add new events to their agenda. The page uses user-friendly components such as date and time pickers.

## Setup

Follow these steps to set up Remind on your local machine:

### Prerequisites

Before you begin, ensure you have the following installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

### Clone the Repository

```bash
git clone https://github.com/Laxmi-Sreenivas/remind.git
cd remind
```

### Get Dependencies

Run the following command to get the required dependencies:

```bash
flutter pub get
```

### USB Debugging

Ensure that USB debugging is enabled on your Android device. For instructions, refer to the [Android Developer Documentation](https://developer.android.com/studio/debug/dev-options).

### Run the App

Connect your Android device to your computer and run the app using the following command:

```bash
flutter run
```

This will build the app and install it on your connected Android device.

### Build the App

To build the standalone APK of the application, use the following command:

```bash
flutter build apk
```

The built APK file will be located in the `build/app/outputs/flutter-apk/` directory. You can install this APK on your Android device by transferring it to the device and opening the file using a file manager.

Now you should be able to explore and use Remind on your device. If you encounter any issues during setup or have suggestions, please open an [issue](https://github.com/Laxmi-Sreenivas/remind/issues) on the GitHub repository. Happy reminding!

## References

- [Firebase SDK Documentation](https://firebase.google.com/docs)
- [Flutter SDK Documentation](https://docs.flutter.dev/)
- [Facebook Android Login Documentation](https://developers.facebook.com/docs/)
- [Google Android Login Documentation](https://cloud.google.com/)
