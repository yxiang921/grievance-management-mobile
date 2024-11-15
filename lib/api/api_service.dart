import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../models/grievance.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';
  final _storage = FlutterSecureStorage();

  Future<List<Grievance>> fetchGrievances() async {
    final userId = await _storage.read(key: 'userID');

    print("fetching grievances for user: $userId");

    try {
      final response =
          await http.get(Uri.parse('$baseUrl/grievance/showGrievance/$userId'));

      if (response.statusCode == 200) {
        final List<dynamic> grievanceJson = jsonDecode(response.body);

        return grievanceJson.map((json) => Grievance.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load grievances');
      }
    } catch (error) {
      throw Exception('Error fetching grievances: $error');
    }
  }
}
