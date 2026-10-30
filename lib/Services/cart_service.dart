import 'dart:convert';

import 'package:flutter_realapp_1/Model/cart_Model.dart';
import 'package:http/http.dart' as http;

class CartService {
  final http.Client _client;

  CartService({http.Client? client}) : _client = client ?? http.Client();

  // Get all carts
  Future<List<CartModel>> fetchCarts() async {
    final uri = Uri.https('dummyjson.com', '/carts');

    final response = await _client.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      return (data['carts'] as List)
          .map((e) => CartModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    throw Exception('Failed to fetch carts: ${response.statusCode}');
  }

  // Add products to a cart
  Future<CartModel> addToCart({
    required int userId,
    required List<Map<String, dynamic>> products,
  }) async {
    final uri = Uri.https('dummyjson.com', '/carts/add');

    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userId': userId, 'products': products}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CartModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
    }

    throw Exception('Failed to add cart: ${response.statusCode}');
  }

  void dispose() {
    _client.close();
  }
}
