import 'package:agazh/application/auth/auth_bloc.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/domain/job/job_model.dart';
import 'package:agazh/domain/job_application/job_application_model.dart';
import 'package:agazh/infrastructure/auth/auth_repository.dart';
import 'package:agazh/infrastructure/job_application/job_application_repositrory.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'job_application_event.dart';
part 'job_application_state.dart';

class JobApplicationBloc extends Bloc<JobApplicationEvent, JobApplicationState> {
  JobApplicationBloc() : super(JobApplicationInitial()) {
    on<CreateApplicationEvent>(createJobApplicationHandler);
    on<GetApplicationsEvent>(getMyJobApplicationsHandler);
    on<UpdateApplicationEvent>(updateJobApplicationHandler);
    on<DeleteApplicationEvent>(handleDeteleApplication);
  }

  createJobApplicationHandler(event, emit) async {
      try {
        emit(JobApplicationCreationLoading());
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');
        var me =  await AuthRepository().getMe(token!);
        final jobApplication = JobApplication(
          job: event.job.id,
          description: event.coverLetter,
          applicant: me.id,
          name: 'application for ${event.job.name}',
          status: JobApplicationStatus.pending,
        );
        await JobApplicationRepository().createJobApplication(jobApplication);
        var myApplications =  await JobApplicationRepository().getMyApplications((AuthBloc().state as AuthSuccessState).user.role);
        emit(JobApplicationSuccess(jobApplications: myApplications));
      } catch (e) {
        emit(JobApplicationCreationFailed(message: e.toString(), jobApplications: await JobApplicationRepository().getMyApplications((AuthBloc().state as AuthSuccessState).user.role)));
      }
    }


    void getMyJobApplicationsHandler(event, emit) async {
      try {
        emit(GetMyApplicationsLoadingState());
        var myApplications = await JobApplicationRepository().getMyApplications(event.forRole);
        emit(JobApplicationSuccess(jobApplications: myApplications));
      } catch (e) {
        emit(JobApplicationCreationFailed(message: e.toString(), jobApplications: const []));
      }
    }

    void updateJobApplicationHandler(UpdateApplicationEvent event, emit) async {
      try {
        emit(GetMyApplicationsLoadingState());
        await JobApplicationRepository().updateApplication(event.application);
        var myApplications =  await JobApplicationRepository().getMyApplications((AuthBloc().state as AuthSuccessState).user.role);
        emit(JobApplicationSuccess(jobApplications: myApplications));
      } catch (e) {
        emit(JobApplicationCreationFailed(message: e.toString(), jobApplications: await JobApplicationRepository().getMyApplications((AuthBloc().state as AuthSuccessState).user.role)));
      }
    }

    void handleDeteleApplication(DeleteApplicationEvent event, emit) async {
      try {
        emit(GetMyApplicationsLoadingState());
        await JobApplicationRepository().deleteApplication(event.application);
        var myApplications =  await JobApplicationRepository().getMyApplications((AuthBloc().state as AuthSuccessState).user.role);
        emit(JobApplicationSuccess(jobApplications: myApplications));
      } catch (e) {
        emit(JobApplicationCreationFailed(message: e.toString(), jobApplications: await JobApplicationRepository().getMyApplications((AuthBloc().state as AuthSuccessState).user.role)));
      }
    }
}
