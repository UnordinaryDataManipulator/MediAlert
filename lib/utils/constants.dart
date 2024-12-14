import 'package:flutter/material.dart';

/// App-wide constants
class AppConstants {
  static const String appName = 'MediAlert';
  static const String appVersion = '1.0.0';
  
  // Hive box names
  static const String familyMembersBox = 'familyMembers';
  static const String medicinesBox = 'medicines';
  static const String settingsBox = 'settings';
  
  // Notification channels
  static const String medicationChannel = 'medication_reminders';
  static const String inventoryChannel = 'inventory_alerts';
  
  // Default values
  static const int defaultLowStockThreshold = 5;
  static const int defaultExpiryWarningDays = 30;
  
  // API endpoints (if needed)
  static const String apiBaseUrl = 'https://api.medialert.com';
}

/// Theme-related constants
class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF2196F3);
  static const Color secondaryColor = Color(0xFF4CAF50);
  static const Color errorColor = Color(0xFFE57373);
  static const Color warningColor = Color(0xFFFFA726);
  
  // Text styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle subheadingStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
  
  // Padding and margins
  static const double defaultPadding = 16.0;
  static const double smallPadding = 8.0;
  static const double largePadding = 24.0;
  
  // Border radius
  static const double defaultBorderRadius = 8.0;
}

/// Validation constants and regular expressions
class ValidationConstants {
  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  
  static final RegExp phoneRegex = RegExp(
    r'^\+?[\d\s-]{10,}$',
  );
  
  static const int maxNameLength = 50;
  static const int maxNotesLength = 500;
}

/// Error messages
class ErrorMessages {
  static const String genericError = 'Something went wrong. Please try again.';
  static const String networkError = 'Please check your internet connection.';
  static const String invalidEmail = 'Please enter a valid email address.';
  static const String invalidPhone = 'Please enter a valid phone number.';
  static const String requiredField = 'This field is required.';
  static const String lowStock = 'Medicine stock is running low.';
  static const String expiryWarning = 'Medicine is about to expire.';
} 