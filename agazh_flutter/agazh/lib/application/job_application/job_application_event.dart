part of 'job_application_bloc.dart';

@immutable
sealed class JobApplicationEvent {}


class CreateApplicationEvent extends JobApplicationEvent {
  final Job job;
  final String coverLetter;

  CreateApplicationEvent({required this.job, required this.coverLetter});
}

class GetApplicationsEvent extends JobApplicationEvent {
  final Role forRole;

  GetApplicationsEvent({required this.forRole});
}

class GetApplicationsForAuthorEvent extends JobApplicationEvent {}

class UpdateApplicationEvent extends JobApplicationEvent {
  final JobApplication application;

  UpdateApplicationEvent({required this.application});
}

class DeleteApplicationEvent extends JobApplicationEvent {
  final JobApplication application;

  DeleteApplicationEvent({required this.application});
}