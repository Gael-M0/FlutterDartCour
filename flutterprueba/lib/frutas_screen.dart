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
    ) 
  ];

  // VARIABLE DE ESTADO: Almacena la fruta seleccionada (puede ser null)
  Fruta? frutaSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR: Barra superior de la aplicación
      appBar: AppBar(
        title: const Text('Tienda de Frutas'),
        backgroundColor: Colors.green,
        // ACTIONS: Botones en la parte derecha del AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // SNACKBAR: Mensaje temporal en la parte inferior
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Carrito vacío')),
              );
            },
          ),
        ],
      ),
      
      // BODY: Contenido principal de la pantalla
      body: Column(
        children: [
          // CONTAINER: Caja con padding y decoración para el título
          Container(
            width: double.infinity, // Ancho completo
            padding: const EdgeInsets.all(16),
            color: Colors.green.shade50,
            child: const Text(
              'Frutas Disponibles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          // EXPANDED: Hace que el ListView ocupe todo el espacio disponible
          Expanded(
            child: ListView.builder(
              // ITEMCOUNT: Número de elementos en la lista
              itemCount: frutas.length,
              
              // ITEMBUILDER: Función que construye cada elemento
              // index = posición actual (0, 1, 2, 3, 4...)
              itemBuilder: (context, index) {
                // Obtener la fruta actual del índice
                final fruta = frutas[index];
                
                // CARD: Widget con sombra y bordes redondeados
                return Card(
                  // MARGIN: Espacio exterior del Card
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  // ELEVATION: Altura de la sombra
                  elevation: 4,
                  
                  // LISTTILE: Widget diseñado para listas con icono, título y subtítulo
                  child: ListTile(
                    // LEADING: Widget al inicio (izquierda) del ListTile
                    leading: CircleAvatar(
                      backgroundColor: fruta.color.withOpacity(0.2),
                      child: Icon(
                        fruta.icono,
                        color: fruta.color,
                      ),
                    ),
                    
                    // TITLE: Título principal del item
                    title: Text(
                      fruta.nombre,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    
                    // SUBTITLE: Texto secundario debajo del título
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fruta.descripcion),
                        const SizedBox(height: 4),
                        // ROW: Organiza widgets horizontalmente
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money,
                              size: 16,
                              color: Colors.green.shade700,
                            ),
                            Text(
                              '\$${fruta.precio.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.inventory,
                              size: 16,
                              color: Colors.grey.shade600,
                            ),
                            Text(
                              '${fruta.cantidad} disponibles',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    
                    // TRAILING: Widget al final (derecha) del ListTile
                    trailing: IconButton(
                      icon: Icon(
                        Icons.add_shopping_cart,
                        color: fruta.color,
                      ),
                      onPressed: () {
                        // SETSTATE: Actualiza el estado y redibuja el widget
                        setState(() {
                          frutaSeleccionada = fruta;
                        });
                        
                        // Mostrar mensaje con la fruta seleccionada
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${fruta.nombre} agregado al carrito'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: fruta.color,
                          ),
                        );
                      },
                    ),
                    
                    // ONTAP: Acción cuando se toca todo el ListTile
                    onTap: () {
                      // SHOWDIALOG: Muestra un diálogo emergente
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(fruta.nombre),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                fruta.icono,
                                size: 48,
                                color: fruta.color,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Descripción:',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(fruta.descripcion),
                              const SizedBox(height: 8),
                              Text(
                                'Precio: \$${fruta.precio.toStringAsFixed(2)}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Stock: ${fruta.cantidad} unidades',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cerrar'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
          
          // BOTTOMSHEET FIJO: Muestra la fruta seleccionada en la parte inferior
          if (frutaSeleccionada != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: frutaSeleccionada!.color.withOpacity(0.1),
                border: Border(
                  top: BorderSide(
                    color: frutaSeleccionada!.color,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    frutaSeleccionada!.icono,
                    color: frutaSeleccionada!.color,
                    size: 32,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Última selección: ${frutaSeleccionada!.nombre}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Precio: \$${frutaSeleccionada!.precio.toStringAsFixed(2)}',
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        frutaSeleccionada = null;
                      });
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
      
      // FLOATING ACTION BUTTON: Botón flotante en la esquina
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // SHOWMODALBOTTOMSHEET: Panel deslizable desde abajo
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Resumen del Inventario',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Iterar sobre todas las frutas
                  ...frutas.map((fruta) => ListTile(
                    leading: Icon(fruta.icono, color: fruta.color),
                    title: Text(fruta.nombre),
                    trailing: Text('${fruta.cantidad} unidades'),
                  )),
                ],
              ),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.list),
      ),
    );
  }
}
