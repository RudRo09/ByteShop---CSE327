from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager

# Create your models here.


class MyAccountManager(BaseUserManager):
	# creating user
	def create_user(self, first_name, last_name, username, email, password=None):
		if not email:
			raise ValueError('No email address found!')

		if not username:
			raise ValueError('No username found!')

		user = self.model(
			email = self.normalize_email(email),
			username = username,
			first_name = first_name,
			last_name = last_name,
			)

		user.set_password(password)
		
		# saving user
		user.save(using=self._db)

		return user

	# creating super user
	def create_superuser(self, first_name, last_name, username, email, password):
		user = self.create_user(
			email = self.normalize_email(email),
			username = username,
			password = password,
			first_name = first_name,
			last_name = last_name,

			)
		# setting permissions
		user.is_admin = True
		user.is_staff = True
		user.is_active = True
		user.is_superadmin = True

		# saving user
		user.save(using=self._db)
		return user



class Account(AbstractBaseUser):
	first_name = models.CharField(max_length=25)
	last_name = models.CharField(max_length=25)
	username = models.CharField(max_length=25, unique=True)
	email = models.EmailField(max_length=50, unique=True)
	phone_number = models.CharField(max_length=11)

	# required
	date_joined = models.DateTimeField(auto_now_add=True)
	last_login = models.DateTimeField(auto_now_add=True)
	is_admin = models.BooleanField(default=False)
	is_staff = models.BooleanField(default=False)
	is_active = models.BooleanField(default=False)
	is_superadmin = models.BooleanField(default=False)

	USERNAME_FIELD = 'email'
	REQUIRED_FIELDS = ['username', 'first_name', 'last_name']

	# creating objects for MyAccountManager class
	objects = MyAccountManager()

	def __str__(self):
		return self.email

	def has_perm(self, perm, obj=None):
		return self.is_admin

	def has_module_perms(self, add_label):
		return True