import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:image_picker/image_picker.dart';

class SubmitGrievancePage extends StatefulWidget {
  const SubmitGrievancePage({Key? key}) : super(key: key);

  @override
  _SubmitGrievancePageState createState() => _SubmitGrievancePageState();
}

class _SubmitGrievancePageState extends State<SubmitGrievancePage> {
  String? _imageUrl;
  XFile? image;
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

  Future<void> pickImage() async {
    var imagePicker = ImagePicker();

    image = await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _imageUrl = image?.path;
      print('Image path: $_imageUrl');
      setState(() {});
    }
  }

  Future<void> _submitGrievance() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final location = _locationController.text;

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await grievanceProvider.addGrievance(
          title,
          description,
          location,
          image,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Grievance submitted successfully',
              style: TextStyle(color: AppColors.white),
            ),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit grievance: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Title and description cannot be empty')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Submit Grievance',
            style: TextStyle(
              color: AppColors.white,
            )),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Text(
                'Hello, $username',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Please fill in the details below to submit your grievance.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: _imageUrl != null
                    ? Image.network(_imageUrl!)
                    : const Center(
                        child: Text('No image selected'),
                      ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image),
                label: const Text('Upload Image'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submitGrievance,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Submit Grievance',
                  style: TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
