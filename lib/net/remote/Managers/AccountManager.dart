import 'dart:convert';
import "package:ems_app/data/apiRequest/ChangeUserNameRequest.dart";
import "package:ems_app/net/remote/ApiEndPoint.dart";
import "package:ems_app/net/remote/NetworkInterface.dart";
import "../../../data/apiRequest/AppleCheckRequest.dart";
import "../../../data/apiRequest/AppleLoginRequest.dart";
import "../../../data/apiRequest/DeleteUserRequest.dart";
import "../../../data/apiRequest/GoogleCheckRequest.dart";
import "../../../data/apiRequest/GoogleLoginRequest.dart";
import "../../../data/apiRequest/LoginRequest.dart";
import "../../../data/apiRequest/PushInfoSetRequest.dart";
import "../../../data/apiRequest/SetAvatarRequest.dart";
import "../../../data/apiRequest/UploadAvatarRequest.dart";
import "../../../data/apiRequest/UserNewRequest.dart";
import "../../../data/apiResponse/AppleCheckResponse.dart";
import "../../../data/apiResponse/ChangeUserNameResponse.dart";
import "../../../data/apiResponse/DeleteUserResponse.dart";
import "../../../data/apiResponse/GoogleCheckResponse.dart";
import "../../../data/apiResponse/LoginResponse.dart";
import "../../../data/apiResponse/SetAvatarResponse.dart";
import "../../../data/apiResponse/SetGroupResponse.dart";
import "../../../data/apiResponse/SetUserResponse.dart";
import "../../../data/apiResponse/UploadAvatarResponse.dart";
import "../../../data/apiResponse/UserInfoResponse.dart";
import "../../../data/apiResponse/UserNewResponse.dart";

class AccountManager {
  AccountManager._();

  static final AccountManager instance = AccountManager._();

  NetworkInterface network = NetworkInterface();

  Future<LoginResponseData?> login(LoginRequest loginRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.accountLogin}';
        return network.post(url: url, body: loginRequest.toJson().toString());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      LoginResponse loginResponse = LoginResponse.fromJson(responseData);
      return loginResponse.data;
    } catch (e) {
      print('Failed to listTreeData: $e');
      return null;
    }
  }

  Future<LoginResponseData?> googleLogin(GoogleLoginRequest googleLoginRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.googleLogin}';
        return network.post(url: url, body: googleLoginRequest.toJson().toString());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      LoginResponse googleLoginResponse = LoginResponse.fromJson(responseData);
      return googleLoginResponse.data;
    } catch (e) {
      print('Failed to googleLogin: $e');
      return null;
    }
  }

  Future<LoginResponseData?> appleLogin(AppleLoginRequest appleLoginRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.appleLogin;
        return network.post(url: url, body: appleLoginRequest.toJson().toString());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      LoginResponse googleLoginResponse = LoginResponse.fromJson(responseData);
      return googleLoginResponse.data;
    } catch (e) {
      print('Failed to appleLogin: $e');
      return null;
    }
  }

  Future<bool?> delUser(DeleteUserRequest request,String token) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.delUser}';
        return network.delete(url: url, userToken: token, query: request.toMap());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      DeleteUserResponse deleteUserResponse = DeleteUserResponse.fromJson(responseData);
      return deleteUserResponse.data;
    } catch (e) {
      print('Failed to googleLogin: $e');
      return null;
    }
  }

  Future<UserInfoData?> getUserInfo(String token) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.userInfo;
        return network.get(url: url, userToken: token);
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      UserInfoResponse userInfoResponse = UserInfoResponse.fromJson(responseData);
      return userInfoResponse.data;
    } catch (e) {
      print('Failed to getUserInfo: $e');
      return null;
    }
  }

  Future<bool> setGroup(String token, String setGroupRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setGroup}';
        return network.post(url: url, userToken: token, body: setGroupRequest);
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      SetGroupResponse setGroupResponse = SetGroupResponse.fromJson(responseData);
      return true;
    } catch (e) {
      print('Failed to setGroup: $e');
      return false;
    }
  }

  Future<bool> googleCheck(String token, GoogleCheckRequest googleCheckRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.googleCheck;
        return network.get(url: url, userToken: token,query: googleCheckRequest.toMap());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      GoogleCheckResponse googleCheckResponse = GoogleCheckResponse.fromJson(responseData);
      return googleCheckResponse.data;
    } catch (e) {
      print('Failed to googleCheck: $e');
      return false;
    }
  }

  Future<bool> appleCheck(String token, AppleCheckRequest appleCheckRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.appleCheck;
        return network.get(url: url, userToken: token,query: appleCheckRequest.toMap());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      AppleCheckResponse appleCheckResponse = AppleCheckResponse.fromJson(responseData);
      return appleCheckResponse.data;
    } catch (e) {
      print('Failed to appleCheck: $e');
      return false;
    }
  }

  Future<bool> changeUserName(String token, String uid,ChangeUserNameRequest changeUserNameRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = "${ApiEndPoint.userInfo}/$uid";
        return network.post(url: url, userToken: token,body: changeUserNameRequest.toJson());
      });
      return true;
    } catch (e) {
      print('Failed to getUserInfo: $e');
      return false;
    }
  }

  Future<bool> setUser(String token, String setUserRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.setUser}';
        return network.post(url: url, userToken: token, body: setUserRequest);
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      SetUserResponse setGroupResponse = SetUserResponse.fromJson(responseData);
      return setGroupResponse.result == 0;
    } catch (e) {
      print('Failed to setGroup: $e');
      return false;
    }
  }

  Future<bool> userNew(UserNewRequest userNewRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.userNew;
        return network.post(url: url, body: userNewRequest.toJson());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      UserNewResponse userNewResponse = UserNewResponse.fromJson(responseData);
      return true;
    } catch (e) {
      print('Failed to userNew: $e');
      return false;
    }
  }

  Future<String?> uploadAvatar(String token, UploadAvatarRequest uploadAvatarRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.uploadAvatar;
        return network.post(url: url, body: uploadAvatarRequest.toFormData());
      });
      Map<String, dynamic> responseData = jsonDecode(response.toString());
      UploadAvatarResponse uploadAvatarResponse = UploadAvatarResponse.fromJson(responseData);
      return uploadAvatarResponse.data;
    } catch (e) {
      print('Failed to uploadAvatar: $e');
      return null;
    }
  }

  Future<bool> setAvatar(String token, String uid, SetAvatarRequest setAvatarRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = '${ApiEndPoint.userAttr}$uid';
        return network.put(url: url, userToken: token, body: setAvatarRequest.toJson());
      });
      return true;
    } catch (e) {
      print('Failed to setAvatar: $e');
      return false;
    }
  }

  Future<bool> pushInfoSet(String token, PushInfoSetRequest pushInfoSetRequest) async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.pushInfoSet;
        return network.post(url: url, userToken: token, body: pushInfoSetRequest.toJson());
      });
      return true;
    } catch (e) {
      print('Failed to pushInfoSet: $e');
      return false;
    }
  }
}
