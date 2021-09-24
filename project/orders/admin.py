from django.contrib import admin
from .models import Payment
from .models import Order
from .models import OrderProduct

# Register your models here.
admin.site.register(Payment)
admin.site.register(Order)
admin.site.register(OrderProduct)