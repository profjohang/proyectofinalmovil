import 'dart:convert';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../models/product.dart';

class ApiService {
  ApiService._();
  static final ApiService _instance = ApiService._();
  static ApiService get I => _instance;

  String get _base => Env.apiBaseUrl();

  Map<String, String> get _headers => {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      };

  // GET todos los productos
  Future<List<Product>> fetchAll() async {
    final res = await http.get(
      Uri.parse('$_base/Product/GetProducts'),
      headers: _headers,
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      final body = jsonDecode(res.body);
      if (body is List) {
        return body.map((e) => Product.fromJson(e)).toList();
      }
      throw Exception('Formato inesperado en GetProducts');
    }
    throw Exception('Error ${res.statusCode}: ${res.reasonPhrase}');
  }

  // POST crear producto
  Future<Product?> create(Product product) async {
    final res = await http.post(
      Uri.parse('$_base/Product/CreateProduct'),
      headers: _headers,
      body: jsonEncode(product.toJson()),
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      return Product.fromJson(jsonDecode(res.body));
    }
    return null;
  }

// POST actualizar producto
Future<Product?> update(Product product) async {
  final body = jsonEncode(product.toJson(includeId: true));

  // 👀 Depuración: ver el JSON que se está enviando
  print('👉 Enviando a UpdateProduct: $body');

  final res = await http.post(
    Uri.parse('$_base/Product/UpdateProduct'),
    headers: _headers,
    body: body,
  );

  print('👉 Respuesta UpdateProduct: ${res.statusCode} ${res.body}');

  if (res.statusCode >= 200 && res.statusCode < 300) {
    return Product.fromJson(jsonDecode(res.body));
  }

  throw Exception('Error ${res.statusCode}: ${res.reasonPhrase}');
}

// POST eliminar producto
Future<bool> delete(int id) async {
  final res = await http.post(
    Uri.parse('$_base/Product/DeleteProduct'),
    headers: {
      ..._headers,
      'id': id.toString(),
    },
  );

  print('👉 Respuesta DeleteProduct: ${res.statusCode} ${res.body}');

  return res.statusCode >= 200 && res.statusCode < 300;
}
}
