import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class MenuImagen extends StatefulWidget {
  const MenuImagen({super.key});

  @override
  State<MenuImagen> createState() => _MenuImagenState();
}

class _MenuImagenState extends State<MenuImagen> {
  PlatformFile? ImagenSelec=null;
  void pickfile() async {
        final result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.custom,allowedExtensions:['png','jpg','jpeg' ]);
        if (result==null) return;
        ImagenSelec = result.files.first;
        setState((){});
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(children: [
         if (ImagenSelec?.path != null || ImagenSelec!=null)
            Image.memory(
              ImagenSelec!.bytes!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ElevatedButton(onPressed: pickfile, child: const Text("selecciona una imagen")),
        ]
      )
    );
  }
}