import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:path_provider/path_provider.dart';
import '../models/family_member.dart';
import '../models/medicine.dart';
import '../utils/constants.dart';

class CloudSyncService {
  static const _appFolderName = 'MediAlert';
  static const _backupFileName = 'medialert_backup.json';
  final _storage = const FlutterSecureStorage();
  final _googleSignIn = GoogleSignIn(
    scopes: [
      drive.DriveApi.driveFileScope,
      drive.DriveApi.driveAppdataScope,
    ],
  );

  Future<bool> isSignedIn() async {
    return _googleSignIn.currentUser != null;
  }

  Future<void> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        throw Exception('Google Sign In failed');
      }
      
      // Store user info securely
      await _storage.write(
        key: 'google_user_email',
        value: account.email,
      );
    } catch (e) {
      throw Exception('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _storage.delete(key: 'google_user_email');
  }

  Future<void> backup(List<FamilyMember> familyMembers, List<Medicine> medicines) async {
    try {
      // Create backup data
      final backupData = {
        'timestamp': DateTime.now().toIso8601String(),
        'familyMembers': familyMembers.map((m) => m.toJson()).toList(),
        'medicines': medicines.map((m) => m.toJson()).toList(),
      };

      // Get app directory
      final appDir = await getApplicationDocumentsDirectory();
      final backupFile = File('${appDir.path}/$_backupFileName');
      
      // Write backup to local file
      await backupFile.writeAsString(jsonEncode(backupData));

      // Get Drive API client
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        throw Exception('Failed to get authenticated client');
      }
      final driveApi = drive.DriveApi(httpClient);

      // Find or create app folder
      String? folderId = await _findOrCreateFolder(driveApi);

      // Check if backup file exists
      String? fileId = await _findFile(driveApi, _backupFileName, folderId);

      // Create file metadata
      final fileMetadata = drive.File()
        ..name = _backupFileName
        ..parents = [folderId!];

      // Upload file
      if (fileId == null) {
        // Create new file
        await driveApi.files.create(
          fileMetadata,
          uploadMedia: drive.Media(
            backupFile.openRead(),
            await backupFile.length(),
          ),
        );
      } else {
        // Update existing file
        await driveApi.files.update(
          fileMetadata,
          fileId,
          uploadMedia: drive.Media(
            backupFile.openRead(),
            await backupFile.length(),
          ),
        );
      }
    } catch (e) {
      throw Exception('Failed to backup data: $e');
    }
  }

  Future<Map<String, dynamic>> restore() async {
    try {
      // Get Drive API client
      final httpClient = await _googleSignIn.authenticatedClient();
      if (httpClient == null) {
        throw Exception('Failed to get authenticated client');
      }
      final driveApi = drive.DriveApi(httpClient);

      // Find app folder
      String? folderId = await _findOrCreateFolder(driveApi);

      // Find backup file
      String? fileId = await _findFile(driveApi, _backupFileName, folderId);
      if (fileId == null) {
        throw Exception('No backup file found');
      }

      // Download file
      final file = await driveApi.files.get(fileId, downloadOptions: drive.DownloadOptions.fullMedia) as drive.Media;
      final content = await _readMediaContent(file);
      
      // Parse backup data
      final backupData = jsonDecode(content);
      return backupData;
    } catch (e) {
      throw Exception('Failed to restore data: $e');
    }
  }

  Future<String> _readMediaContent(drive.Media media) async {
    final List<int> dataStore = [];
    await for (final data in media.stream) {
      dataStore.addAll(data);
    }
    return utf8.decode(dataStore);
  }

  Future<String?> _findOrCreateFolder(drive.DriveApi driveApi) async {
    // Search for existing folder
    final folderList = await driveApi.files.list(
      q: "mimeType='application/vnd.google-apps.folder' and name='$_appFolderName' and trashed=false",
      spaces: 'drive',
    );

    if (folderList.files?.isNotEmpty == true) {
      return folderList.files!.first.id;
    }

    // Create new folder
    final folder = drive.File()
      ..name = _appFolderName
      ..mimeType = 'application/vnd.google-apps.folder';

    final createdFolder = await driveApi.files.create(folder);
    return createdFolder.id;
  }

  Future<String?> _findFile(drive.DriveApi driveApi, String fileName, String? folderId) async {
    if (folderId == null) return null;

    final fileList = await driveApi.files.list(
      q: "name='$fileName' and '$folderId' in parents and trashed=false",
      spaces: 'drive',
    );

    return fileList.files?.isNotEmpty == true ? fileList.files!.first.id : null;
  }

  Future<DateTime?> getLastSyncTime() async {
    final lastSyncStr = await _storage.read(key: 'last_sync_time');
    return lastSyncStr != null ? DateTime.parse(lastSyncStr) : null;
  }

  Future<void> updateLastSyncTime() async {
    await _storage.write(
      key: 'last_sync_time',
      value: DateTime.now().toIso8601String(),
    );
  }
}

