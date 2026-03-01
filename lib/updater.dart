import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  final String currentVersion = "1.0.0";

  Future<void> check(BuildContext context) async {
    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != currentVersion) {
          _showDialog(context, data['url']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("تطبيقك محدث لآخر نسخة!")));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void _showDialog(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text("تحديث متوفر"),
        content: const Text("هل تريد تحميل الإضافات الجديدة؟"),
        actions: [
          ElevatedButton(onPressed: () => launchUrl(Uri.parse(url)), child: const Text("تحديث")),
        ],
      ),
    );
  }
}

