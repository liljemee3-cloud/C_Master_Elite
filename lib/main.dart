import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MaterialApp(home: HomeScreen()));

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String currentVersion = "1.0.0"; // النسخة "القديمة" عمداً

  @override
  void initState() {
    super.initState();
    checkUpdates();
  }

  Future<void> checkUpdates() async {
    // أضفنا رقم عشوائي للرابط لنجبر المتصفح على جلب النسخة الجديدة وليس المخزنة
    final url = 'https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json?v=${DateTime.now().millisecondsSinceEpoch}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != currentVersion) {
          _showDialog(data['url']);
        }
      }
    } catch (e) { print(e); }
  }

  void _showDialog(String url) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🚀 انتصار النمر!"),
        content: const Text("إذا رأيت هذه الرسالة، فنظام التحديث قد كسر الحصار بنجاح."),
        actions: [
          TextButton(onPressed: () => launchUrl(Uri.parse(url)), child: const Text("تحديث الآن")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text("جاري فحص التحديث السحابي...")));
  }
}
