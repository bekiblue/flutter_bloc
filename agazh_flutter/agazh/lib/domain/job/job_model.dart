class Job {
  String name, description, salary;
  int id, author;
  JobStatus status;

  Job({this.id = 0, required this.name, required this.description, required this.salary, required this.status, required this.author});

  static Job fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      description: json['description'],
      salary: json['salary'],
      status: json['status'] == 'open' ? JobStatus.open : JobStatus.closed,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'author': author,
      'description': description,
      'salary': salary,
      'status': status == JobStatus.open ? 'open' : 'closed',
    };
  }
}

enum JobStatus { open, closed }