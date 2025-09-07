// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/product_provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _desc;
  late final TextEditingController _price;
  late final TextEditingController _image;
  late final TextEditingController _category;
  Product? _editing;

  @override
  void initState() {
    super.initState();

    _name = TextEditingController();
    _desc = TextEditingController();
    _price = TextEditingController();
    _image = TextEditingController();
    _category = TextEditingController();

    // Cargar datos si estamos editando
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)!.settings.arguments;
      if (args is Product) {
        setState(() {
          _editing = args;
          _name.text = args.name;
          _desc.text = args.description;
          _price.text = args.price.toString();
          _image.text = args.imageUrl ?? '';
          _category.text = args.category; // 👈 nuevo campo
        });
      }
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _desc.dispose();
    _price.dispose();
    _image.dispose();
    _category.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editing != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Editar producto' : 'Nuevo producto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _desc,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  maxLines: 3,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _price,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Requerido';
                    final n = double.tryParse(v.replaceAll(',', '.'));
                    if (n == null || n < 0) return 'Ingrese un número válido';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _category,
                  decoration: const InputDecoration(labelText: 'Categoría'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Requerido' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _image,
                  decoration:
                      const InputDecoration(labelText: 'URL de imagen (opcional)'),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) return;
                      final prov = context.read<ProductProvider>();
                      final p = Product(
                        id: _editing?.id,
                        name: _name.text.trim(),
                        description: _desc.text.trim(),
                        price: double.parse(
                            _price.text.trim().replaceAll(',', '.')),
                        imageUrl: _image.text.trim().isEmpty
                            ? null
                            : _image.text.trim(),
                        category: _category.text.trim(), // 👈 nuevo campo
                      );
                      if (_editing == null) {
                        final created = await prov.create(p);
                        if (created != null) {
                          Navigator.pop(context, created);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(prov.error ?? 'Error al crear')));
                        }
                      } else {
                        final updated = await prov.update(p);
                        if (updated != null) {
                          Navigator.pop(context, updated);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text(prov.error ?? 'Error al actualizar')));
                        }
                      }
                    },
                    child: Text(isEdit ? 'Guardar cambios' : 'Crear'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
