import 'dart:io';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:mime_type/mime_type.dart';

import 'package:sign_in_app/src/models/product_model.dart';
import 'package:sign_in_app/src/user_preferences/user_preferences.dart';

class ProductsProvider {
  final String _url = 'https://flutter-course-7d3a2.firebaseio.com';
  final _prefs = new UserPreferences();

  Future<bool> createProduct(ProductModel product) async {
    final url = '$_url/products.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<List<ProductModel>> showProducts() async {
    final url = '$_url/products.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodeData = json.decode(resp.body);
    final List<ProductModel> products = new List();

    if (decodeData == null) return [];

    if (decodeData['error'] != null) return [];

    decodeData.forEach((id, prod) {
      final prodTemp = ProductModel.fromJson(prod);
      prodTemp.id = id;

      products.add(prodTemp);
    });

    return products;
  }

  Future<bool> editProduct(ProductModel product) async {
    final url = '$_url/products/${product.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: productModelToJson(product));

    final decodedData = json.decode(resp.body);

    print(decodedData);
    return true;
  }

  Future<int> deleteProduct(String id) async {
    final url = '$_url/products/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    print(json.decode(resp.body));
    return 1;
  }

  Future<String> uploadImage(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dxn7yiuyp/image/upload?upload_preset=hihy35dr');
    final mineType = mime(image.path).split('/');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mineType[0], mineType[1]));

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Something went wrong');
      print(resp.body);
      return null;
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }
}
