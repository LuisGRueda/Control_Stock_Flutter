import 'dart:io';
import 'package:control_stock/ui/colors_view.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? imageFile; // se inicializa como null
  TextEditingController _controller = TextEditingController();

  Future<void> _changeProfileImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null) {
      setState(() {
        imageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppColor StyleApp = AppColor();
    return Scaffold(
      backgroundColor: StyleApp.ColorBackgroud(context),
      body: Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: StyleApp.ColorContainer(context),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: _changeProfileImage,
              child: CircleAvatar(
                radius: 75,
                backgroundImage: imageFile != null
                    ? Image(image: FileImage(imageFile!)).image
                    : const Image(
                        image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/01/10/22/07/woman-1132617_1280.jpg',
                      )).image,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Maria Alejandra Lopez',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'CI: 7011342',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Fecha de Nacimiento: 14/12/2000',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            const Text(
              'Usuario: Mari',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.lock, color: Colors.white),
                SizedBox(width: 10),
                Text(
                  '***********',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
