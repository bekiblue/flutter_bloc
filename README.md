# Agazsh (አጋዥ) Mobile Application
Agazsh (አጋዥ) is a mobile application designed to connect clients with skilled laborers for tasks like electricity, water maintenance, and TV repair.

## Project Description
#### Objective
Facilitate connections between clients and professionals, making hiring simple and efficient.

#### Features
- User Authentication: Users log in with their email and password.
- User Authorization: Clients post jobs; laborers apply for them.
- User Registration: Allows both roles to register with email, password, 
- Role Assignment: Distinguishes between clients (job posters) and laborers (job applicants).
- Job Posting: Clients create job listings with specific details (title, description, skills, budget, deadline).
- Job Application: Laborers browse and apply for suitable jobs.
## Technology Stack
- Frontend: Flutter with BLoC for state management.
- Backend: Django Rest Framework for the API.
- Architecture: Domain-Driven Design (DDD) principles.
## Getting Started
#### Prerequisites
- Frontend: Flutter SDK
- Backend: Python, Django, Django Rest Framework
#### Installation

1. Clone the repository:

        git clone https://github.com/yourusername/agazsh.git
        cd agazsh
2. Frontend Setup:

       flutter pub get

3. Backend Setup:
             
        cd flutter_backend
        python -m venv env
        source env/bin/activate
        pip install -r requirements.txt
        python manage.py migrate
        python manage.py runserver

4. Run the Flutter Application:
        
        flutter run
