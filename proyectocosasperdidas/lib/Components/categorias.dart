import 'package:flutter/material.dart';
/// Enum con los valores del menú Dropdown de Categorias
/// Cada propiedad de cada valor se utiliza en MenuCategoria
enum categorias{
  electronico("Objeto Electrónico", Color.fromRGBO(66, 62, 1, 1), Icons.phone_android_outlined),
  ropa("Prenda de ropa", Color.fromRGBO(133, 29, 11, 1), Icons.dry_cleaning_outlined),
  escolar("Util academico", Color.fromRGBO(6, 82, 92, 1), Icons.book),
  doc("Documento personal", Color.fromRGBO(14, 112, 55, 1), Icons.badge),
  otro("Otro", Color.fromRGBO(92, 91, 87, 1), Icons.question_mark);
  final String label;
  final Color fcolor;
  final IconData icon;
  const categorias(this.label, this.fcolor, this.icon);
}

/// El widget del Menú Dropdown para seleccionar la categoria
/// El argumento 'press' es la función encargada de manejar el valor de la categoria seleccionada en el widget padre
/// categorias.values.map es la encargada de crear una DropdownMenuEntry para cada valor de categorias, se modifica
/// el return en caso de querer cambiar cualquier cosa
class MenuCategoria extends StatelessWidget {
  const MenuCategoria({super.key, required this.press});
  final ValueChanged<categorias> press;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<categorias>(
      label: Text("Categoria"),
      width: 250,
      initialSelection: categorias.otro,
      dropdownMenuEntries: categorias.values.map<DropdownMenuEntry<categorias>>(
        (categorias c) {
          return DropdownMenuEntry<categorias>(
            value: c,
            label: c.label,
            leadingIcon: Icon(c.icon),
            style: ButtonStyle(foregroundColor: WidgetStatePropertyAll<Color?>(c.fcolor)),
          );
        },
      ).toList(),
      onSelected: (value) {
        press(value!);
      },
    );
  }
}