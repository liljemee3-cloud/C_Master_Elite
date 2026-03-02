import 'package:flutter/material.dart';
import 'science_data.dart';
import 'visual_assets.dart';

void main() => runApp(const CMasterApp());

class CMasterApp extends StatelessWidget {
  const CMasterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const AcademyHomeScreen(),
    );
  }
}

class AcademyHomeScreen extends StatelessWidget {
  const AcademyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أكاديمية C Master الموسوعية', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            VisualAssets.computerModule(), // المكون التفاعلي الذي طلبته
            const SizedBox(height: 20),
            const Text("اختر مجال التعلم:", style: TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            // إنشاء أزرار المجالات تلقائياً
            ...ScienceData.categories.keys.map((category) => Card(
              color: Colors.grey[900],
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: const Icon(Icons.star, color: Colors.orange),
                title: Text(category, style: const TextStyle(color: Colors.white)),
                onTap: () {
                  // هنا نفتح صفحة الدروس لهذا المجال
                },
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}
