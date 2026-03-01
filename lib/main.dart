import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const CMasterElite());

class CMasterElite extends StatelessWidget {
  const CMasterElite({super.key});
  final String currentVersion = "1.0.0"; 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      ),
      home: HomeScreen(version: currentVersion),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String version;
  const HomeScreen({super.key, required this.version});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    checkUpdates();
  }

  Future<void> checkUpdates() async {
    try {
      // سنغير هذا الرابط لاحقاً ليطابق مستودعك الجديد
      final response = await http.get(Uri.parse('https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/version.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['latest_version'] != widget.version) {
          showUpdateDialog();
        }
      }
    } catch (e) {
      print("فشل فحص التحديث: $e");
    }
  }

  void showUpdateDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text("🚀 تحديث جديد متوفر"),
        content: const Text("تم إضافة دروس وألغاز جديدة في الخوارزميات. هل تريد الانتقال لصفحة التحميل؟"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("لاحقاً")),
          TextButton(onPressed: () {}, child: const Text("تحميل الآن")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("C Master Elite"),
        backgroundColor: Colors.amber[900],
      ),
      body: ListView(
        padding: const EdgeInsets.all(15),
        children: [
          _buildCard("لغة C & الخوارزميات", "دروس مكثفة وألغاز", Colors.blue, "🏗️"),
          _buildCard("Python & الأمن السيبراني", "أدوات الاختراق الأخلاقي", Colors.green, "🐍"),
          _buildCard("الذكاء الاصطناعي", "تعلم الآلة والبيانات", Colors.purple, "🧠"),
          const SizedBox(height: 30),
          Center(child: Text("الإصدار: ${widget.version}", style: const TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String subtitle, Color color, String icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Text(icon, style: const TextStyle(fontSize: 30)),
        title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: () {},
      ),
    );
  }
}

