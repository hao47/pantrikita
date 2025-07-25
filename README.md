# PantriKita

PantriKita is an application for food ingredient management and recipes suggestion based on AI.

## Prerequisites

Before starting, make sure you have installed:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version ^3.8.1)
- [Dart SDK](https://dart.dev/get-dart) (latest)
- [Git](https://git-scm.com/downloads)
- [Android Studio](https://developer.android.com/studio) or [Visual Studio Code](https://code.visualstudio.com/) with Flutter and Dart extensions

## Setup Steps

### 1. Clone Repository

```bash
git clone https://github.com/username/pantrikita.git
cd pantrikita
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Environment Configuration

This application uses an `.env` file for configuration. The `.env` file is already included in the repository with the default configuration:

```
BASE_URL_API = PANTRIKITA_API_URL
```

If you need to change the API URL, please edit this `.env` file.

### 4. Running the Application

```bash
flutter run
```

This will run the application on a connected device (emulator or physical device).

## Troubleshooting

If you experience issues when running the application:

1. Make sure your Flutter SDK is up-to-date: `flutter upgrade`
2. Clean cache and rebuild: `flutter clean && flutter pub get`
3. Check your internet connection for API access
4. Make sure the `.env` file is configured correctly