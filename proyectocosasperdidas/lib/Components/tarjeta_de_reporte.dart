import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'categorias.dart';
import 'ubicacion.dart';
import 'reporte.dart';

class TarjetaDeReporte extends StatelessWidget {
  //Datos relevantes del reporte
  final PlatformFile? imagen;
  final categorias tipo;
  final Ubicacion lugar;
  final DateTime fecha;
  final String title;
  final String description;
  final bool isSelected;

  //Constructor
  const TarjetaDeReporte({
    super.key,
    required this.imagen,
    required this.tipo,
    required this.lugar,
    required this.fecha,
    required this.title,
    required this.description,
    this.isSelected=false
  });

  factory TarjetaDeReporte.fromReporte(Reporte r, {bool isSelected = false}){
    return TarjetaDeReporte(
      imagen: r.imagen,
      tipo: r.tipo,
      lugar: r.ubicacion,
      title : r.titulo,
      fecha: r.fecha ?? DateTime.now(),
      description: r.descripcion,
      isSelected: isSelected);
  }

  // Metodo build para construir la UI de la tarjeta
  @override
  Widget build(BuildContext context) {
    // Retorna un objeto Card que representa la tarjeta de reporte
    return Card(
      // Elevation lo que hace es dar sombra a la tarjeta
      elevation: 4,
      // Shape define la forma de la tarjeta
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      color: isSelected?Color.fromARGB(255, 160, 150, 255):Color.fromARGB(255, 255, 255, 255),

      child:
          // Card contiene un Column que organiza los elementos verticalmente
          Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Alinea los elementos al inicio horizontalmente
            children: [
              // ClipRRect es un widget que recorta su hijo con un borde redondeado
              ClipRRect(
                // BorderRadius redondea las esquinas
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child:
                    // Image.network carga una imagen desde una URL con un ancho y alto especifico
                    (imagen != null && imagen!.bytes != null)
                        ? Image.memory(
                            imagen!.bytes!,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'report_placeholder.png',
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
              ),
              // Padding agrega espacio alrededor de Column
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Alinea los elementos al inicio horizontalmente
                  children: [
                    // Fila para mostrar la ubicación
                    Text(title, style: TextStyle(fontSize: 24,),),
                    if (isSelected)Text(
                          description,
                          style: const TextStyle(color: Color.fromARGB(255, 13, 13, 13), backgroundColor: Color.fromARGB(255, 166, 179, 255)),
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          lugar.descripcion,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    // Espacio entre la ubicación y la fecha
                    const SizedBox(height: 4),
                    // Fila para mostrar la fecha
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${fecha.day}/${fecha.month}/${fecha.year}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    // Espacio entre la fecha y el tipo
                    const SizedBox(height: 8),
                    // Fila para mostrar el tipo de categoría
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.category,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tipo.label,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
    );
  }
}
