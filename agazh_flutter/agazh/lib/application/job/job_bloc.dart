import 'package:agazh/application/auth/auth_bloc.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/domain/job/job_model.dart';
import 'package:agazh/infrastructure/job/job_repositrory.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  JobRepository jobRepository = JobRepository();
  AuthBloc authBloc = AuthBloc();


  JobBloc() : super(JobInitial()) {
    on<GetJobsEvent>(handleGetJobs);
    on<CreateJobEvent>(handleCreateJob);
    on<UpdateJobEvent>(handleUpdateJob);
    on<DeleteJobEvent>(handleDeleteJob);
  }

  void handleGetJobs(GetJobsEvent event, emit) async {
    try {
      emit(JobsLoading());
      final List<Job> jobs = await jobRepository.getJobs(event.authorId);
      emit(JobsLoaded(jobs));
    } catch (e) {
      emit(JobsLoadingFailed(e.toString()));
    }
  }

  void handleCreateJob(CreateJobEvent event, emit) async {
    try {
      emit(JobsLoading());
      await jobRepository.createJob(event.job);
      var me = (authBloc.state as AuthSuccessState).user;
      final List<Job> jobs = await jobRepository.getJobs(me.id);
      emit(JobsLoaded(jobs));
    } catch (e) {
      emit(JobsLoadingFailed(e.toString()));
    }
  }

  handleUpdateJob(UpdateJobEvent event, emit) async {
    try {
      emit(JobsLoading());
      await jobRepository.updateJob(event.job);
      var me = (authBloc.state as AuthSuccessState).user;
      final List<Job> jobs = await jobRepository.getJobs(me.id);
      emit(JobsLoaded(jobs));
    } catch (e) {
      emit(JobsLoadingFailed(e.toString()));
    }
  }

  handleDeleteJob(DeleteJobEvent event, emit) async {
    try {
      emit(JobsLoading());
      await jobRepository.deleteJob(event.job);
      var me = (authBloc.state as AuthSuccessState).user;
      final List<Job> jobs = await jobRepository.getJobs(me.id);
      emit(JobsLoaded(jobs));
    } catch (e) {
      emit(JobsLoadingFailed(e.toString()));
    }
  }
}
