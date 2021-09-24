from django.db import models
from byteshop.models import Product
from accounts.models import Account

# Create your models here.
class Cart(models.Model):
	cart_id = models.CharField(max_length=100, blank=True)
	date_added = models.DateField(auto_now_add=True)


	def __str__(self):
		return self.cart_id


class CartItem(models.Model):
	user = models.ForeignKey(Account, on_delete=models.CASCADE, null=True)
	product = models.ForeignKey(Product, on_delete=models.CASCADE)
	cart = models.ForeignKey(Cart, on_delete=models.CASCADE, null=True)
	quantity = models.IntegerField()
	is_active = models.BooleanField(default=True)


	def __str__(self):
			return self.product.product_name


	def sub_total(self):
		return self.product.price * self.quantity


	class Meta:
		verbose_name = 'Cart items'
		verbose_name_plural = 'Cart Items'
