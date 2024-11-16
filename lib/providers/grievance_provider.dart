// lib/providers/grievance_provider.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import '../api/api_service.dart';
import '../models/grievance.dart';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class GrievanceProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Grievance> _grievances = [];

  List<Grievance> get grievances => _grievances;

  int get receivedGrievances {
    return _grievances
        .where((grievance) => grievance.status.toLowerCase() == 'received')
        .length;
  }

  int get inProgressGrievances {
    return _grievances
        .where((grievance) => grievance.status.toLowerCase() == 'in progress')
        .length;
  }

  int get closedGrievances {
    return _grievances
        .where((grievance) => grievance.status.toLowerCase() == 'closed')
        .length;
  }

  List<Grievance> get receivedGrievancesList =>
      _grievances.where((g) => g.status.toLowerCase() == 'received').toList();

  List<Grievance> get closedGrievancesList =>
      _grievances.where((g) => g.status.toLowerCase() == 'closed').toList();

  Future<void> loadGrievances() async {
    try {
      _grievances = await _apiService.fetchGrievances();
      notifyListeners();
    } catch (error) {
      print('Failed to load grievances: $error');
    }
  }

  Future<void> addGrievance(
      String title, String description, String location, String? image) async {
    try {
      await _apiService.submitGrievance(title, description, location);
      await loadGrievances();
    } catch (error) {
      print('Failed to add grievance: $error');
    }
  }
}
