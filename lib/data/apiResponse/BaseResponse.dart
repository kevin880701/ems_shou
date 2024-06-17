class BaseResponse<T> {
  final int result;
  final T data;

  BaseResponse({required this.result, required this.data});

  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) dataFromJson) {
    return BaseResponse(
      result: json['result'] ?? 0,
      data: dataFromJson(json['data'] ?? {}),
    );
  }
}