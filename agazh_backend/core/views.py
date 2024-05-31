import json
from django.shortcuts import render
from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from rest_framework_simplejwt.authentication import JWTAuthentication
from django.contrib.auth import models as adminModels

import core.models as models
from core.serializer import JobApplicationSerializer, JobSerializer, PlatformUserSerializer, SignUpSerializer

# Create your views here.
def getJobs(request):
    if('authorId' in request.data):
        jobs = models.Job.objects.filter(author=request.data['authorId'])
    else:
        jobs = models.Job.objects.all()
    serializer = JobSerializer(jobs, many=True)
    return Response(serializer.data)


def createJob(request):
    serializer = JobSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        return Response(serializer.errors, status=400)
    return Response(serializer.data, status=201)


def updateJob(request):
    job = models.Job.objects.get(id=request.data['id'])
    serializer = JobSerializer(job, data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        return Response(serializer.errors, status=400)
    return Response(serializer.data)


def deleteJob(request):
    try:
        job = models.Job.objects.get(id=request.data['id'])
    except models.Job.DoesNotExist:
        return Response({'message': 'Job not found'}, status=404)
    job.delete()
    return Response({'message': 'Job deleted successfully'}, status=204)


def getUsers(request):
    users = models.PlatformUser.objects.all()
    serializer = PlatformUserSerializer(users, many=True)
    return Response(serializer.data)


def createUser(request):
    serializer = SignUpSerializer(data=request.data)
    if serializer.is_valid():
        username = serializer.validated_data.get('username')
        password = serializer.validated_data.get('password')
        role = serializer.validated_data.get('role')
    else:
        return Response(serializer.errors, status=400)
    user = adminModels.User.objects.create_user(username, password=password)
    models.PlatformUser.objects.create(user=user, role=role)
    return Response({'message': 'User created successfully'}, status=201)


@api_view(['GET'])
def get_a_user(request, pk):
    try:
        user = models.PlatformUser.objects.get(id=pk)
    except models.PlatformUser.DoesNotExist:
        return Response({'message': 'User not found'}, status=404)
        
    serializer = PlatformUserSerializer(user)
    return Response(serializer.data)


def getApplications(request):
    user = models.PlatformUser.objects.get(id=request.data['me'])
    if(request.data['role'] == 'client'):
        applications = models.JobApplication.objects.filter(job__author=user)
    else:
        applications = models.JobApplication.objects.filter(applicant=user)
    serializer = JobApplicationSerializer(applications, many=True)
    return Response(serializer.data)

def updateApplication(request):
    application = models.JobApplication.objects.get(id=request.data['id'])
    serializer = JobApplicationSerializer(application, data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        return Response(serializer.errors, status=400)
    return Response(serializer.data)

def createApplication(request):
    serializer = JobApplicationSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        return Response(serializer.errors, status=400)
    return Response(serializer.data, status=201)


def deleteApplication(request):
    try:
        application = models.JobApplication.objects.get(id=request.data['id'])
    except models.JobApplication.DoesNotExist:
        return Response({'message': 'Application not found'}, status=404)
    application.delete()
    return Response({'message': 'Application deleted successfully'}, status=204)



class Job(APIView):

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return getJobs(request)
    
    def post(self, request):
        return createJob(request)
    
    def put(self, request):
        return updateJob(request)
    
    def delete(self, request):
        return deleteJob(request)
    


class User(APIView):

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request, params=None):
        if params:
            return get_a_user(request, params)
        return getUsers(request)
    
    def post(self, request):
        return createUser(request)



class Application(APIView):

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return getApplications(request)
    
    def post(self, request):
        return createApplication(request)
    
    def put(self, request):
        return updateApplication(request)
    
    def delete(self, request):
        return deleteApplication(request)
    
    

class SignUp(APIView):

    authentication_classes = []
    permission_classes = []

    def post(self, request):
        return createUser(request)
    

@api_view(['POST'])
def me(request):
    user = request.user
    serializer = PlatformUserSerializer(user.platformuser)
    data = serializer.data
    data['email'] = user.email
    data['id'] = user.id
    return Response(data)