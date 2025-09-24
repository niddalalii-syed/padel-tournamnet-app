// ignore_for_file: avoid_print

import 'dart:async';

import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:cloudinary_api/uploader/cloudinary_uploader.dart';
// ignore: implementation_imports
import 'package:cloudinary_api/src/request/model/uploader_params.dart';

class UploadImageApi {
  var cloudinary = Cloudinary.fromStringUrl(
      'cloudinary://771617666621523:YU2cKb4-5oXRfDmq2Uvwv_wJptE@dqn00khzc');

  Future<String> upload(filePath, String fileName) async {
    try {
      var response = await cloudinary
          .uploader()
          .upload(filePath,
              params: UploadParams(
                  publicId: 'quickstart_$fileName',
                  uniqueFilename: false,
                  overwrite: true))
          ?.timeout(const Duration(seconds: 120));

      if (response?.data != null) {
        print("Public ID: ${response!.data!.publicId}");
        print("Secure URL: ${response.data!.secureUrl}");
        return response
            .data!.secureUrl!; // Return the public ID for transformation
      } else {
        print("Upload failed: ${response?.error?.message}");
        return "";
      }
    } on TimeoutException catch (e) {
      print("Upload timed out: $e");
      return "";
    } catch (e) {
      print("Upload failed with error: $e");
      return "";
    }
  }
}
