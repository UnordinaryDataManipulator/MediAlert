# MediAlert App Documentation

## Table of Contents
1. [Overview](#overview)
2. [Features](#features)
3. [Technical Architecture](#technical-architecture)
4. [Setup Instructions](#setup-instructions)
5. [Usage Guide](#usage-guide)
6. [Testing](#testing)
7. [Maintenance](#maintenance)

## Overview

MediAlert is a Flutter-based mobile application designed to help users manage medications for multiple family members. It provides features such as medication tracking, reminders, inventory management, and data synchronization across devices using Google Drive.

## Features

### Implemented Features

1. **User Management**
   - Add, edit, and delete family members
   - Manage profiles with relationships and notes
   - Support for caregivers

2. **Medicine Management**
   - Add, edit, and delete medicines for each family member
   - Track medicine quantity and expiry dates
   - Set minimum stock thresholds
   - Customizable dosage and frequency settings
   - Prescription photo management with compression and cropping
   - Detailed medicine history tracking with timestamps

3. **History and Tracking**
   - Record medicine intake, restock, and disposal events
   - Track prescription history with photos
   - Calculate adherence rates
   - View history by date range
   - Detailed history entries with metadata
   - Support for multiple history types (intake, restock, adjustment, disposal)

4. **Photo Management**
   - Take or pick prescription photos
   - Automatic image compression and optimization
   - Secure cloud storage using Google Drive
   - Photo cropping and editing capabilities
   - Automatic cleanup of deleted photos

5. **Localization**
   - Multi-language support (English, Spanish)
   - Locale-aware date and time formatting
   - RTL support for compatible languages
   - Dynamic text scaling
   - Customizable number and currency formats

6. **Reminders and Notifications**
   - Schedule medicine intake reminders
   - Configurable reminder frequencies
   - Support for multiple daily reminders

7. **User Interface**
   - Modern Material Design 3 interface
   - Dark mode support
   - Responsive layouts
   - Intuitive navigation with Go Router

8. **Data Persistence**
   - Local storage using Hive database
   - Efficient data querying and updates
   - Data validation and error handling

9. **Cloud Synchronization**
   - Google Drive integration for backup and restore
   - Automatic conflict resolution
   - Cross-device synchronization
   - Secure OAuth2 authentication
   - Background sync support

10. **Analytics and Reports**
   - Medicine consumption trends
   - Adherence tracking
   - Stock level analysis
   - Export data to PDF/CSV

11. **Search Functionality**
   - Full-text search across medicines
   - Filter by various criteria
   - Sort and categorize results

### Planned Features

1. **Advanced Features**
   - Medicine interaction warnings
   - Prescription photo upload
   - Pharmacy integration
   - Multiple language support
   - Medication history tracking

## Technical Architecture

### Tech Stack
- **Framework**: Flutter
- **State Management**: Riverpod
- **Local Database**: Hive
- **Cloud Storage**: Google Drive API
- **Authentication**: Google Sign-In
- **Notifications**: flutter_local_notifications
- **Navigation**: go_router
- **Code Generation**: freezed, json_serializable
- **Image Processing**: image_picker, image_cropper, flutter_image_compress
- **Localization**: easy_localization
- **Testing**: mocktail, flutter_test

### Project Structure
```
lib/
├── models/
│   ├── family_member.dart
│   └── medicine.dart
├── providers/
│   ├── app_provider.dart
│   ├── cloud_sync_provider.dart
│   └── search_provider.dart
├── screens/
│   ├── home_screen.dart
│   ├���─ family_member_screen.dart
│   ├── medicine_screen.dart
│   ├── analytics_screen.dart
│   └── search_screen.dart
├── services/
│   ├── database_service.dart
│   ├── reminder_service.dart
│   ├── cloud_sync_service.dart
│   ├── analytics_service.dart
│   ├── export_service.dart
│   ├── photo_service.dart
│   └── history_service.dart
├── l10n/
│   ├── app_en.arb
│   └── app_es.arb
├── utils/
│   └── constants.dart
├── widgets/
│   ├── add_family_member_dialog.dart
│   └── add_medicine_dialog.dart
└── main.dart

test/
├── models/
│   ├── family_member_test.dart
│   └── medicine_test.dart
├── providers/
│   ├── app_provider_test.dart
│   ├── cloud_sync_provider_test.dart
│   └── search_provider_test.dart
├── services/
│   ├── database_service_test.dart
│   ├── reminder_service_test.dart
│   ├── cloud_sync_service_test.dart
│   ├── analytics_service_test.dart
│   ├── export_service_test.dart
│   ├── photo_service_test.dart
│   └── history_service_test.dart
└── widgets/
    ├── add_family_member_dialog_test.dart
    └── add_medicine_dialog_test.dart
```

### Key Components

1. **Models**
   - Immutable data classes using Freezed
   - Type-safe serialization
   - Hive adapters for persistence

2. **State Management**
   - Riverpod providers for reactive state
   - AsyncNotifier for async operations
   - Proper error handling and loading states

3. **Services**
   - Database service for Hive operations
   - Reminder service for notifications
   - Cloud sync service for Google Drive integration
   - Analytics service for data analysis
   - Export service for PDF/CSV generation
   - Photo service for image management
   - History service for event tracking

4. **Cloud Sync Architecture**
   - Google Drive API integration
   - Automatic folder creation and management
   - File versioning and conflict resolution
   - Secure token storage
   - Background sync scheduling

5. **Localization System**
   - ARB file-based translations
   - Dynamic locale switching
   - Formatted dates and numbers
   - Pluralization support
   - Context-aware translations
   - Fallback language handling

## Setup Instructions

1. **Prerequisites**
   - Flutter SDK (>=3.0.0)
   - Dart SDK (>=3.0.0)
   - Android Studio or VS Code
   - Google Cloud Console project with Drive API enabled
   - OAuth 2.0 client configuration

2. **Installation**
   ```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

3. **Google Drive Setup**
   - Create a project in Google Cloud Console
   - Enable Google Drive API
   - Configure OAuth consent screen
   - Create OAuth 2.0 client credentials
   - Add credentials to the app

4. **Running the App**
   ```bash
   flutter run
   ```

## Usage Guide

### Managing Family Members
1. Tap the '+' button on the home screen
2. Fill in the member details
3. Optional: Set as caregiver
4. Save to add the member

### Managing Medicines
1. Navigate to a family member's profile
2. Tap 'Add Medicine'
3. Fill in medicine details
4. Set quantity and reminders
5. Save to add the medicine

### Managing Prescriptions and Photos
1. When adding or editing medicine:
   - Tap 'Take Photo' to capture prescription with camera
   - Or tap 'Pick from Gallery' to select existing photo
   - Crop and adjust the photo as needed
   - Photos are automatically compressed and uploaded
2. View prescription history:
   - Navigate to medicine details
   - Scroll to prescription history section
   - Tap photo to view full size

### Tracking Medicine History
1. Record medicine intake:
   - Navigate to medicine details
   - Tap 'Record Intake'
   - Enter quantity taken and notes
2. Record restock:
   - Tap 'Restock'
   - Enter new quantity and source
3. View history:
   - Check adherence rates
   - Filter by date range
   - Export history reports

### Using Localization
1. Change language:
   - Go to Settings
   - Select Language
   - Choose between English and Spanish
2. App automatically:
   - Updates all text and labels
   - Reformats dates and numbers
   - Adjusts layouts for RTL if needed

### Using Cloud Sync
1. Sign in with Google account
2. Enable auto-sync in settings
3. Manual sync:
   - Tap sync button to backup
   - Use restore option to recover data
4. View sync status and last sync time

## Testing

### Test Architecture

1. **Unit Tests**
   - Model tests for data validation and serialization
   - Service tests for business logic
   - Provider tests for state management
   - Utility function tests

2. **Mock Objects**
   - Mock services for isolated testing
   - Mock providers for state management testing
   - Mock external dependencies (Google Drive, notifications)

3. **Test Categories**
   - Authentication tests
   - Data persistence tests
   - Cloud sync tests
   - State management tests
   - UI widget tests (planned)
   - Integration tests (planned)

### Running Tests

1. **Unit Tests**
   ```bash
   flutter test
   ```

2. **Coverage Report**
   ```bash
   flutter test --coverage
   genhtml coverage/lcov.info -o coverage/html
   ```

3. **Specific Test File**
   ```bash
   flutter test test/services/cloud_sync_service_test.dart
   ```

### Test Guidelines

1. **Naming Conventions**
   - Test files: `*_test.dart`
   - Test groups: Describe feature or component
   - Test cases: Describe expected behavior

2. **Test Structure**
   ```dart
   group('Component Name', () {
     setUp(() {
       // Setup code
     });

     tearDown(() {
       // Cleanup code
     });

     test('should behave in a certain way', () {
       // Test code
     });
   });
   ```

3. **Mock Usage**
   ```dart
   // Create mock
   class MockService extends Mock implements Service {}

   // Setup mock behavior
   when(() => mockService.method()).thenAnswer((_) async => result);

   // Verify mock interaction
   verify(() => mockService.method()).called(1);
   ```

4. **Best Practices**
   - Test one behavior per test case
   - Use descriptive test names
   - Mock external dependencies
   - Test edge cases and error conditions
   - Keep tests independent
   - Use setup and teardown appropriately

### Current Test Coverage

1. **Completed Tests**
   - Cloud sync service (100% coverage)
   - Cloud sync provider (100% coverage)
   - Model serialization
   - Basic provider functionality

2. **Planned Tests**
   - UI widget tests
   - Integration tests
   - Analytics service
   - Export functionality
   - Reminder scheduling

3. **Coverage Goals**
   - Services: 90%+ coverage
   - Providers: 90%+ coverage
   - Models: 100% coverage
   - Widgets: 80%+ coverage

## Maintenance

### TODO List
1. Add medicine interaction warnings
2. Implement prescription photo upload
3. Add pharmacy integration
4. Support for multiple languages
5. Add medication history tracking

### Known Issues
- None currently reported

### Future Improvements
1. Implement real-time sync
2. Add offline support
3. Enhance conflict resolution
4. Add sync scheduling options
5. Implement selective sync

 