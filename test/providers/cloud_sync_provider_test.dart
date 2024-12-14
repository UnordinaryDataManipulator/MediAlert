import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medialert/models/family_member.dart';
import 'package:medialert/models/medicine.dart';
import 'package:medialert/providers/cloud_sync_provider.dart';
import 'package:medialert/providers/app_provider.dart';
import 'package:medialert/services/cloud_sync_service.dart';

// Mock classes
class MockCloudSyncService extends Mock implements CloudSyncService {}
class MockFamilyMembersNotifier extends Mock implements FamilyMembersNotifier {}
class MockMedicinesNotifier extends Mock implements MedicinesNotifier {}
class Listener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {
  late ProviderContainer container;
  late MockCloudSyncService mockCloudSyncService;
  late MockFamilyMembersNotifier mockFamilyMembersNotifier;
  late MockMedicinesNotifier mockMedicinesNotifier;

  setUp(() {
    mockCloudSyncService = MockCloudSyncService();
    mockFamilyMembersNotifier = MockFamilyMembersNotifier();
    mockMedicinesNotifier = MockMedicinesNotifier();

    container = ProviderContainer(
      overrides: [
        cloudSyncNotifierProvider.overrideWith((ref) => mockCloudSyncService),
        familyMembersNotifierProvider.notifier
            .overrideWith((ref) => mockFamilyMembersNotifier),
        medicinesNotifierProvider.notifier
            .overrideWith((ref) => mockMedicinesNotifier),
      ],
    );

    addTearDown(container.dispose);
  });

  group('CloudSyncNotifier', () {
    test('signIn calls CloudSyncService.signIn', () async {
      when(() => mockCloudSyncService.signIn()).thenAnswer((_) async {});

      await container.read(cloudSyncNotifierProvider.notifier).signIn();

      verify(() => mockCloudSyncService.signIn()).called(1);
    });

    test('signOut calls CloudSyncService.signOut', () async {
      when(() => mockCloudSyncService.signOut()).thenAnswer((_) async {});

      await container.read(cloudSyncNotifierProvider.notifier).signOut();

      verify(() => mockCloudSyncService.signOut()).called(1);
    });

    test('backup performs backup and updates last sync time', () async {
      final testFamilyMembers = [
        FamilyMember(
          id: '1',
          name: 'Test Member',
          dateOfBirth: DateTime(1990, 1, 1),
        ),
      ];

      final testMedicines = [
        Medicine(
          id: '1',
          name: 'Test Medicine',
          dosage: '10mg',
          frequency: 'daily',
          currentQuantity: 30,
          minimumQuantity: 10,
        ),
      ];

      when(() => mockFamilyMembersNotifier.future)
          .thenAnswer((_) async => testFamilyMembers);
      when(() => mockMedicinesNotifier.future)
          .thenAnswer((_) async => testMedicines);
      when(() => mockCloudSyncService.backup(any(), any()))
          .thenAnswer((_) async {});
      when(() => mockCloudSyncService.updateLastSyncTime())
          .thenAnswer((_) async {});

      await container.read(cloudSyncNotifierProvider.notifier).backup();

      verify(() => mockCloudSyncService.backup(testFamilyMembers, testMedicines))
          .called(1);
      verify(() => mockCloudSyncService.updateLastSyncTime()).called(1);
    });

    test('restore performs restore and updates data', () async {
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

      when(() => mockCloudSyncService.restore())
          .thenAnswer((_) async => backupData);
      when(() => mockFamilyMembersNotifier.restoreFromBackup(any()))
          .thenAnswer((_) async {});
      when(() => mockMedicinesNotifier.restoreFromBackup(any()))
          .thenAnswer((_) async {});
      when(() => mockCloudSyncService.updateLastSyncTime())
          .thenAnswer((_) async {});

      await container.read(cloudSyncNotifierProvider.notifier).restore();

      verify(() => mockFamilyMembersNotifier.restoreFromBackup(any())).called(1);
      verify(() => mockMedicinesNotifier.restoreFromBackup(any())).called(1);
      verify(() => mockCloudSyncService.updateLastSyncTime()).called(1);
    });
  });

  group('isSignedIn Provider', () {
    test('returns CloudSyncService.isSignedIn result', () async {
      when(() => mockCloudSyncService.isSignedIn())
          .thenAnswer((_) async => true);

      final result = await container.read(isSignedInProvider.future);

      expect(result, isTrue);
      verify(() => mockCloudSyncService.isSignedIn()).called(1);
    });
  });

  group('lastSyncTime Provider', () {
    test('returns CloudSyncService.getLastSyncTime result', () async {
      final now = DateTime.now();
      when(() => mockCloudSyncService.getLastSyncTime())
          .thenAnswer((_) async => now);

      final result = await container.read(lastSyncTimeProvider.future);

      expect(result, equals(now));
      verify(() => mockCloudSyncService.getLastSyncTime()).called(1);
    });

    test('returns null when no sync time available', () async {
      when(() => mockCloudSyncService.getLastSyncTime())
          .thenAnswer((_) async => null);

      final result = await container.read(lastSyncTimeProvider.future);

      expect(result, isNull);
      verify(() => mockCloudSyncService.getLastSyncTime()).called(1);
    });
  });
} 