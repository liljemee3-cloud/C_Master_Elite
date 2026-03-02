import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  final String currentVersion = "1.0.0"; 

  Future<void> check(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        backgroundColor: Colors.black,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Colors.amber),
            SizedBox(height: 20),
            Text("جاري فحص السحاب...", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );

    final url = 'https://github.com/liljemee3-cloud/C_Master_Elite/raw/refs/heads/main/version.json';
    
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      if (Navigator.canPop(context)) Navigator.pop(context);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != currentVersion) {
          _showUpdateDialog(context, data['latest_version'], data['url']);
        } else {
          _showSnackBar(context, "تطبيقك محدث ✅");
        }
      }
    } catch (e) {
      if (Navigator.canPop(context)) Navigator.pop(context);
      _showSnackBar(context, "فشل الاتصال: $e");
    }
  }

  void _showUpdateDialog(BuildContext context, String version, String downloadUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("تحديث متوفر: $version", style: const TextStyle(color: Colors.amber)),
        content: const Text("تم رصد دروس جديدة، هل تريد التحميل؟", style: TextStyle(color: Colors.white)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            onPressed: () async {
              Navigator.pop(context);
              final Uri _uri = Uri.parse(downloadUrl);
              // وضع "الفتح الخارجي المباشر" لتجاوز قيود الحماية
              try {
                await launchUrl(_uri, mode: LaunchMode.externalApplication);
              } catch (e) {
                _showSnackBar(context, "خطأ في فتح الرابط، جرب يدوياً.");
              }
            },
            child: const Text("تنزيل الآن"),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
