import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/network/http_client.dart';
import '../models/deck_model.dart';

abstract class DeckRemoteDatasource {
  Future<List<DeckModel>> fetchDecks();
}

class DeckRemoteDatasourceImpl implements DeckRemoteDatasource {
  final http.Client client;
  final String? apiURL = dotenv.env['API_URL'];

  DeckRemoteDatasourceImpl({http.Client? client})
      : client = client ?? HttpClient().client;

  @override
  Future<List<DeckModel>> fetchDecks() async {
    final url = Uri.parse('$apiURL/decks');
    try {
      final response = await client.get(url, headers: {
        "Content-Type": "application/json",
      });

      if (response.statusCode == 200) {
        final List<dynamic> decoded = json.decode(response.body);
        return decoded.map((e) => DeckModel.fromJson(e)).toList();
      } else {
        throw ServerException("Código: ${response.statusCode}");
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }
}