class ResponseBase<T> {
  final int result;
  final T data;

  ResponseBase({required this.result, required this.data});

  factory ResponseBase.fromJson(Map<String, dynamic> json, T Function(Map<String, dynamic>) dataFromJson) {
    return ResponseBase(
      result: json['result'] ?? 0,
      data: dataFromJson(json['data'] ?? {}),
    );
  }

  bool isSuccess() => result == 0;
}