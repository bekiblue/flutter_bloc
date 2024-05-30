import 'package:agazh/domain/job/job_model.dart';
import 'package:agazh/infrastructure/job/job_datasource.dart';

class JobRepository {
  JobRepository._();

  static final JobRepository _singleton = JobRepository._();

  factory JobRepository() {
    return _singleton;
  }

  JobDataSource jobDataStore = JobDataSource();

  Future<List<Job>> getJobs(int? authorId) async {
    return await jobDataStore.getJobs(authorId);
  }

  createJob(Job job) {
    return jobDataStore.createJob(job);
  }

  updateJob(Job job) {
    return jobDataStore.updateJob(job);
  }

  deleteJob(Job job) {
    return jobDataStore.deleteJob(job);
  }

}