import 'package:flutter/material.dart';
import 'cyber_c.dart';
import 'ai_python.dart';
import 'updater.dart';

void main() {
  runApp(const MaterialApp(
    home: MainScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("C Master Elite"),
        backgroundColor: Colors.amber[900],
        // أيقونة القائمة الجانبية 🟰 تظهر تلقائياً هنا
      ),
      
      // القائمة الجانبية (Drawer) حيث أخفينا زر التحديث
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.amber[900]),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.terminal, color: Colors.white, size: 50),
                  SizedBox(height: 10),
                  Text("إعدادات النظام الذكي والعاقل", style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.cloud_download, color: Colors.amber),
              title: const Text("ابحث عن تحديثات", style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context); // إغلاق القائمة أولاً
                AppUpdater().check(context); // تشغيل نظام التحديث الذكي من ملفه
              },
            ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.grey),
              title: const Text("الإصدار الحالي هو هذا ←: 1.0.0", style: TextStyle(color: Colors.grey)),
              onTap: null,
            ),
          ],
        ),
      ),

      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.code, size: 80, color: Colors.amber),
            const SizedBox(height: 40),
            
            // زر الدخول لعالم C والأمن السيبراني
            _buildMenuButton(
              context, 
              "اللغة C والأمن السيبراني", 
              Icons.security, 
              const CyberCScreen(),
              Colors.blueGrey[900]!
            ),
            
            const SizedBox(height: 20),
            
            // زر الدخول لعالم بايثون والذكاء الاصطناعي
            _buildMenuButton(
              context, 
              "الذكاء الاصطناعي العاقل وبايثون", 
              Icons.psychology, 
              const AIPythonScreen(),
              Colors.indigo[900]!
            ),
          ],
        ),
      ),
    );
  }

  // خوارزمية بناء الأزرار الموحدة لتجنب التكرار
  Widget _buildMenuButton(BuildContext context, String title, IconData icon, Widget screen, Color color) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
        ),
        icon: Icon(icon, color: Colors.amber, size: 28),
        label: Text(
          title, 
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        },
      ),
    );
  }
}
