# Flutter Project "Duel Yu-Gi-Oh!"

<p align="center" style="display: flex; justify-content: center; align-items: center;">
  <img src="https://i.imgur.com/uEVpFNe.jpeg" alt="Screenshot of the Duel Yu-Gi-Oh! application on an iPhone" width="200" style="margin: 0 10px;"/>
  <img src="https://i.imgur.com/xwLCVCK.jpeg" alt="Additional screenshot of the Duel Yu-Gi-Oh! application" width="200" style="margin: 0 10px;"/>
  <img src="https://i.imgur.com/d5bmD85.jpeg" alt="Another screenshot of the Duel Yu-Gi-Oh! application" width="200" style="margin: 0 10px;"/>
</p>

## Description
This project is a mobile application developed with Flutter that allows users to explore and search for cards from the popular Yu-Gi-Oh! card game. The application consumes data from a Yu-Gi-Oh! API and uses the BLoC pattern for state management, offering a smooth and efficient user experience.

## Requirements
- Flutter 3.24.3
- Dart 3.5.3
- DevTools 2.37.3
- Mobile device with OS (Android/iOS)

## Installation
1. Clone this repository on your local machine.
    ```bash
    git clone https://github.com/your-username/duel-yu-gi-oh.git
    ```
2. Navigate to the project directory.
    ```bash
    cd duel-yu-gi-oh
    ```
3. Install the dependencies.
    ```bash
    flutter pub get
    ```
4. Run the project on your device or emulator.
    ```bash
    flutter run
    ```

## Usage
Once the application is running, you will be able to:
- Explore a list of Yu-Gi-Oh! cards
- Search for cards by archetype
- View details of selected cards
- Enjoy an intuitive and attractive user interface

## Project Structure
The project follows a clean architecture:
- `lib/`
  - `app.dart`: Main application configuration
  - `main.dart`: Application entry point
  - `colors/`: Color definitions
  - `core/`: Core utilities and configurations
  - `data/`: Repository implementations and data sources
  - `domain/`: Entities, use cases, and repository definitions
  - `presentation/`: Widgets, pages, and presentation logic (BLoC)

## Main Dependencies
- `equatable`: For simplified object comparisons
- `http`: For making HTTP requests
- `bloc`: For state management
- `mockito`: For creating mocks in tests

## Contribution
Contributions are welcome! If you want to improve this project, don't hesitate to open a PR.

## License
This project is under the MIT license. See the `LICENSE` file for more details.
