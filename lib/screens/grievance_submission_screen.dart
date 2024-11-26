import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:grievance_mobile/providers/grievance_provider.dart';
import 'package:grievance_mobile/providers/location_provider.dart';
import 'package:grievance_mobile/screens/submission_success_screen.dart';
import 'package:grievance_mobile/utils/colors.dart';
import 'package:grievance_mobile/widgets/location_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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

  bool _isLoading = false;

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

    final locationProvider =
        Provider.of<LocationProvider>(context, listen: false);

    String longitude = locationProvider.longitude.toString();
    String latitude = locationProvider.latitude.toString();

    setState(() {
      _isLoading = true;
    });

    if (title.isNotEmpty && description.isNotEmpty) {
      try {
        await grievanceProvider.addGrievance(
          title,
          description,
          location,
          latitude.toString(),
          longitude.toString(),
          image,
        );

        final grievance = grievanceProvider.grievances.last;

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReceiptDetailsPage(
                      grievance: grievance,
                    )));
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

    setState(() {
      _isLoading = false;
    });
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
              const Text(
                "Point the location and fill the location name for facility grievance (optional)",
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location Name (Optional)',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  setState(() {});
                },
              ),
              const SizedBox(height: 16),
              _locationController.text != ''
                  ? LocationPicker()
                  : const SizedBox(),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                child:
                    _imageUrl != null ? Image.network(_imageUrl!) : SizedBox(),
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
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                      )
                    : const Text(
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
