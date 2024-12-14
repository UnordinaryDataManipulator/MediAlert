# MediAlert

A simple medication reminder app built with Flutter.

## Core Features
- Add and manage medicines with dosage information
- Track medicine quantities and get low stock alerts
- Set medication schedules and receive reminders
- Manage multiple family members' medications

## Technical Stack
- Flutter SDK (>=3.0.0)
- Local storage with Hive
- State management with Provider
- Local notifications

## Quick Start
1. Install dependencies:
```bash
flutter pub get
```

2. Generate Hive adapters:
```bash
flutter pub run build_runner build
```

3. Run the app:
```bash
flutter run
```

## Project Structure
```
lib/
├── models/          # Data models
├── providers/       # State management
├── screens/         # UI screens
├── services/        # Core services
└── widgets/        # UI components
```

## Dependencies
- provider: ^6.1.1
- hive: ^2.0.4
- hive_flutter: ^1.1.0
- path_provider: ^2.0.11
- flutter_local_notifications: ^15.1.0+1

## Contributing
1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## License
MIT License - see the [LICENSE](LICENSE) file for details.
