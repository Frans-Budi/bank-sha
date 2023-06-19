import 'dart:convert';

import 'package:http/http.dart' as http;

import '../shared/values.dart';
import 'auth_service.dart';

class WalletService {
  Future<void> updatePin(String oldPin, String newPin) async {
    try {
      final token = await AuthService().getToken();

      final res = await http.put(
        Uri.parse('${AppValues.baseUrl}/wallets'),
        headers: {
          'Authorization': token,
        },
        body: {
          'previous_pin': oldPin,
          'new_pin': newPin,
        },
      );

      if (res.statusCode != 200) {
        throw jsonDecode(res.body)['message'];
      }
    } catch (e) {
      rethrow;
    }
  }
}
