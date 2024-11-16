import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SubmitGrievancePage extends StatefulWidget {
  const SubmitGrievancePage({Key? key}) : super(key: key);

  @override
  _SubmitGrievancePageState createState() => _SubmitGrievancePageState();
}

class _SubmitGrievancePageState extends State<SubmitGrievancePage> {
  Uint8List? _imageBytes;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final grievanceProvider = GrievanceProvider();
  final _storage = FlutterSecureStorage();

  String? username;

  @override
  void initState() {
    super.initState();
    _initializeUsername();
  }

  void _initializeUsername() async {
    username = await _storage.read(key: 'username');
    setState(() {});
  }

  _submitGrievance() {
    print("Submit Clicked");
    final title = _titleController.text;
    final description = _descriptionController.text;
    final location = _locationController.text;

    if (title.isEmpty || description.isEmpty) {
      return;
    } else {
      grievanceProvider.submitGrievance(
        title,
        description,
        location,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Submit Grievance',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 8),
              Text(
                'Hello, $username',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Please fill in the details below to submit your grievance.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: _buildInputDecoration(),
                child: TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: _buildInputDecoration(),
                child: TextField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                    hintText: 'Enter your grievance details here...',
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                decoration: _buildInputDecoration(),
                child: TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location (Optional)',
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: _imageBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      )
                    : Image.network(
                        'https://via.placeholder.com/400x20',
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
              ),
              SizedBox(height: 16),
              InkWell(
                // onTap: _pickImage,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: AppColors.primaryColor),
                      SizedBox(width: 8),
                      Text(
                        'Upload File or Screenshot',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  _submitGrievance();
                },
                child: Text('Submit Grievance'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildInputDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.grey[300]!),
    );
  }
}
