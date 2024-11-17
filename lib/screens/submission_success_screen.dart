import 'package:flutter/material.dart';
import 'package:grievance_mobile/main.dart';
import 'package:grievance_mobile/models/grievance.dart';
import 'package:grievance_mobile/utils/colors.dart';

class ReceiptDetailsPage extends StatelessWidget {
  Grievance grievance;
  ReceiptDetailsPage({Key? key, required this.grievance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
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
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Success Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(height: 16),

                  Text(
                    'Submission Success',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 24),

                  // Grievance Details
                  _buildDetailRow('Grievance ID:', grievance.id.toString()),
                  Divider(height: 24),

                  _buildDetailRow('Title:', grievance.title),
                  Divider(height: 24),

                  _buildDetailRow(
                      'Description:',
                      grievance.description.length > 30
                          ? '${grievance.description.substring(0, 30)}...'
                          : grievance.description),
                  Divider(height: 24),

                  grievance.location != null
                      ? _buildDetailRow('Location:', grievance.location!)
                      : SizedBox(),

                  Column(
                    children: [
                      const Text(
                        'Thanks for submitting your grievance. We will review it and get back to you soon.',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 16),
                      BackButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen())),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileAvatar(String imageUrl) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primaryColor!,
          width: 2,
        ),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
