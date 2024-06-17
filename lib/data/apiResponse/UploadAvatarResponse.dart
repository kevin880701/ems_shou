
import 'BaseResponse.dart';

class UploadAvatarResponse extends BaseResponse<String> {
  UploadAvatarResponse({required int result, required String data})
      : super(result: result, data: data);

  factory UploadAvatarResponse.fromJson(Map<String, dynamic> json) {
    return UploadAvatarResponse(
      result: json['result'] ?? 0,
      data: json['fileid'] ?? "",
    );
  }
}