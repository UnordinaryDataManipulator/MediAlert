import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:path/path.dart' as path;
import '../services/cloud_sync_service.dart';

class PhotoService {
  final _imagePicker = ImagePicker();
  final _cloudSyncService = CloudSyncService();

  Future<String?> takePrescriptionPhoto() async {
    try {
      // Take photo
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 95,
      );

      if (photo == null) return null;

      // Crop photo
      final croppedFile = await _cropImage(photo.path);
      if (croppedFile == null) return null;

      // Compress photo
      final compressedFile = await _compressImage(File(croppedFile.path));
      if (compressedFile == null) return null;

      // Upload to Google Drive
      final photoUrl = await _uploadToGoogleDrive(compressedFile);
      return photoUrl;
    } catch (e) {
      debugPrint('Error taking prescription photo: $e');
      return null;
    }
  }

  Future<String?> pickPrescriptionPhoto() async {
    try {
      // Pick photo from gallery
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 95,
      );

      if (photo == null) return null;

      // Crop photo
      final croppedFile = await _cropImage(photo.path);
      if (croppedFile == null) return null;

      // Compress photo
      final compressedFile = await _compressImage(File(croppedFile.path));
      if (compressedFile == null) return null;

      // Upload to Google Drive
      final photoUrl = await _uploadToGoogleDrive(compressedFile);
      return photoUrl;
    } catch (e) {
      debugPrint('Error picking prescription photo: $e');
      return null;
    }
  }

  Future<CroppedFile?> _cropImage(String imagePath) async {
    try {
      return await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1.4142),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Prescription',
            toolbarColor: Colors.blue,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x4,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            title: 'Crop Prescription',
            aspectRatioLockEnabled: true,
            aspectRatioPickerButtonHidden: true,
          ),
        ],
      );
    } catch (e) {
      debugPrint('Error cropping image: $e');
      return null;
    }
  }

  Future<File?> _compressImage(File file) async {
    try {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(dir.path, 'compressed_${path.basename(file.path)}');

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: 85,
        minWidth: 1024,
        minHeight: 1024,
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return null;
    }
  }

  Future<String?> _uploadToGoogleDrive(File file) async {
    try {
      final httpClient = await _cloudSyncService.getAuthenticatedClient();
      if (httpClient == null) {
        throw Exception('Failed to get authenticated client');
      }

      final driveApi = drive.DriveApi(httpClient);

      // Create file metadata
      final fileMetadata = drive.File()
        ..name = 'prescription_${DateTime.now().millisecondsSinceEpoch}.jpg'
        ..mimeType = 'image/jpeg'
        ..parents = ['prescriptions']; // You'll need to create this folder

      // Upload file
      final response = await driveApi.files.create(
        fileMetadata,
        uploadMedia: drive.Media(
          file.openRead(),
          await file.length(),
        ),
      );

      // Get shareable link
      await driveApi.permissions.create(
        drive.Permission()..role = 'reader'..type = 'anyone',
        response.id!,
      );

      return 'https://drive.google.com/uc?id=${response.id}';
    } catch (e) {
      debugPrint('Error uploading to Google Drive: $e');
      return null;
    }
  }

  Future<void> deletePrescriptionPhoto(String photoUrl) async {
    try {
      final httpClient = await _cloudSyncService.getAuthenticatedClient();
      if (httpClient == null) {
        throw Exception('Failed to get authenticated client');
      }

      final driveApi = drive.DriveApi(httpClient);
      final fileId = _extractFileId(photoUrl);
      
      if (fileId != null) {
        await driveApi.files.delete(fileId);
      }
    } catch (e) {
      debugPrint('Error deleting prescription photo: $e');
    }
  }

  String? _extractFileId(String photoUrl) {
    try {
      final uri = Uri.parse(photoUrl);
      return uri.queryParameters['id'];
    } catch (e) {
      return null;
    }
  }
} 