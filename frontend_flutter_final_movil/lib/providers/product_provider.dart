import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _items = [];
  List<Product> get items => _query.isEmpty
      ? _items
      : _items
          .where((p) =>
              p.name.toLowerCase().contains(_query.toLowerCase()) ||
              p.description.toLowerCase().contains(_query.toLowerCase()))
          .toList();

  bool loading = false;
  String? error;
  String _query = '';

  // Cambiar filtro de búsqueda
  void setQuery(String q) {
    _query = q;
    notifyListeners();
  }

  // 🔹 Obtener todos los productos
  Future<void> fetchAll() async {
    loading = true;
    error = null;
    notifyListeners();

    try {
      _items = await ApiService.I.fetchAll();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    notifyListeners();
  }

  // 🔹 Crear producto
  Future<Product?> create(Product product) async {
    try {
      final created = await ApiService.I.create(product);
      if (created != null) {
        _items.add(created);
        notifyListeners();
      }
      return created;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // 🔹 Actualizar producto
  Future<Product?> update(Product product) async {
    try {
      final updated = await ApiService.I.update(product);
      if (updated != null) {
        final index = _items.indexWhere((p) => p.id == updated.id);
        if (index != -1) {
          _items[index] = updated;
        }
        notifyListeners();
      }
      return updated;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }

  // 🔹 Eliminar producto
  Future<bool> delete(int id) async {
    try {
      final ok = await ApiService.I.delete(id);
      if (ok) {
        _items.removeWhere((p) => p.id == id);
        notifyListeners();
      }
      return ok;
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
