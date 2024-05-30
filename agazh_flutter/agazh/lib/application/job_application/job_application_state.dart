part of 'job_application_bloc.dart';

@immutable
sealed class JobApplicationState {}

final class JobApplicationInitial extends JobApplicationState {}


final class JobApplicationCreationLoading extends JobApplicationState {}

final class JobApplicationSuccess extends JobApplicationState {
  final List<JobApplication> jobApplications;

  JobApplicationSuccess({required this.jobApplications});
}

final class JobApplicationCreationFailed extends JobApplicationState {
  final String message;
  final List<JobApplication> jobApplications;

  JobApplicationCreationFailed({required this.message, required this.jobApplications});
}

class GetMyApplicationsLoadingState extends JobApplicationState {}

class GetMyApplicationsFailedState extends JobApplicationState {
  final String message;

  GetMyApplicationsFailedState({required this.message});
}
