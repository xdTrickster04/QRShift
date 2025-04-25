import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/qr_item.dart';

class QRStorage {
  static const _key = 'qr_items';

  static Future<void> saveQR(QRItem item) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await loadQRs();
    list.add(item);
    final jsonList = list.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  static Future<List<QRItem>> loadQRs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key) ?? [];
    return jsonList.map((e) => QRItem.fromJson(jsonDecode(e))).toList();
  }
}
