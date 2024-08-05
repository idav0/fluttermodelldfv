import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/model_model.dart';

class ModelRepository {
  final String getModelUrl = 'https://vm6h7vqrr3.execute-api.us-east-1.amazonaws.com/Prod/get_products';
  final String insertModelUrl = 'https://vm6h7vqrr3.execute-api.us-east-1.amazonaws.com/Prod/insert_modelo';
  final String updateModelUrl = 'https://vm6h7vqrr3.execute-api.us-east-1.amazonaws.com/Prod/update_modelo_put';
  final String deleteModelUrl = 'https://vm6h7vqrr3.execute-api.us-east-1.amazonaws.com/Prod/delete_modelo_by_id';

  Future<List<Model>> getModels() async {
    final response = await http.get(Uri.parse(getModelUrl));

    if (response.statusCode == 200) {
      // Imprime el cuerpo de la respuesta para depuración
      print('Response body: ${response.body}');

      var data = jsonDecode(response.body);

      // Verifica si el JSON contiene la clave 'products'
      if (data is Map && data.containsKey('products')) {
        List<dynamic> modelsList = data['products'];
        // Asegúrate de que los datos sean convertibles a tu modelo
        return modelsList.map((item) => Model.fromJson(item)).toList();
      } else {
        throw Exception('Unexpected JSON format: missing "products"');
      }
    } else {
      throw Exception('Failed to load models');
    }
  }

  Future<void> createModel(Model model) async {
    final response = await http.post(
      Uri.parse(insertModelUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()..remove('id')),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to create model');
    }
  }

  Future<void> updateModel(Model model) async {
    final response = await http.put(
      Uri.parse(updateModelUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update model');
    }
  }

  Future<void> deleteModel(int id) async {
    final response = await http.delete(
      Uri.parse(deleteModelUrl),
      headers: {'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode({'id': id}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete model');
    }
  }
}
