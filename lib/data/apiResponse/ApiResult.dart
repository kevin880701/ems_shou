
import 'dart:convert';

import 'SimpleApiResult.dart';

class ApiResult<T> extends SimpleApiResult {
  ApiResult(super.result, this.data);
  T? data;

  @override
  String toString() {
    return jsonEncode(this);
  }
}