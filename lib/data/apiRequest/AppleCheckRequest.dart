
class AppleCheckRequest {
  final String uid;

  AppleCheckRequest({
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }
}
