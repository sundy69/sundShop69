import 'dart:convert';

import 'package:flutter_realapp_1/Model/productModel.dart';
import 'package:flutter_realapp_1/Model/productModel_detail.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static final Uri _product = Uri.http("dummyjson.com", "/products");
  final http.Client _client;

  ProductService({http.Client? client}) : _client = client ?? http.Client();

  Future<List<ProductModel>> fetchproduct() async {
    final response = await _client.get(_product);
    if (response.statusCode != 200) {
      throw Exception("Could not found : ${response.statusCode}");
    }
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final products = body['products'] as List<dynamic>;
    return products
        .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<ProductModeldetail> fetchproductDetail(int id) async {
    final response = await _client.get(
      Uri.http("dummyjson.com", "/products/$id"),
    );
    if (response.statusCode != 200) {
      throw Exception("Could not product ${response.statusCode}");
    }
    return ProductModeldetail.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
