import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(const CMasterApp());

class CMasterApp extends StatelessWidget {
  const CMasterApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(primaryColor: Colors.orange),
      home: const MainKnowledgeScreen(),
    );
  }
}

class MainKnowledgeScreen extends StatefulWidget {
  const MainKnowledgeScreen({super.key});
  @override
  State<MainKnowledgeScreen> createState() => _MainKnowledgeScreenState();
}

class _MainKnowledgeScreenState extends State<MainKnowledgeScreen> {
  List lessons = [];

  Future<void> fetchLessons() async {
    // ⚠️⚠️⚠️ يـا نـمر: اسـتبدل الـرابط أدناه برابط الـ Raw الذي نسخته ⚠️⚠️⚠️
    const String myRawUrl = "https://github.com/liljemee3-cloud/C_Master_Elite/raw/refs/heads/main/lessons_data.json"; 
    
    try {
      final response = await http.get(Uri.parse(myRawUrl));
      if (response.statusCode == 200) {
        setState(() {
          lessons = json.decode(response.body)['lessons'];
        });
      }
    } catch (e) {
      print("خطأ في جلب البيانات: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLessons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أكاديمية C Master', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
      ),
      body: lessons.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : ListView.builder(
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  color: Colors.grey[900],
                  child: ListTile(
                    title: Text(lessons[index]['title'], style: const TextStyle(color: Colors.orange)),
                    subtitle: Text(lessons[index]['content'], style: const TextStyle(color: Colors.white70)),
                    onTap: () {
                      // هنا سنفتح تفاصيل الدرس لاحقاً
                    },
                  ),
                );
              },
            ),
    );
  }
}
