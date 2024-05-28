from django.contrib import admin

from core.models import Job, JobApplication, PlatformUser

# # Register your models here.
# class JobAdmin(admin.ModelAdmin):
#     list_display = ['name', 'description', 'salary']
#     search_fields = ['name', 'description']
#     list_filter = ['name', 'salary']

# admin.register(Job, JobAdmin)

# class JobApplicationAdmin(admin.ModelAdmin):
#     list_display = ['job', 'name', 'email']
#     search_fields = ['job', 'name', 'email']
#     list_filter = ['job', 'created_at']

# admin.register(JobApplication, JobApplicationAdmin)

admin.site.register(JobApplication)
admin.site.register(PlatformUser)
admin.site.register(Job)


# class UserAdmin(admin.ModelAdmin):
#     list_display = ['name', 'email', 'role']
#     search_fields = ['name', 'email']
#     list_filter = ['role']

# admin.register(User, UserAdmin)