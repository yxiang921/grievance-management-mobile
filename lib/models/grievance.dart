class Grievance {
  final int id;
  final String title;
  final String description;
  final String status;
  final String? category;
  final String? location;
  final String priority;
  final String? grievanceImage;
  final String? dueDate;
  final bool isAssigned;
  final String? outsourceRemark;
  final String? processRemark;
  final String? processImage;
  final String? person_in_charged;
  final String? latitude;
  final String? longitude;
  final int? departmentId;
  final int userId;

  final String? assigned_at;
  final String? closed_at;
  final String? createdAt;
  final String? updatedAt;

  Grievance({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.category,
    this.location,
    required this.priority,
    this.grievanceImage,
    this.dueDate,
    required this.isAssigned,
    this.outsourceRemark,
    this.processRemark,
    this.processImage,
    this.person_in_charged,
    this.latitude,
    this.longitude,
    this.departmentId,
    required this.userId,
    this.assigned_at,
    this.closed_at,
    this.createdAt,
    this.updatedAt,
  });

  factory Grievance.fromJson(Map<String, dynamic> json) {
    return Grievance(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      status: json['status'],
      category: json['category'],
      location: json['location'],
      priority: json['priority'],
      grievanceImage: json['grievance_image'],
      dueDate: json['due_date'],
      isAssigned: json['is_assigned'] == 1,
      outsourceRemark: json['outsource_remark'],
      processRemark: json['process_remark'],
      processImage: json['process_image'],
      person_in_charged: json['person_in_charged'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      departmentId: json['department_id'],
      userId: json['user_id'],
      assigned_at: json['assigned_at'],
      closed_at: json['closed_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
