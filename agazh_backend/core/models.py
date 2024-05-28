from django.db import models

# Create your models here.

class PlatformUser(models.Model):
    user = models.OneToOneField('auth.User', on_delete=models.CASCADE, null=True)
    role = models.CharField(max_length=100, choices=[('client', 'client'), ('freelancer', 'freelancer')])
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.user.username


class Job(models.Model):
    name = models.CharField(max_length=100)
    author = models.ForeignKey(PlatformUser, on_delete=models.CASCADE, null=True,)
    description = models.TextField()
    salary = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=100, choices=[('open', 'open'), ('closed', 'closed')], null=True, default='open')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name


class JobApplication(models.Model):
    job = models.ForeignKey(Job, on_delete=models.CASCADE)
    name = models.CharField(max_length=100)
    applicant = models.ForeignKey(PlatformUser, on_delete=models.CASCADE, null=True,)
    description = models.TextField()
    status = models.CharField(max_length=100, choices=[('pending', 'pending'), ('accepted', 'accepted'), ('rejected', 'rejected')], null=True, default='pending')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name

