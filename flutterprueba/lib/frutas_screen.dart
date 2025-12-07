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
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fruta.nombre,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 253, 254, 255),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Datos',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: Colors.white,
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