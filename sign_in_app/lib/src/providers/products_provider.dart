import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:sign_in_app/src/models/product_model.dart';

class ProductsProvider {
  final String _url = 'https://flutter-course-7d3a2.firebaseio.com';

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> showProducts() async {
    final url = '$_url/products.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductModel> products = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, prod) { 
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);
    });

    return products;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json';

    final resp = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }


  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

}