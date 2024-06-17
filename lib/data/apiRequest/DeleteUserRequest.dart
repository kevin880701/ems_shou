
class DeleteUserRequest {

  final String account;
  final int accountType;
  final String? org;

  DeleteUserRequest({
    required this.account,
    required this.accountType,
    this.org,
  });

  Map<String, dynamic> toMap() {
    return {
      'account': account,
      'accountType': accountType,
      'org': org,
    };
  }
}