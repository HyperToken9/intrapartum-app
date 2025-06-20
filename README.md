<p> <img src="docs/App Logo.png" alt="App Logo" width="150"/> </p>
# Interpartum App

A **cross-platform mobile application** that helps doctors assess the probability of a patient requiring a **cesarean (C-section) delivery**. The app is designed to provide quick, accurate insights based on key patient parameters, streamlining clinical decision-making in obstetric care.

## Screenshots / Demo

Samples taken from live app testing

<div style="display: flex; flex-wrap: wrap; justify-content: space-around;">
    <img src="docs/Application Login.png" alt="Login" style="width: 45%; margin: 5px;"/>
    <img src="docs/Patient Data Entry Form.png" alt="Data Entry" style="width: 45%; margin: 5px;"/>
    <img src="docs/Results Page.png" alt="Results" style="width: 45%; margin: 5px;"/>
    <img src="docs/Parameter Information Popup.png" alt="Info Popup" style="width: 45%; margin: 5px;"/>
</div>

## Getting Started

1. Clone the repository

   ```bash
   git clone https://github.com/HyperToken9/intrapartum-app
   cd intrapartum-app
   ```

2. Install dependencies

   ```bash
   flutter pub get
   ```

3. Run the app

   ```bash
   flutter run
   ```

> Ensure Firebase is properly configured for both Android and iOS before running.

## Features

- **Probability Analysis**: Calculates the likelihood of a cesarean birth based on user-input parameters.
- **Intuitive UI**: A clean, fast, and easy-to-use interface tailored for doctors.
- **Cross-Platform Support**: Built using **Flutter**, compatible with both **iOS** and **Android**.
- **Secure Authentication**: Uses **Firebase Authentication** to manage user access.
- **Encrypted Local Storage**: Patient data is securely stored on-device using a **custom encryption key**.
- **Reliable Performance**: Thoroughly tested for accuracy, performance, and usability.

## Tech Stack

- **Flutter & Dart** – For cross-platform mobile app development
- **Firebase Authentication** – For secure login
- **Local Encrypted Storage** – For offline data handling with device-specific encryption
- **Custom Algorithm** – For C-section probability calculation

## Key Screens

- **App Logo**
- **Login Page** – Secure access for authenticated users
- **Patient Data Entry Form** – Input parameters like age, fetal heart rate, etc.
- **Results Page** – Displays the probability outcome
- **Info Popups** – Tooltips explaining each input parameter
- **Demo View** – End-to-end flow of using the application

## My Responsibilities

- Designed a **user-friendly interface** for seamless data input
- Developed the complete application for **iOS and Android** using **Flutter**
- Integrated **Firebase Authentication** for secure logins
- Implemented **on-device encrypted storage** for privacy compliance
- Led **testing and validation** to ensure high reliability and clinical accuracy
