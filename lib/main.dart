          import 'package:flutter/material.dart';
          import 'dart:convert';
          import 'package:http/http.dart' as http;

          void main() => runApp(MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: Scaffold(
              appBar: AppBar(
                title: const Text("الحمد لله - اختبار التحديث"),
                backgroundColor: Colors.amber[900],
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "سوف ترى إذا انجلى الغبارُ",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "أفرسٌ تحتك أم حمارُ؟",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.amber),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      const Text("إصدار التحديث: 1.2.0", style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ),
            ),
          ));
