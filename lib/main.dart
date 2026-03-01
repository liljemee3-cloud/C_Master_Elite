import 'package:flutter/material.dart';
import 'cyber_c.dart';
import 'ai_python.dart';
import 'updater.dart';

void main() => runApp(const MaterialApp(home: MainScreen(), debugShowCheckedModeBanner: false));

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("C Master Elite"),
        backgroundColor: Colors.amber[900],
      ),
      // القائمة الجانبية المخفية 🟰
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          children: [
            const DrawerHeader(child: Center(child: Text("الإعدادات", style: TextStyle(color: Colors.white, fontSize: 24)))),
            ListTile(
              leading: const Icon(Icons.update, color: Colors.amber),
              title: const Text("ابحث عن تحديثات", style: TextStyle(color: Colors.white)),
              onTap: () => AppUpdater().check(context), // استدعاء التحديث من ملفه الخاص
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildBigButton(context, "اللغة C والأمن السيبراني", Icons.security, const CyberCScreen()),
            const SizedBox(height: 20),
            _buildBigButton(context, "الذكاء الاصطناعي وبايثون", Icons.psychology, const AIPythonScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildBigButton(BuildContext context, String title, IconData icon, Widget screen) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[900],
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(title, style: const TextStyle(fontSize: 18, color: Colors.white)),
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => screen)),
    );
  }
}
