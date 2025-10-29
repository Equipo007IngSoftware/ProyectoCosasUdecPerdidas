import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MenuImagen extends StatefulWidget {
  const MenuImagen({super.key, required this.img});
  final ValueChanged<PlatformFile> img;
  @override
  State<MenuImagen> createState() => _MenuImagenState();
}
class _MenuImagenState extends State<MenuImagen> {
  PlatformFile? imagenSelec=null;
  void pickfile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false, 
      type: FileType.custom,allowedExtensions:['png','jpg','jpeg' ],
      withData: true,
      );
    if (result==null) return;
    imagenSelec = result.files.first;
    setState((){});
    widget.img(imagenSelec!);
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: Column(children: [
         if (imagenSelec?.path != null || imagenSelec!=null)
            Image.memory(
              imagenSelec!.bytes!,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ElevatedButton(
            onPressed: pickfile, 
            child: const Text("selecciona una imagen")),
        ]
      )
    );
  }
}