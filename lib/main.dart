import 'package:flutter/material.dart';

void main() {
  runApp(const MiRestauranteApp());
}

class MiRestauranteApp extends StatelessWidget {
  const MiRestauranteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const PantallaPrincipal(),
    );
  }
}

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({super.key});

  @override
  State<PantallaPrincipal> createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Menú hamburguesa a la derecha
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text("Opciones", style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(leading: Icon(Icons.favorite), title: Text("Mis Favoritos")),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false, 
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green, Colors.white, Colors.red],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
        title: const Text(
          "ITA restaurant: Favoritos",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Barra de búsqueda
                TextField(
                  decoration: InputDecoration(
                    hintText: "Buscar en favoritos...",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                ),
                const SizedBox(height: 25),

                // Grid de Favoritos
                Row(
                  children: const [
                    Expanded(child: TarjetaPlatillo(titulo: "Pasta Pesto", precio: "12.50", desc: "Clásico Italiano", url: "https://raw.githubusercontent.com/Abdiel-Vega128/Act10_pantalla_Vega0395/refs/heads/main/espaguetis-al-pesto.jpg")),
                    SizedBox(width: 15),
                    Expanded(child: TarjetaPlatillo(titulo: "Pizza Margarita", precio: "14.00", desc: "Mozzarella fresca", url: "https://raw.githubusercontent.com/Abdiel-Vega128/Act10_pantalla_Vega0395/refs/heads/main/pizza.jpg")),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  children: const [
                    Expanded(child: TarjetaPlatillo(titulo: "Ravioli", precio: "13.50", desc: "Relleno de ricota", url: "https://raw.githubusercontent.com/Abdiel-Vega128/Act10_pantalla_Vega0395/refs/heads/main/carne.png")),
                    SizedBox(width: 15),
                    Expanded(child: TarjetaPlatillo(titulo: "Gelato", precio: "6.00", desc: "Vainilla artesanal", url: "https://raw.githubusercontent.com/Abdiel-Vega128/Act10_pantalla_Vega0395/refs/heads/main/ensalada.png")),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TarjetaPlatillo extends StatefulWidget {
  final String titulo;
  final String precio;
  final String desc;
  final String url;

  const TarjetaPlatillo({
    super.key, 
    required this.titulo, 
    required this.precio, 
    required this.desc, 
    required this.url
  });

  @override
  State<TarjetaPlatillo> createState() => _TarjetaPlatilloState();
}

class _TarjetaPlatilloState extends State<TarjetaPlatillo> {
  bool esFavorito = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Container(
              height: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.url,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            // CORAZÓN EN ESQUINA INFERIOR IZQUIERDA
            Positioned(
              bottom: 8, // Separación desde abajo
              left: 8,   // Separación desde la izquierda
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))
                  ]
                ),
                child: IconButton(
                  constraints: const BoxConstraints(), // Quita el padding extra del botón
                  icon: Icon(
                    esFavorito ? Icons.favorite : Icons.favorite_border,
                    color: esFavorito ? Colors.red : Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      esFavorito = !esFavorito;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(widget.titulo, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text("\$${widget.precio}", style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        Text(widget.desc, style: const TextStyle(color: Colors.grey, fontSize: 11), maxLines: 1),
      ],
    );
  }
}