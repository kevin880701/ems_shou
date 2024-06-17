import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:ems_app/data/apiRequest/LoginRequest.dart';
import 'package:ems_app/data/apiResponse/UserDetailInfoResponse.dart';
import 'package:ems_app/net/remote/ApiEndPoint.dart';
import 'package:ems_app/net/remote/NetworkInterface.dart';
import 'package:ems_app/repository/ThirdPartySignIn/AppleSignInProvider.dart';
import 'package:ems_app/repository/ThirdPartySignIn/GoogleSignInProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import '../data/apiRequest/AppleCheckRequest.dart';
import '../data/apiRequest/AppleLoginRequest.dart';
import '../data/apiRequest/ChangeUserNameRequest.dart';
import '../data/apiRequest/DeleteUserRequest.dart';
import '../data/apiRequest/GoogleCheckRequest.dart';
import '../data/apiRequest/GoogleLoginRequest.dart';
import '../data/apiRequest/PushInfoSetRequest.dart';
import '../data/apiRequest/SetAvatarRequest.dart';
import '../data/apiRequest/UploadAvatarRequest.dart';
import '../data/apiRequest/UserNewRequest.dart';
import '../data/apiResponse/LoginResponse.dart';
import '../data/apiResponse/UserInfoResponse.dart';
import '../net/remote/Managers/AccountManager.dart';
import '../utils/sharedPreferences/SharedPreferencesManager.dart';

class AccountRepository {
  AccountRepository._();

  static final AccountRepository instance = AccountRepository._();

  NetworkInterface network = NetworkInterface();

  AccountManager accountManager = AccountManager.instance;

  GoogleSignInProvider googleSignInProvider = GoogleSignInProvider();

  AppleSignInProvider appleSignInProvider = AppleSignInProvider();

  final SharedPreferencesManager sharedPreferencesManager = SharedPreferencesManager.instance;
  late UserDetailInfo currentUserDetailInfo;
  late UserCredential userCredential;

  String account = "";
  String password = "";

  String registerAccount = "";
  String registerPassword = "";
  String registerConfirmPassword = "";
  String? groupId;
  String token = "";
  late UserInfoData userInfo;

  String firebaseMessagingToken = "";

  void logout() {
    token = "";
    account = "";
    password = "";

    registerAccount = "";
    registerPassword = "";
    registerConfirmPassword = "";

    sharedPreferencesManager.saveToken("");
  }

  Future<bool> login(String account, String password) async {
    var loginRequest = LoginRequest(acc: account, pwd: password);
    LoginResponseData? loginResponseData = await accountManager.login(loginRequest);
    if (loginResponseData != null) {
      token = loginResponseData.token;
      return true;
    } else {
      return false;
    }
  }

  //Google SignIn
  Future<UserCredential?> googleSignIn() async {
    if (googleSignInProvider.isSigningIn == false) {
      googleSignInProvider.logout();
      var userCredential = await googleSignInProvider.login();
      if (userCredential != null) {
        print("=================================");
        print(userCredential.user!.refreshToken);
        print(userCredential.user!.photoURL);
        print(userCredential.credential!.token);
        print(userCredential.credential!.accessToken);
        print("=================================");
        this.userCredential = userCredential;
        return userCredential;
      } else {
        return null;
      }
    } else {
      print('GoogleAuth is already sign in!');
      return null;
    }
  }

  Future<bool> googleLogin(UserCredential userCredential) async {
    var googleLoginRequest = GoogleLoginRequest(
        account: userCredential.user!.email ?? userCredential.user!.uid!,
        name: userCredential.user!.displayName ?? "N/A",
        gUid: userCredential.user!.uid);
    LoginResponseData? loginResponseData = await accountManager.googleLogin(googleLoginRequest);
    if (loginResponseData != null) {
      token = loginResponseData.token;
      googleSignInProvider.logout();
      print('GoogleAuth is sign in!');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> appleLogin(UserCredential userCredential) async {
    final jwt = JWT.decode(userCredential.credential!.accessToken!);
    var appleLoginRequest = AppleLoginRequest(
        account: jwt.payload['email'] ?? userCredential.user!.uid, name: "N/A", aUid: userCredential.user!.uid);
    LoginResponseData? loginResponseData = await accountManager.appleLogin(appleLoginRequest);
    if (loginResponseData != null) {
      token = loginResponseData.token;
      googleSignInProvider.logout();
      print('AppleAuth is sign in!');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser() async {
    var deleteUserRequest =
        DeleteUserRequest(account: userInfo.account!, accountType: userInfo.accountType, org: userInfo.org);
    bool? isDelete = await accountManager.delUser(deleteUserRequest, token);

    if (isDelete != null) {
      return isDelete;
    } else {
      return false;
    }
  }

  Future<bool> getUserInfo() async {
    UserInfoData? userInfoData = await accountManager.getUserInfo(token);
    if (userInfoData != null) {
      userInfo = userInfoData;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> setGroup(String setGroupRequest) async {
    return await accountManager.setGroup(token, setGroupRequest);
  }

  Future<bool> setUser(String setUserRequest) async {
    return await accountManager.setUser(token, setUserRequest);
  }

  Future<bool> getGroupId() async {
    try {
      var response = await network.wrapperHttpError(() {
        var url = ApiEndPoint.userInfo;
        return network.get(url: url, userToken: token);
      });
      if (response.statusCode == 200) {
        UserDetailInfoResponse responseDate = UserDetailInfoResponse.fromJson(response.data);
        Map<String, dynamic> userDetailInfo = responseDate.data;
        UserDetailInfo detailInfo = UserDetailInfo.fromJson(userDetailInfo);
        currentUserDetailInfo = detailInfo;
        groupId = currentUserDetailInfo.groups
            .where((element) => currentUserDetailInfo.org == element.name)
            .map((element) => element.groupId)
            .join(', ');
        print("getGroupId()：${groupId}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Failed to get user info: $e');
      return false;
    }
  }

  Future<UserCredential?> appleIDUserLogin() async {
    if (appleSignInProvider.isSigningIn == false) {
      return await appleSignInProvider.login();
    } else {
      print('AppleAuth is already sign in!');
      return null;
    }
  }

  Future<bool> appleFaceIDLogin() async {
    //FaceID
    return true;
  }

  Future<bool> googleCheck(String uid) async {
    return await accountManager.googleCheck(token, GoogleCheckRequest(uid: uid));
  }

  Future<bool> appleCheck(String uid) async {
    return await accountManager.appleCheck(token, AppleCheckRequest(uid: uid));
  }

  Future<bool> changeUserName(String name) async {
    var isSuccess =
        await accountManager.changeUserName(token, userInfo.uid ?? "", ChangeUserNameRequest(name: name));
    if (isSuccess) {
      getUserInfo();
    }
    return isSuccess;
  }

  Future<bool> userNew() async {
    var isSuccess =
        await accountManager.userNew(UserNewRequest(name: "N/A", acc: registerAccount, pwd: registerPassword));
    return isSuccess;
  }

  Future<bool> uploadAvatar(File file) async {
    return await accountManager
        .uploadAvatar(
            token,
            UploadAvatarRequest(
              file: file,
              attrs: {"type": "avatar"},
            ))
        .then((fileId) {
      if (fileId != null) {
        setAvatar(fileId);
        return getUserInfo();
      }
      return false;
    });
  }

  Future<bool> setAvatar(String avatar) async {
    return accountManager
        .setAvatar(token, userInfo.uid ?? "", SetAvatarRequest(avatar: avatar))
        .then((isSuccess) {
      if (isSuccess) {
        return getUserInfo();
      }
      return false;
    });
  }

  Future<bool> pushInfoSet() async {
    return accountManager.pushInfoSet(
        token,
        PushInfoSetRequest(
          token: firebaseMessagingToken,
          pushType: "fcm2",
          account: userInfo.account!,
          appid: 0,
        ));
  }
}
