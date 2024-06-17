
import 'dart:io';
import 'package:dio/dio.dart';

class UploadAvatarRequest {
  final File file;
  final Map<String, String> attrs;

  UploadAvatarRequest({
    required this.file,
    required this.attrs,
  });


  FormData toFormData() {
    FormData formData = FormData();
    formData.files.add(MapEntry('File1', MultipartFile.fromFileSync(file.path??"")));
    formData.fields.add(MapEntry('attrs', attrs.toString()));
    return formData;
  }
}
