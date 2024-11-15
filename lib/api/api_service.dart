import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/grievance.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Grievance>> fetchGrievances() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/grievance/showGrievance'));

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
