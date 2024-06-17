
import 'BaseResponse.dart';

class LoginResponse extends BaseResponse<LoginResponseData> {
  LoginResponse({required int result, required LoginResponseData data})
      : super(result: result, data: data);

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      result: json['result'] ?? 0,
      data: LoginResponseData.fromJson(json['data'] ?? {}),
    );
  }
}

class LoginResponseData {
  final String token;
  final String account;
  String? password;
  final String name;
  String? org;
  final int accountType;
  String? uid;

  LoginResponseData({
    required this.token,
    required this.account,
    this.password,
    required this.name,
    this.org,
    required this.accountType,
    this.uid,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) {
    return LoginResponseData(
      token: json['token'] ?? '',
      account: json['account'] ?? '',
      password: json['password'],
      name: json['name'] ?? '',
      org: json['org'],
      accountType: json['accountType'] ?? 0,
      uid: json['uid'],
    );
  }

  factory LoginResponseData.clear() {
    return LoginResponseData(
      token: '',
      account: '',
      password: null,
      name: '',
      org: null,
      accountType: 0,
      uid: null,
    );
  }
}