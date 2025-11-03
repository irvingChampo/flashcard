import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/network/http_client.dart';
import '../models/deck_detail_model.dart';

abstract class DeckDetailRemoteDatasource {
  Future<DeckDetailModel> fetchDeckDetails(String id);
}

class DeckDetailRemoteDatasourceImpl implements DeckDetailRemoteDatasource {
  final http.Client client;
  final String? apiURL = dotenv.env['API_URL'];

  DeckDetailRemoteDatasourceImpl({http.Client? client})
      : client = client ?? HttpClient().client;

  @override
  Future<DeckDetailModel> fetchDeckDetails(String id) async {
    final url = Uri.parse('$apiURL/decks/$id');
    try {
      final response = await client.get(url, headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        return DeckDetailModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException("Código: ${response.statusCode}");
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}