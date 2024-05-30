import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/domain/job_application/job_application_model.dart';
import 'package:agazh/infrastructure/job_application/job_application_datasource.dart';

class JobApplicationRepository {
  JobApplicationRepository._();

  static final JobApplicationRepository _singeton =
      JobApplicationRepository._();

  factory JobApplicationRepository() {
    return _singeton;
  }

  Future<void> createJobApplication(JobApplication jobApplication) async {
      await JobApplicationDataSource().createJobApplication(jobApplication);
  }

  getMyApplications(Role forRole) {
    return JobApplicationDataSource().getMyApplications(forRole);
  }

  updateApplication(JobApplication application) {
    return JobApplicationDataSource().updateApplication(application);
  }

  deleteApplication(JobApplication application) {
    return JobApplicationDataSource().deleteApplication(application);
  }
}
