
class GoogleCheckRequest {
  final String uid;

  GoogleCheckRequest({
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
    };
  }
}
