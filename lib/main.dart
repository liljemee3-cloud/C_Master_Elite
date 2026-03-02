import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const CMasterApp());
}

class CMasterApp extends StatelessWidget {
  const CMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'C Master Elite - Knowledge Base',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
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
  bool isLoading = true;

  // جلب الدروس من مستودعك مباشرة
  Future<void> fetchLessons() async {
    const url = "https://raw.githubusercontent.com/liljemee3-cloud/C_Master_Elite/main/lessons_data.json";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          lessons = data['lessons'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
      print("Error fetching lessons: $e");
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
        title: const Text('أكاديمية C Master', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.orange))
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[900],
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    title: Text(
                      lessons[index]['title'],
                      style: const TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      lessons[index]['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, color: Colors.orange, size: 18),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LessonDetailScreen(lesson: lessons[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}

class LessonDetailScreen extends StatelessWidget {
  final Map lesson;
  const LessonDetailScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lesson['title']), backgroundColor: Colors.orange),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("الشرح البرمجي", lesson['content'], Icons.book),
            _buildSection("منطق الخوارزميات", lesson['logic_explanation'] ?? "قيد التحديث...", Icons.psychology),
            _buildSection("حقائق عالمية", lesson['world_fact'] ?? "هل تعلم؟", Icons.language),
            _buildSection("زاوية الفيزياء", lesson['physics_corner'] ?? "قيد الدراسة...", Icons.science),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.black),
                onPressed: () => Navigator.pop(context),
                child: const Text("تم استيعاب الدرس"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.orange, size: 24),
              const SizedBox(width: 10),
              Text(title, style: const TextStyle(color: Colors.orange, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
          const Divider(color: Colors.orange, thickness: 1),
          const SizedBox(height: 10),
          Text(content, style: const TextStyle(color: Colors.white, fontSize: 16, height: 1.5)),
        ],
      ),
    );
  }
}
