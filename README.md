# LaMov Flutter App

LaMov Flutter App is a Flutter application that serves as a Movie Database app, designed using Clean Architecture principles. It incorporates features such as a home screen with categories and infinite scrolling, detailed movie information with a YouTube trailer, user reviews with infinite scrolling, JSON parsing using isolates, Lottie animations, and unit tests.

## Features

1. **Home Page**
   - Displays movie categories.
   - Infinite scrolling for a seamless browsing experience.

2. **Movie Details**
   - Provides detailed information about a selected movie.
   - Includes an embedded YouTube trailer for preview.

3. **User Reviews**
   - Allows users to read reviews for movies.
   - Supports infinite scrolling for user reviews.

4. **Clean Architecture**
   - Follows clean architecture principles for a modular and scalable codebase.
   - Separates layers into presentation, domain, and data.

5. **Isolate for JSON Parsing**
   - Efficiently parses JSON data using isolates for better performance.

6. **Lottie Animation**
   - Enhances user interface with Lottie animations for a visually appealing experience.

7. **Unit Tests**
   - Implements unit tests to ensure the reliability and maintainability of the application.
   - Utilizes the clean architecture principles for testability.

## Clean Architecture

The LaMov Flutter App is structured using clean architecture principles:

- **Presentation Layer**: Contains UI components and presentation logic.
- **Domain Layer**: Defines use cases and business logic independent of UI.
- **Data Layer**: Manages data sources, repositories, and external services.

This separation ensures a clear and maintainable codebase, making it easy to adapt to changes and add new features.

## Getting Started

### Prerequisites
- Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/luthfiarifin/lamov-flutter-app.git
    ```

2. Change directory to lamov-flutter-app:

    ```bash
    cd lamov-flutter-app
    ```

3. Get dependencies:

    ```bash
    flutter pub get
    ```

### Running the App

#### Local IDE (VS Code, Android Studio, etc.)

1. Open the project in your preferred IDE.

2. Ensure you have a connected device (emulator or physical device).

3. Run the app:

    ```bash
    flutter run
    ```

### Running Unit Tests

```bash
flutter test
```
