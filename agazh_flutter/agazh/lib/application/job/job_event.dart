part of 'job_bloc.dart';

@immutable
sealed class JobEvent {}


class GetJobsEvent extends JobEvent {
  final int? authorId;    // optional. If authorId is null, all jobs will be fetched

  GetJobsEvent({this.authorId});
}

class UpdateJobEvent extends JobEvent {
  final Job job;

  UpdateJobEvent({required this.job});
}

class CreateJobEvent extends JobEvent {
  final Job job;

  CreateJobEvent({required this.job});
}

class DeleteJobEvent extends JobEvent {
  final Job job;

  DeleteJobEvent({required this.job});
}
