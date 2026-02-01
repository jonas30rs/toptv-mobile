import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AppConfigService with ChangeNotifier {
  // AJUSTE O IP AQUI PARA O IP DO SEU VPS/PC
  final String _panelUrl = 'http://31.97.16.249:5000/api/v1/config'; 

  Map<String, dynamic>? _fullConfig;
  bool _isLoading = true;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;
  String get currentDns => _fullConfig?['iptv_config']?['current_dns'] ?? '';
  List<dynamic> get banners => _fullConfig?['banners'] ?? [];
  List<dynamic> get layoutRules => _fullConfig?['layout_rules'] ?? [];
  String get maintenanceMessage => _fullConfig?['app_settings']?['maintenance_message'] ?? '';
  bool get isMaintenance => _fullConfig?['app_settings']?['maintenance_mode'] ?? false;

  Future<void> fetchConfig() async {
    try {
      _isLoading = true;
      notifyListeners();
      final response = await http.get(Uri.parse(_panelUrl));
      if (response.statusCode == 200) {
        _fullConfig = json.decode(response.body);
        _error = null;
      } else {
        _error = 'Erro HTTP: ${response.statusCode}';
      }
    } catch (e) {
      _error = 'Erro de conexão: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
