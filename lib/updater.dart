import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class AppUpdater {
  // هذا الرابط يجب أن يكون "Raw" لملف version.json
  static const String jsonUrl = "https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json";

  static Future<void> checkForUpdate(BuildContext context) async {
    try {
      final response = await http.get(Uri.parse(jsonUrl));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String latestVersion = data['latest_version'];
        String downloadUrl = data['url'];

        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String currentVersion = packageInfo.version;

        if (latestVersion != currentVersion) {
          _showUpdateDialog(context, latestVersion, downloadUrl);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("تطبيقك محدث بالفعل")),
          );
        }
      } else {
        throw "فشل الوصول للملف: ${response.statusCode}";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ في الاتصال: $e")),
      );
    }
  }

  static void _showUpdateDialog(BuildContext context, String version, String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("تحديث جديد متوفر"),
        content: Text("إصدار جديد ($version) متاح الآن. هل تريد التحديث؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          ElevatedButton(
            onPressed: () => _launchURL(url),
            child: const Text("تحديث الآن"),
          ),
        ],
      ),
    );
  }

  static Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'تعذر فتح الرابط: $url';
    }
  }
}
