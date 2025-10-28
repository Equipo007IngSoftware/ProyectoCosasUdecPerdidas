import 'package:flutter/material.dart';
import 'package:proyectocosasperdidas/Components/categorias.dart';
import 'package:proyectocosasperdidas/Components/ubicacion.dart';

class TarjetaDeReporte extends StatelessWidget {
  //Datos relevantes del reporte
  final String imagenUrl;
  final categorias tipo;
  final Ubicacion lugar;
  final DateTime fecha;

  //Constructor
  const TarjetaDeReporte({
    super.key,
    required this.imagenUrl,
    required this.tipo,
    required this.lugar,
    required this.fecha,
  });

  // Metodo build para construir la UI de la tarjeta
  @override
  Widget build(BuildContext context) {
    // Retorna un objeto Card que representa la tarjeta de reporte
    return Card(
      // Elevation lo que hace es dar sombra a la tarjeta
      elevation: 4,
      // Shape define la forma de la tarjeta
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child:
          // Card contiene un Column que organiza los elementos verticalmente
          Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Alinea los elementos al inicio horizontalmente
            children: [
              // ClipRRect es un widget que recorta su hijo con un borde redondeado
              ClipRRect(
                // BorderRadius redondea las esquinas
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child:
                    // Image.network carga una imagen desde una URL con un ancho y alto especifico
                    Image.network(
                      imagenUrl,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit
                          .cover, // Ajusta la imagen para cubrir todo el espacio disponible
                    ),
              ),
              // Padding agrega espacio alrededor de Column
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .start, // Alinea los elementos al inicio horizontalmente
                  children: [
                    // Fila para mostrar la ubicación
                    Row(
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
                      children: [
                        const Icon(
                          Icons.category,
                          size: 16,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          tipo.name,
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
