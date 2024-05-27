import 'package:buku_tamu/form.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class KomentarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Komentar'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Komentar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Formulir()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class Komentar extends StatefulWidget {
  const Komentar({Key? key}) : super(key: key);

  @override
  _KomentarState createState() => _KomentarState();
}

class _KomentarState extends State<Komentar> {
  List _listdata = [];

  Future _getdata() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.88.90/database/read.php'));
      if (response.statusCode == 200) {
        print('Response Body: ${response.body}');
        final data = jsonDecode(response.body);
        setState(() {
          _listdata = data;
        });
      } else {
        print('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _getdata();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: _listdata
            .map((item) => Card(
                  child: ListTile(
                    title: Text(item['nama_pengguna']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Waktu : " + item['tanggal']),
                        Text("Komentar : " + item['isi_komentar']),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
