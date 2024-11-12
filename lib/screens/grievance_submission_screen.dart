import 'package:flutter/material.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class SubmitGrievancePage extends StatefulWidget {
  const SubmitGrievancePage({Key? key}) : super(key: key);

  @override
  _SubmitGrievancePageState createState() => _SubmitGrievancePageState();
}

class _SubmitGrievancePageState extends State<SubmitGrievancePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
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
                'Hello, John Doe!',
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

              SizedBox(height: 16),

              // Title field
              Container(
                decoration: _buildInputDecoration(),
                child: const TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                    hintText: 'Title',
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Grievance Details field
              Container(
                decoration: _buildInputDecoration(),
                child: TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                    hintText: 'Grievance Details',
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Venue field
              Container(
                decoration: _buildInputDecoration(),
                child: TextField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2.0),
                    ),
                    hintText: 'Venue',
                    contentPadding: EdgeInsets.all(16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Image preview
              if (_imageFile != null)
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: FileImage(_imageFile!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image:
                          NetworkImage('https://via.placeholder.com/400x200'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              SizedBox(height: 16),

              // Upload button
              InkWell(
                onTap: _pickImage,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Colors.blue[700]),
                      SizedBox(width: 8),
                      Text(
                        'Upload File or Screenshot',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),

              // Submit button
              ElevatedButton(
                onPressed: () {
                  // Handle submission
                },
                child: Text('Submit Grievance'),
                style: ElevatedButton.styleFrom(
                  // primary: Colors.blue[700],
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
