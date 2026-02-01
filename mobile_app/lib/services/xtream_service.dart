import 'package:flutter/foundation.dart';

class XtreamService with ChangeNotifier {
  Future<List<String>> getLiveCategories() async {
    await Future.delayed(const Duration(seconds: 1));
    // DADOS MOCKADOS PARA TESTE
    return [
      "GLOBO SP FHD", "GLOBO RJ HD", "SBT SP", "RECORD NEWS",
      "TELECINE ACTION FHD", "TELECINE PIPOCA", "HBO FAMILY",
      "XXX - AS BRASILEIRAS", "XXX - PLAYBOY TV",
      "PREMIERE CLUBES", "ESPN BRASIL", "COMBATE HD",
      "CARTOON NETWORK", "DISCOVERY KIDS",
      "CANAIS 24H - CHAVES", "BBB 24H CÂMERA 1"
    ];
  }
}