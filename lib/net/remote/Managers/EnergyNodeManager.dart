
import 'package:ems_app/data/apiResponse/CardType.dart';
import 'package:ems_app/data/apiResponse/WidgetDataResponse.dart';
import 'package:ems_app/net/remote/Managers/WebManager.dart';
import 'package:tuple/tuple.dart';

class EnergyNodeManager {

  EnergyNodeManager._();

  static final EnergyNodeManager instance = EnergyNodeManager._();
  
  WebManager webManager = WebManager.instance; 

  List<CardType> getSCardTypes() {
    List<CardType> cardTypes = [];
    for (WidgetData widgetData in webManager.currentWidgetList) {
      if (widgetData.defType == "S" && widgetData.sCardType != "") {
        // CardType cardType = CardType.fromJson(widgetData.sCardType);
        // cardTypes.add(cardType);
      }
    }
    return cardTypes;
  }

  List<CardType> getMCardTypes() {
    List<CardType> cardTypes = [];
    for (WidgetData widgetData in webManager.currentWidgetList) {
      if (widgetData.defType == "M" && widgetData.sCardType != "") {
       // CardType cardType = CardType.fromJson(widgetData.mCardType);
       // cardTypes.add(cardType);
      } 
    }
    return cardTypes;
  }

  List<CardType> getLCardTypes() {
    List<CardType> cardTypes = [];
    for (WidgetData widgetData in webManager.currentWidgetList) {
      if (widgetData.defType == "L" && widgetData.sCardType != "") {
       // CardType cardType = CardType.fromJson(widgetData.lCardType);
       // cardTypes.add(cardType);
      }
    }
    return cardTypes;
  }

  Tuple2<String, String>? getSCardTypeDeviceAndNode(int order) {
    if (getSCardTypes().isNotEmpty) {
      List<String> node = getSCardTypes()[order].dataNode.split('NODE');
      Tuple2<String, String> deviceAndNode = Tuple2(node[0],node[1]);
      return deviceAndNode;
    } else {
      print('SCardType is Empty');
      return null;
    }
  }

  Tuple2<String, String>? getMCardTypeDeviceAndNode(int order) {
    if (getMCardTypes().isNotEmpty) {
      List<String> node = getMCardTypes()[order].dataNode.split('NODE');
      Tuple2<String, String> deviceAndNode = Tuple2(node[0], node[1]);
      return deviceAndNode;
    } else {
      print('MCardType is Empty');
      return null;
    }
  }

  Tuple2<String, String>? getLCardTypeDeviceAndNode(int order) {
    if (getLCardTypes().isNotEmpty) {
      List<String> node = getLCardTypes()[order].dataNode.split('NODE');
      Tuple2<String, String> deviceAndNode = Tuple2(node[0], node[1]);
      return deviceAndNode;
    } else {
      print('LCardType is Empty');
      return null;
    }
  }
}