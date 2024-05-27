import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:buku_tamu/komentar.dart';

class Formulir extends StatefulWidget {
  const Formulir({Key? key});

  @override
  State<Formulir> createState() => _FormulirState();
}

class _FormulirState extends State<Formulir> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nama_pengguna = TextEditingController();
  TextEditingController isi_komentar = TextEditingController();

  Future<bool> _simpan() async {
    final response = await http.post(
      Uri.parse('http://192.168.88.90/database/create.php'),
      body: {
        'nama_pengguna': nama_pengguna.text,
        'isi_komentar': isi_komentar.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambahkan Komentar'),
        backgroundColor: Colors.deepOrange,
      ),
      body: Form(
        key: formkey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: nama_pengguna,
                decoration: InputDecoration(
                  hintText: 'Nama Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Nama Anda tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: isi_komentar,
                decoration: InputDecoration(
                  hintText: 'Komentar Anda',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Komentar tidak boleh kosong!';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    _simpan().then((value) {
                      final snackBar = SnackBar(
                        content: Text(value
                            ? "Komentar berhasil ditambahkan"
                            : "Komentar gagal ditambahkan"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      if (value) {
                        nama_pengguna.clear();
                        isi_komentar.clear();
                      }
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Komentar()),
                      (route) => false,
                    );
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
