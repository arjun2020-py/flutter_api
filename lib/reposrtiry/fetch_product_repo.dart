import 'dart:convert';

import 'package:flutter_api/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  //1

  Uri url = Uri.parse('https://fakestoreapi.com/products');

  Future<List<Products>> fetchProduct() async {
    final response = await http.get(url); //'get' read data from api.

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body).cast<Map<String, dynamic>>();

      print(data);

      var products =
          data.map<Products>((json) => Products.fromJson(json)).toList();
      //api values pass to the 'produts' model.

      return products;
    } else {
      throw Exception('Failed to load');
    }

    // print(response.body);
  }

//post data in api.

  Future<void> addProduct(
      {required String title,
      required double price,
      required String decrption,
      required String catagries,
      required String image,
      required Map rating}) async {
    final reponse = await http.post(
      url,
      body: jsonEncode(//dart data convert to json
          {
        'title': title,
        'price': price,
        'description': decrption,
        'category': catagries,
        'image': image,
        'rating': rating
      }),
    );
    if (reponse.statusCode == 200) {
      print(reponse.body);
    }
  }

//put(upate) method in REST Api call.
  Future<void> updateProduct({String? id, String? title, double? price}) async {
    final reponse = await http.put(
      Uri.parse('https://fakestoreapi.com/products/$id'),
      body: jsonEncode(
        <String, dynamic>{'title': title, 'price': price},
      ),
    );
    if (reponse.statusCode == 200) {
      print(reponse.body);
    }
  }

  Future<void> deleteProduct({String? id}) async {
    final response =
        await http.delete(Uri.parse('https://fakestoreapi.com/products/$id'));

    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}
