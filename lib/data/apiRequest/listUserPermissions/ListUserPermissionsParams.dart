class ListUserPermissionsParams {
  final String accountids;

  ListUserPermissionsParams({
    required this.accountids,
  });

  Map<String, dynamic> toJson() {
    return {
      'accountids': accountids,
    };
  }
}