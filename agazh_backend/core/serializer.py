from rest_framework import serializers
from .models import Job, JobApplication, PlatformUser

class JobSerializer(serializers.ModelSerializer):
    class Meta:
        model=Job
        fields=('id', 'name','author', 'description', 'salary', 'status', 'created_at', 'updated_at')


class PlatformUserSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()

    class Meta:
        model = PlatformUser
        fields = ('username', 'role', 'created_at', 'updated_at')

    def get_username(self, obj):
        return obj.user.username


class JobApplicationSerializer(serializers.ModelSerializer):
    class Meta:
        model=JobApplication
        fields=('id', 'job', 'name', 'applicant', 'description', 'status', 'created_at', 'updated_at')


class SignUpSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField()
    role = serializers.CharField()