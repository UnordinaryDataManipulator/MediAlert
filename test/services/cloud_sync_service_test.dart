import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:medialert/models/family_member.dart';
import 'package:medialert/models/medicine.dart';
import 'package:medialert/services/cloud_sync_service.dart';

// Mock classes
class MockGoogleSignIn extends Mock implements GoogleSignIn {}
class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}
class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {}
class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}
class MockDriveApi extends Mock implements drive.DriveApi {}
class MockDriveFiles extends Mock implements drive.FilesResource {}

void main() {
  late CloudSyncService cloudSyncService;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockFlutterSecureStorage mockStorage;
  late MockDriveApi mockDriveApi;
  late MockDriveFiles mockDriveFiles;

  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockStorage = MockFlutterSecureStorage();
    mockDriveApi = MockDriveApi();
    mockDriveFiles = MockDriveFiles();

    // Register fallback values
    registerFallbackValue(drive.File());

    when(() => mockDriveApi.files).thenReturn(mockDriveFiles);
  });

  group('CloudSyncService - Authentication', () {
    test('isSignedIn returns true when user is signed in', () async {
      final mockAccount = MockGoogleSignInAccount();
      when(() => mockGoogleSignIn.currentUser).thenReturn(mockAccount);

      cloudSyncService = CloudSyncService();
      final result = await cloudSyncService.isSignedIn();

      expect(result, isTrue);
    });

    test('isSignedIn returns false when no user is signed in', () async {
      when(() => mockGoogleSignIn.currentUser).thenReturn(null);

      cloudSyncService = CloudSyncService();
      final result = await cloudSyncService.isSignedIn();

      expect(result, isFalse);
    });

    test('signIn stores user email on successful sign in', () async {
      final mockAccount = MockGoogleSignInAccount();
      when(() => mockAccount.email).thenReturn('test@example.com');
      when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => mockAccount);
      when(() => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      )).thenAnswer((_) async {});

      cloudSyncService = CloudSyncService();
      await cloudSyncService.signIn();

      verify(() => mockStorage.write(
        key: 'google_user_email',
        value: 'test@example.com',
      )).called(1);
    });

    test('signIn throws exception when sign in fails', () async {
      when(() => mockGoogleSignIn.signIn()).thenAnswer((_) async => null);

      cloudSyncService = CloudSyncService();
      expect(
        () => cloudSyncService.signIn(),
        throwsA(isA<Exception>()),
      );
    });

    test('signOut clears stored user data', () async {
      when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async => null);
      when(() => mockStorage.delete(key: any(named: 'key')))
          .thenAnswer((_) async {});

      cloudSyncService = CloudSyncService();
      await cloudSyncService.signOut();

      verify(() => mockStorage.delete(key: 'google_user_email')).called(1);
      verify(() => mockGoogleSignIn.signOut()).called(1);
    });
  });

  group('CloudSyncService - Backup', () {
    final testFamilyMember = FamilyMember(
      id: '1',
      name: 'Test Member',
      dateOfBirth: DateTime(1990, 1, 1),
    );

    final testMedicine = Medicine(
      id: '1',
      name: 'Test Medicine',
      dosage: '10mg',
      frequency: 'daily',
      currentQuantity: 30,
      minimumQuantity: 10,
    );

    test('backup creates new file when no existing backup found', () async {
      // Mock Drive API responses
      when(() => mockDriveFiles.list(
        q: any(named: 'q'),
        spaces: any(named: 'spaces'),
      )).thenAnswer((_) async => drive.FileList(files: []));

      when(() => mockDriveFiles.create(
        any(),
        uploadMedia: any(named: 'uploadMedia'),
      )).thenAnswer((_) async => drive.File());

      cloudSyncService = CloudSyncService();
      await cloudSyncService.backup([testFamilyMember], [testMedicine]);

      verify(() => mockDriveFiles.create(any(), uploadMedia: any(named: 'uploadMedia')))
          .called(1);
    });

    test('backup updates existing file when backup found', () async {
      // Mock Drive API responses
      when(() => mockDriveFiles.list(
        q: any(named: 'q'),
        spaces: any(named: 'spaces'),
      )).thenAnswer((_) async => drive.FileList(
        files: [drive.File()..id = 'existing-file-id'],
      ));

      when(() => mockDriveFiles.update(
        any(),
        any(),
        uploadMedia: any(named: 'uploadMedia'),
      )).thenAnswer((_) async => drive.File());

      cloudSyncService = CloudSyncService();
      await cloudSyncService.backup([testFamilyMember], [testMedicine]);

      verify(() => mockDriveFiles.update(
        any(),
        any(),
        uploadMedia: any(named: 'uploadMedia'),
      )).called(1);
    });
  });

  group('CloudSyncService - Restore', () {
    test('restore throws exception when no backup found', () async {
      when(() => mockDriveFiles.list(
        q: any(named: 'q'),
        spaces: any(named: 'spaces'),
      )).thenAnswer((_) async => drive.FileList(files: []));

      cloudSyncService = CloudSyncService();
      expect(
        () => cloudSyncService.restore(),
        throwsA(isA<Exception>()),
      );
    });

    test('restore successfully parses backup data', () async {
      final backupData = {
        'timestamp': DateTime.now().toIso8601String(),
        'familyMembers': [
          {
            'id': '1',
            'name': 'Test Member',
            'dateOfBirth': '1990-01-01T00:00:00.000',
          }
        ],
        'medicines': [
          {
            'id': '1',
            'name': 'Test Medicine',
            'dosage': '10mg',
            'frequency': 'daily',
            'currentQuantity': 30,
            'minimumQuantity': 10,
          }
        ],
      };

      // Mock Drive API responses
      when(() => mockDriveFiles.list(
        q: any(named: 'q'),
        spaces: any(named: 'spaces'),
      )).thenAnswer((_) async => drive.FileList(
        files: [drive.File()..id = 'existing-file-id'],
      ));

      when(() => mockDriveFiles.get(
        any(),
        downloadOptions: any(named: 'downloadOptions'),
      )).thenAnswer((_) async => drive.Media(
        Stream.value(utf8.encode(jsonEncode(backupData))),
        0,
      ));

      cloudSyncService = CloudSyncService();
      final result = await cloudSyncService.restore();

      expect(result, equals(backupData));
    });
  });

  group('CloudSyncService - Last Sync Time', () {
    test('getLastSyncTime returns null when no sync time stored', () async {
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => null);

      cloudSyncService = CloudSyncService();
      final result = await cloudSyncService.getLastSyncTime();

      expect(result, isNull);
    });

    test('getLastSyncTime returns DateTime when sync time stored', () async {
      final now = DateTime.now();
      when(() => mockStorage.read(key: any(named: 'key')))
          .thenAnswer((_) async => now.toIso8601String());

      cloudSyncService = CloudSyncService();
      final result = await cloudSyncService.getLastSyncTime();

      expect(result, isA<DateTime>());
      expect(result?.toIso8601String(), equals(now.toIso8601String()));
    });

    test('updateLastSyncTime stores current time', () async {
      when(() => mockStorage.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      )).thenAnswer((_) async {});

      cloudSyncService = CloudSyncService();
      await cloudSyncService.updateLastSyncTime();

      verify(() => mockStorage.write(
        key: 'last_sync_time',
        value: any(that: isA<String>()),
      )).called(1);
    });
  });
} 