class TreeDataResponse{
  final int result;
  final List<TreeData> data;

  TreeDataResponse({required this.result, required this.data});

  factory TreeDataResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>;
    List<TreeData> dataItems = dataList.map((item) => TreeData.fromJson(item)).toList();

    return TreeDataResponse(
      result: json['result'] ?? 0,
      data: dataItems,
    );
  }
}

class TreeData {
  final String parent;
  final String oid1;
  final String id;
  final String oid2;
  final String oid3;
  final String oid4;
  final String oid5;

  TreeData({
    required this.parent,
    required this.oid1,
    required this.id,
    required this.oid2,
    required this.oid3,
    required this.oid4,
    required this.oid5,
  });

  factory TreeData.fromJson(Map<String, dynamic> json) {
    return TreeData(
      parent: json['parent'] ?? "null",
      oid1: json['oid1']?? "null",
      id: json['id']?? "null",
      oid2: json['oid2']?? "null",
      oid3: json['oid3']?? "null",
      oid4: json['oid4'] ?? "null",
      oid5: json['oid5']?? "null",
    );
  }
}
