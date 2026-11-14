import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: InputPage());
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();

  // Ganti URL sesuai dengan kondisi Anda (saya kasih contoh untuk Android Emulator)
  final String baseUrl = "http://10.0.2.2/user_management_app";

  Future<void> simpan() async {
    try {
      var url = Uri.parse("$baseUrl/insert.php");

      var response = await http.post(url, body: {
        "nama": nama.text,
        "email": email.text,
      });

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Berhasil disimpan")),
        );
        // Kosongkan field setelah sukses
        nama.clear();
        email.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("❌ Gagal: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Input Data")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nama,
              decoration: InputDecoration(labelText: "Nama"),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: simpan, child: Text("Simpan")),
          ],
        ),
      ),
    );
  }
}