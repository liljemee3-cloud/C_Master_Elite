import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  final String currentVersion = "1.0.0"; 

  Future<void> check(BuildContext context) async {
    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json';
    
    try {
      // طلب البيانات بسرعة البرق
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != currentVersion) {
          _showQuickUpdate(context, data['url']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("أنت على أحدث إصدار ✅")));
        }
      }
    } catch (e) {
      // إذا فشل الاتصال بسرعة، لا نشغل المستخدم
    }
  }

  void _showQuickUpdate(BuildContext context, String downloadUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text("تحديث سريع 🚀", style: TextStyle(color: Colors.amber)),
        content: const Text("هناك معلومات جديدة جاهزة للصب في تطبيقك.", style: TextStyle(color: Colors.white)),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(context);
              // فتح الرابط فوراً دون أي انتظار
              if (await canLaunchUrl(Uri.parse(downloadUrl))) {
                await launchUrl(Uri.parse(downloadUrl), mode: LaunchMode.externalApplication);
              }
            },
            child: const Text("تنزيل الآن"),
          ),
        ],
      ),
    );
  }
}
