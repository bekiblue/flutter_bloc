import 'package:agazh/agazsh_route_config.dart';
import 'package:agazh/application/auth/auth_bloc.dart';
import 'package:agazh/application/auth/auth_events.dart';
import 'package:agazh/application/auth/auth_states.dart';
import 'package:agazh/application/job/job_bloc.dart';
import 'package:agazh/application/job_application/job_application_bloc.dart';
import 'package:agazh/domain/auth/user_model.dart';
import 'package:agazh/domain/job/job_model.dart';
import 'package:agazh/domain/job_application/job_application_model.dart';
import 'package:agazh/presentation/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FreelancerHomeScreen extends StatefulWidget {
  const FreelancerHomeScreen({super.key});

  @override
  State<FreelancerHomeScreen> createState() => _FreelancerHomeScreenState();
}

class _FreelancerHomeScreenState extends State<FreelancerHomeScreen> {
  final TextEditingController coverLetterController = TextEditingController();

  @override
  void dispose() {
    coverLetterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<JobBloc>(context).add(GetJobsEvent());
    BlocProvider.of<JobApplicationBloc>(context)
        .add(GetApplicationsEvent(forRole: Role.freelancer));
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthIitialState) {
          context.go(PathName.logIn);
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthBloc>(context).add(LogoutEvent());
                      },
                      child: const Text(
                        "Log out",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  )
                ],
              ),
            ),
            appBar: AppBar(
              title: const Text('Hello, Freelancer!'),
            ),
            body: TabBarView(
              children: [
                BlocBuilder<JobBloc, JobState>(
                  builder: (context, state) {
                    if (state is JobsLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is JobsLoadingFailed) {
                      return Text(state.message);
                    } else if (state is JobsLoaded) {
                      var jobs = state.jobs;
                      return ListView.builder(
                        itemCount: jobs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => _showApplyDialog(context, jobs[index]),
                            title: Text(jobs[index].name),
                            subtitle: Text(jobs[index].description),
                            trailing: Text(
                              "\$${jobs[index].salary.toString()}",
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                //////////////////////////////////////////////////////////////////////
                BlocBuilder<JobApplicationBloc, JobApplicationState>(
                  builder: (context, state) {
                    if (state is GetMyApplicationsLoadingState) {
                      return const CircularProgressIndicator();
                    } else if (state is GetMyApplicationsFailedState) {
                      return Text(state.message);
                    } else if (state is JobApplicationSuccess) {
                      var myApplications = state.jobApplications;
                      return ListView.builder(
                        itemCount: myApplications.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => _showUpdateApplicationDialog(
                                context, myApplications[index]),
                            title: Text(myApplications[index].name),
                            subtitle: Text(myApplications[index].description),
                            trailing: SizedBox(
                              width: 120,
                              child: Row(
                                children: [
                                  Text(
                                    myApplications[index]
                                        .status
                                        .toString()
                                        .split('.')
                                        .last,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      BlocProvider.of<JobApplicationBloc>(
                                              context)
                                          .add(
                                        DeleteApplicationEvent(
                                          application: myApplications[index],
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ],
            ),
            bottomNavigationBar: const TabBar(
              tabs: [
                Tab(
                  text: 'Explore Jobs',
                ),
                Tab(
                  text: 'My Applications',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showApplyDialog(BuildContext context, Job job) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Apply for job'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Cover letter'),
            controller: coverLetterController,
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<JobApplicationBloc>(context).add(
                    CreateApplicationEvent(
                        job: job, coverLetter: coverLetterController.text));
                context.pop();
              },
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  _showUpdateApplicationDialog(
      BuildContext context, JobApplication myApplication) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Application'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'Cover letter'),
            controller: coverLetterController..text = myApplication.description,
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                BlocProvider.of<JobApplicationBloc>(context).add(
                    UpdateApplicationEvent(
                        application: myApplication
                          ..description = coverLetterController.text));
                context.pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
