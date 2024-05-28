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
    jobs = models.Job.objects.all()
    serializer = JobSerializer(jobs, many=True)
    return Response(serializer.data)


def createJob(request):
    serializer = JobSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        return Response(serializer.errors, status=400)
    return Response(serializer.data)


def getUsers(request):
    users = models.PlatformUser.objects.all()
    serializer = PlatformUserSerializer(users, many=True)
    return Response(serializer.data)


def createUser(request):
    serializer = SignUpSerializer(data=request.data)
    if serializer.is_valid():
        username = serializer.validated_data.get('username')
        password = serializer.validated_data.get('password')
    else:
        return Response(serializer.errors, status=400)
    user = adminModels.User.objects.create_user(username, password=password)
    models.PlatformUser.objects.create(user=user, role='client')
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
    applications = models.JobApplication.objects.all()
    serializer = JobApplicationSerializer(applications, many=True)
    return Response(serializer.data)

def createApplication(request):
    serializer = JobApplicationSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
    else:
        return Response(serializer.errors, status=400)
    return Response(serializer.data)



class Job(APIView):

    authentication_classes = [JWTAuthentication]
    permission_classes = [IsAuthenticated]

    def get(self, request):
        return getJobs(request)
    
    def post(self, request):
        return createJob(request)
    


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
    return Response(data)