import 'dart:async';
import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// [ImageSelector] to pick files or media, supports all platforms
Future<void> pickImages(Function onImagePicked,
    {FileType pickingType = FileType.image}) async {
  try {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: pickingType, withData: true);

    if (result != null) {
      PlatformFile file = result.files.first;
      Uint8List? bytes = file.bytes;
      if (bytes != null) {
        String base64String = base64Encode(bytes);
        onImagePicked('data:image/${file.extension};base64,$base64String');
      }
    }
  } on PlatformException catch (e) {
    debugPrint('Unsupported operation $e');
  } catch (e) {
    debugPrint('File Picker ${e.toString()}');
  }
}

///[OnPickImageCallback] typedef for onPickImageCallback
typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);
