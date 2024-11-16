import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
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

  Future<Grievance> fetchGrievanceByID(String grievanceID) async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/showGrievanceDetails/$grievanceID'));

      if (response.statusCode == 200) {
        final grievanceJson = jsonDecode(response.body);

        return Grievance.fromJson(grievanceJson);
      } else {
        throw Exception('Failed to load grievance');
      }
    } catch (error) {
      throw Exception('Error fetching grievance: $error');
    }
  }

  Future<void> uploadGrievance(
      String title, String description, String? location, XFile? image) async {
    final uri = Uri.parse('$baseUrl/grievance/add');
    var request = http.MultipartRequest('POST', uri);

    final userID = await _storage.read(key: 'userID');

    request.fields['userID'] = userID.toString();
    request.fields['title'] = title;
    request.fields['description'] = description;
    request.fields['location'] = location ?? '';

    if (image != null) {
      final bytes = await image.readAsBytes();

      print('Image size: ${bytes.lengthInBytes} bytes');

      final file = http.MultipartFile.fromBytes('image', bytes,
          filename: image.name);
      request.files.add(file);
    }

    print('Request URL: ${uri.toString()}');
    print('Fields: ${request.fields}');

    var response = await request.send();

    print('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Grievance uploaded successfully');
    } else {
      print('Failed to upload grievance: ${response.statusCode}');
      final responseBody = await response.stream.bytesToString();
      print('Response body: $responseBody');
    }
  }
}
