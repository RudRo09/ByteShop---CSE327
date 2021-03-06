from django.db import models
from accounts.models import Account
from byteshop.models import Product

# Create your models here.
class Payment(models.Model):
	user = models.ForeignKey(Account, on_delete=models.CASCADE)
	payment_id = models.CharField(max_length=100)
	amount_paid = models.CharField(max_length=100)
	status = models.CharField(max_length=100)
	crated_at = models.DateTimeField(auto_now_add=True)


	def __str__(self):
		return self.payment_id


class Order(models.Model):
	STATUS = (
		('New', 'New'),
		('Accepted', 'Accepted'),
		('Completed', 'Completed'),
		('Cancelled', 'Cancelled'),
		)

	user = models.ForeignKey(Account, on_delete=models.SET_NULL, null=True)
	payment = models.ForeignKey(Payment, on_delete=models.SET_NULL, blank=True, null=True)
	order_number = models.CharField(max_length=100)
	first_name = models.CharField(max_length=50)
	last_name = models.CharField(max_length=50)
	phone_number = models.CharField(max_length=25)
	email = models.CharField(max_length=50)
	address = models.CharField(max_length=100)
	city = models.CharField(max_length=100)
	area = models.CharField(max_length=100, blank=True)
	order_note = models.CharField(max_length=100, blank=True)
	order_total = models.FloatField(default=None)
	status = models.CharField(max_length=10, choices=STATUS, default='New')
	ip_address = models.CharField(blank=True, max_length=20)
	is_ordered = models.BooleanField(default=False)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)

	def __str__(self):
		return self.first_name


class OrderProduct(models.Model):
	order = models.ForeignKey(Order, on_delete=models.CASCADE)
	payment = models.ForeignKey(Payment, on_delete=models.SET_NULL, blank=True, null=True)
	user = models.ForeignKey(Account, on_delete=models.CASCADE)
	product = models.ForeignKey(Product, on_delete=models.CASCADE)
	quantity = models.IntegerField()
	product_price = models.FloatField()
	ordered = models.BooleanField(default=False)
	created_at = models.DateTimeField(auto_now_add=True)
	updated_at = models.DateTimeField(auto_now=True)


	def __str__(self):
		return self.product.product_name