// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_flutter_final_movil/providers/product_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            tooltip: 'Refrescar',
            onPressed: () => provider.fetchAll(),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Buscar por nombre o descripción',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: provider.setQuery,
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => provider.fetchAll(),
              child: Builder(builder: (context) {
                if (provider.loading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (provider.error != null) {
                  return Center(child: Text(provider.error!));
                }
                final items = provider.items;
                if (items.isEmpty) {
                  return const Center(child: Text('No hay productos.'));
                }
                return ListView.separated(
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final p = items[index];
                    return ListTile(
                      title: Text(p.name),
                      subtitle: Text('\$${p.price.toStringAsFixed(2)}'),
                      trailing: TextButton(
                        child: const Text('Ver detalle'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/detail', arguments: p);
                        },
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final created = await Navigator.pushNamed(context, '/edit', arguments: null);
          if (created != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(const SnackBar(content: Text('Producto creado con éxito')));
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Agregar'),
      ),
    );
  }
}
