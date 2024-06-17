
import '../apiResponse/NodeConfigsResponse.dart';

class AddDevNodeRequest {

  final String devid;
  final List<NodeConfig> nodes;

  AddDevNodeRequest({
    required this.devid,
    required this.nodes,
  });


  Map<String, dynamic> toJson() {
    return {
      'devid': devid,
      'nodes': nodes.map((node) => node.toJson()).toList(),
    };
  }
}