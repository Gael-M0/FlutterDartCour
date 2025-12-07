import 'package:flutter/material.dart';

// MODELO DE DATOS: Representa cada fruta con sus propiedades
class Fruta {
  final String nombre;
  final String descripcion;
  final IconData icono;
  final Color color;
  final double precio;
  final int cantidad;

  Fruta({
    required this.nombre,
    required this.descripcion,
    required this.icono,
    required this.color,
    required this.precio,
    required this.cantidad,
  });
}

// SCREEN PRINCIPAL: Pantalla que muestra la lista de frutas
class FrutasScreen extends StatefulWidget {
  const FrutasScreen({Key? key}) : super(key: key);

  @override
  State<FrutasScreen> createState() => _FrutasScreenState();
}

class _FrutasScreenState extends State<FrutasScreen> {
  // LISTA DE DATOS: Aquí se almacenan todas las frutas
  final List<Fruta> frutas = [
    Fruta(
      nombre: 'Manzana',
      descripcion: 'Fruta roja y crujiente, rica en fibra',
      icono: Icons.apple,
      color: Colors.red,
      precio: 2.50,
      cantidad: 10,
    ),
    Fruta(
      nombre: 'Plátano',
      descripcion: 'Fruta amarilla rica en potasio',
      icono: Icons.emoji_food_beverage,
      color: Colors.yellow.shade700,
      precio: 1.80,
      cantidad: 15,
    ),
    Fruta(
      nombre: 'Naranja',
      descripcion: 'Cítrico jugoso lleno de vitamina C',
      icono: Icons.circle,
      color: Colors.orange,
      precio: 3.00,
      cantidad: 8,
    ),
    Fruta(
      nombre: 'Uva',
      descripcion: 'Pequeñas y dulces, perfectas para snack',
      icono: Icons.grain,
      color: Colors.purple,
      precio: 4.50,
      cantidad: 5,
    ),
    Fruta(
      nombre: 'Sandía',
      descripcion: 'Grande y refrescante, ideal para verano',
      icono: Icons.water_drop,
      color: Colors.green,
      precio: 5.00,
      cantidad: 3,
    ),
    Fruta(
      nombre: 'Mango',
      descripcion: 'Dulce y tropical, delicioso en batidos',
      icono: Icons.local_florist,
      color: const Color.fromARGB(255, 203, 152, 63),
      precio: 3.75,
      cantidad: 7,
    ),
  ];

  // Lista filtrada para la búsqueda
  List<Fruta> frutasFiltradas = [];

  // Variable para controlar el estilo de visualización (compacto o expandido)
  bool estiloCompacto = true;

  // VARIABLE DE ESTADO: Almacena la fruta seleccionada (puede ser null)
  Fruta? frutaSeleccionada;

  @override
  void initState() {
    super.initState();
    frutasFiltradas = frutas; // Al inicio muestra todas las frutas
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 35, 36, 39),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'FRUTAS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // BOTÓN DE MENÚ: Abre PopupMenuButton para cambiar estilo
                  PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.white,
                      size: 28,
                    ),
                    color: const Color(0xFF2D2D2D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      side: const BorderSide(color: Colors.white24, width: 1),
                    ),
                    offset: const Offset(0, 50),
                    onSelected: (value) {
                      if (value == 'cambiar_estilo') {
                        setState(() {
                          estiloCompacto = !estiloCompacto;
                        });
                      }
                    },
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 'cambiar_estilo',
                        child: Row(
                          children: [
                            Icon(
                              estiloCompacto ? Icons.view_list : Icons.view_compact,
                              color: Colors.blue,
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Cambio de estilo',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.apple,
                    color: Colors.white,
                    size: 32,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (valor) {
                  setState(() {
                    frutasFiltradas = frutas.where((fruta) =>
                      fruta.nombre.toLowerCase().contains(valor.toLowerCase())
                    ).toList();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: const Color(0xFF3A3F4F),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: frutasFiltradas.length,
                itemBuilder: (context, index) {
                  final fruta = frutasFiltradas[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    padding: EdgeInsets.all(estiloCompacto ? 16 : 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Columna con información de la fruta
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                fruta.nombre,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                estiloCompacto ? 'Datos' : fruta.descripcion,
                                style: const TextStyle(color: Colors.white70),
                                maxLines: estiloCompacto ? 1 : 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              // Mostrar precio solo en modo expandido
                              if (!estiloCompacto) ...[
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.attach_money, color: Colors.green, size: 16),
                                    Text(
                                      '${fruta.precio.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Icon(fruta.icono, color: fruta.color, size: 16),
                                    Text(
                                      ' ${fruta.cantidad} unidades',
                                      style: const TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        ),
                        // BOTÓN DE MENÚ: PopupMenuButton con opciones por fruta
                        PopupMenuButton<String>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                          color: const Color(0xFF2D2D2D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(color: Colors.white24, width: 1),
                          ),
                          offset: const Offset(-20, 0),
                          onSelected: (value) {
                            // MANEJO DE ACCIONES
                            if (value == 'eliminar') {
                              // Mostrar diálogo de confirmación
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: const Color(0xFF2D2D2D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  title: const Text(
                                    '¿Eliminar?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  content: Text(
                                    '¿Deseas eliminar ${fruta.nombre}?',
                                    style: const TextStyle(color: Colors.white70),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          frutasFiltradas.removeAt(index);
                                        });
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('${fruta.nombre} eliminado'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Eliminar',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else if (value == 'editar') {
                              // Acción de editar (estético)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Editar ${fruta.nombre}'),
                                  backgroundColor: Colors.blue,
                                ),
                              );
                            } else if (value == 'carrito') {
                              // Acción de carrito (estético)
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${fruta.nombre} agregado al carrito'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            }
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'eliminar',
                              child: Row(
                                children: [
                                  Icon(Icons.delete_outline, color: Colors.red),
                                  SizedBox(width: 12),
                                  Text(
                                    'Eliminar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'editar',
                              child: Row(
                                children: [
                                  Icon(Icons.edit_outlined, color: Colors.blue),
                                  SizedBox(width: 12),
                                  Text(
                                    'Editar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem(
                              value: 'carrito',
                              child: Row(
                                children: [
                                  Icon(Icons.shopping_cart_outlined, color: Colors.green),
                                  SizedBox(width: 12),
                                  Text(
                                    'Carrito',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}