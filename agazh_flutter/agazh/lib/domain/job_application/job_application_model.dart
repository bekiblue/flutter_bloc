class JobApplication {
  int job;
  String name, description;
  int applicant;
  JobApplicationStatus status;


  JobApplication({required this.job, required this.name, required this.description, required this.applicant, required this.status});

  JobApplication fromJson(Map<String, dynamic> json) {
    return JobApplication(
      job: json['job'],
      name: json['name'],
      description: json['description'],
      applicant: json['applicant'],
      status: json['status'] == 'pending' ? JobApplicationStatus.pending : json['status'] == 'accepted' ? JobApplicationStatus.accepted : JobApplicationStatus.rejected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'job': job,
      'name': name,
      'description': description,
      'applicant': applicant,
      'status': status == JobApplicationStatus.pending ? 'pending' : status == JobApplicationStatus.accepted ? 'accepted' : 'rejected',
    };
  }
}

enum JobApplicationStatus { pending, accepted, rejected }