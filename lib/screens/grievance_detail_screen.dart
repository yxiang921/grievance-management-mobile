import 'package:flutter/material.dart';
import 'package:grievance_mobile/api/constant.dart';
import 'package:grievance_mobile/models/grievance.dart';
import 'package:grievance_mobile/utils/colors.dart';

class GrievanceDetailsPage extends StatelessWidget {
  final Grievance grievance;

  const GrievanceDetailsPage({Key? key, required this.grievance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imageUrl = grievance.grievanceImage == null
        ? '${APIConstant.BASE_URL}/images/no_image_placeholder.png'
        : '${APIConstant.BASE_URL}/${grievance.grievanceImage}';
    print('Image URL: $imageUrl');

    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primaryColor,
        title: const Text('Grievance Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          grievance.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Grievance ID: ${grievance.id}',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Status: ' + grievance.status,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 8),
                        grievance.isAssigned
                            ? Text(
                                'Assigned Date: ${grievance.assigned_at}',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                ),
                              )
                            : SizedBox(height: 0),
                        SizedBox(height: 8),
                        grievance.closed_at == null
                            ? SizedBox(height: 0)
                            : Text(
                                'Closed At: ${grievance.closed_at}',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                        SizedBox(height: 8),
                        grievance.location == null
                            ? SizedBox(height: 0)
                            : Text(
                                'Location:' + grievance.location!,
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                  fontSize: 16,
                                ),
                              ),
                        SizedBox(height: 16),
                        Text(
                          grievance.description,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Recent Grievances Section
                  // Padding(
                  //   padding: const EdgeInsets.all(16.0),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         'Other Recent Grievances',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.bold,
                  //           color: Colors.grey[600],
                  //         ),
                  //       ),
                  //       SizedBox(height: 16),
                  //       _buildGrievanceCard(),
                  //       SizedBox(height: 12),
                  //       _buildGrievanceCard(),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrievanceCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Simple description',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grievance ID',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                ),
              ),
              Text(
                'Moments ago',
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
