import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:ems_app/define.dart';
import 'package:ems_app/main.dart';
import 'package:ems_app/net/remote/ErrorCode.dart';
import 'package:ems_app/resources/app_colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../data/apiResponse/BaseResponse.dart';

class NetworkInterface {

  final Dio _dio = Dio();

  /// MARK: - Get Method
  Future<Response> get({required String url, String? userToken, Map<String, dynamic>? query}) async {
    try {
      Options options = Options(headers: {
        HttpHeaders.authorizationHeader: userToken ?? '',
      });

      print("====== Request Log ======");
      print("Request URL: ${url}");
      print("Request Method: GET");
      print("Request Headers: ${options.headers}");
      print("Request Query: $query");
      Response response = await _dio.get(url, queryParameters: query, options: options);
      print("Response Status: ${response.statusCode}");
      print("Response data: ${response.data}");
      var resultCode = response.data['result'];
      if(resultCode != null){
        checkResponseData(response.data['result']);
      }
      print("=========================");
      return response;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to get data');
    }
  }

  /// MARK: Post Method
  Future<Response> post({required String url, dynamic? body, String? userToken, Map<String, dynamic>? query}) async {
    try {
      Options options = Options(headers: {
        HttpHeaders.authorizationHeader: userToken ?? '',
        'Content-Type': 'application/json'
      });
      print("====== Request Log ======");
      print("Request URL: ${url}");
      print("Request Method: POST");
      print("Request Headers: ${options.headers}");
      print("Request Body: ${body}");
      print("Request Query: $query");
      Response response = await _dio.post(url, data: body, queryParameters: query, options: options);
      print("Response Status: ${response.statusCode}");
      print("Response data: ${response.data}");

      dynamic data = response.data;
      if (data is Map<String, dynamic>) {
        var resultCode = data['result'];
        if (resultCode != null) {
          checkResponseData(resultCode);
        }
      } else if (data is String) {
        Map<String, dynamic> jsonData = jsonDecode(data);
        var resultCode = jsonData['result'];
        if (resultCode != null) {
          checkResponseData(resultCode);
        }
      }
      print("=========================");

      return response;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to post data');
    }
  }

  Future<Response> delete({
    required String url,
    String? userToken,
    Map<String, dynamic>? query
  }) async {
    try {
      Options options = Options(
        headers: {
          HttpHeaders.authorizationHeader: userToken ?? '',
        },
      );

      print("====== Request Log ======");
      print("Request URL: $url");
      print("Request Method: DELETE");
      print("Request Headers: ${options.headers}");
      print("Request Query: ${query}");
      Response response = await _dio.delete(url, queryParameters: query, options: options);
      print("Response Status: ${response.statusCode}");
      print("Response data: ${response.data}");
      var resultCode = response.data['result'];
      if(resultCode != null){
        checkResponseData(response.data['result']);
      }
      print("=========================");
      return response;
    } catch (e) {
      print("Failed to delete data: $e");
      throw Exception('Failed to delete data');
    }
  }

  Future<Response> put({required String url, String? body, String? userToken}) async {
    try {
      Options options = Options(headers: {
        HttpHeaders.authorizationHeader: userToken ?? '',
        'Content-Type': 'application/json'
      });
      print("====== Request Log ======");
      print("Request URL: ${url}");
      print("Request Method: PUT");
      print("Request Headers: ${options.headers}");
      print("Request Body: ${body}");
      Response response = await _dio.put(url, data: body, options: options);
      print("Response Status: ${response.statusCode}");
      print("Response data: ${response.data}");
      var resultCode = response.data['result'];
      if(resultCode != null){
        checkResponseData(response.data['result']);
      }
      print("=========================");

      return response;
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to put data');
    }
  }

  Future<Response> wrapperHttpError(Future<Response> Function() block) async {
    try {
      var response = await block();
      if (response.statusCode == 200) {
        return response;
      } else {
        if (appContext != null) {
          showToast(
              context: appContext!,
              text: "伺服器異常，請回報開發商",
              backgroundColor: AppColors.red,
              textColor: AppColors.white);
          EasyLoading.dismiss();
        }
        throw Exception('Server error');
      }
    } catch (e) {
      rethrow;
    }
  }

  void checkResponseData(int result) {
    if (result != 0) {
      throw Exception('Server error: result code = ${result}; result msg = ${error_codes[result]}');
    }
  }

}

