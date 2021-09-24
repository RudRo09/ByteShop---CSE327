from django import forms
from .models import Order, Payment

class OrderForm(forms.ModelForm):
	class Meta:
		model = Order
		fields = ['first_name', 'last_name', 'phone_number', 'email', 'address', 'city', 'area', 'order_note']


class PaymentForm(forms.ModelForm):
	class Meta:
		model = Payment
		fields = ['payment_id']