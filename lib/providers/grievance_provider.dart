// lib/providers/grievance_provider.dart
import 'package:flutter/material.dart';
import '../api/api_service.dart';
import '../models/grievance.dart';

class GrievanceProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Grievance> _grievances = [];

  List<Grievance> get grievances => _grievances;

  Future<void> loadGrievances() async {
    try {
      _grievances = await _apiService.fetchGrievances();
      notifyListeners();
    } catch (error) {
      print('Failed to load grievances: $error');
    }
  }
}
