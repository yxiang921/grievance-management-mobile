import 'package:flutter/material.dart';
import 'package:grievance_mobile/utils/colors.dart';

class GrievanceHistoryScreen extends StatefulWidget {
  const GrievanceHistoryScreen({Key? key}) : super(key: key);

  @override
  State<GrievanceHistoryScreen> createState() => _GrievanceHistoryScreenState();
}

class _GrievanceHistoryScreenState extends State<GrievanceHistoryScreen> {
  bool showPending = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                _buildTabButton('Pending', showPending),
                const SizedBox(width: 8),
                _buildTabButton('Completed', !showPending),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildGrievanceCard(
                  'Title',
                  'Simple description',
                  'Tuesday, 10:00am',
                  'Received',
                ),
                const SizedBox(height: 12),
                _buildGrievanceCard(
                  'Title',
                  'Simple description',
                  'Tuesday, 10:00am',
                  'In Progress',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isSelected) {
    return Expanded(
      child: TextButton(
        onPressed: () {
          setState(() {
            showPending = text == 'Pending';
          });
        },
        style: TextButton.styleFrom(
          backgroundColor: isSelected ? AppColors.primaryColor : Colors.grey[300],
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildGrievanceCard(
    String title,
    String description,
    String dueDate,
    String status,
  ) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Due ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      dueDate,
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                Text(
                  status,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
