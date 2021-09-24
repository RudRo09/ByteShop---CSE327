from django.shortcuts import render, redirect, get_object_or_404
from django.core.exceptions import ObjectDoesNotExist
from byteshop.models import Product
from .models import Cart, CartItem
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required

def _cart_id(request):						# private funtion
	cart = request.session.session_key
	if not cart:
		cart = request.session.create()

	return cart


# Create your views here.
def add_cart(request, product_id):
	current_user = request.user
	product = Product.objects.get(id=product_id)

	# user is logged in
	if current_user.is_authenticated:
		try:
			cart = Cart.objects.get(cart_id=_cart_id(request))

		except Cart.DoesNotExist:
			cart = Cart.objects.create(
				cart_id = _cart_id(request)
				)

		cart.save()

		cart_item_exists = CartItem.objects.filter(product=product, user=current_user, cart=cart).exists()

		if cart_item_exists:
			cart_item = CartItem.objects.get(product=product, user=current_user, cart=cart)
			cart_item.quantity += 1
			cart_item.save()

		else:
			cart_item = CartItem.objects.create(
					product = product,
					quantity = 1,
					user = current_user,
					cart = cart
				)

			cart_item.save()

		return redirect('cart')

	#user is not logged in
	else:

		try:
			cart = Cart.objects.get(cart_id=_cart_id(request))

		except Cart.DoesNotExist:
			cart = Cart.objects.create(
				cart_id = _cart_id(request)
				)

		cart.save()

		cart_item_exists = CartItem.objects.filter(product=product, cart=cart).exists()
		if cart_item_exists:
			cart_item = CartItem.objects.get(product=product, cart=cart)
			cart_item.quantity += 1
			cart_item.save()

		else:
			cart_item = CartItem.objects.create(
				product = product,
				quantity = 1,
				cart = cart,
				)
			cart_item.save()

		return redirect('cart')

	# try:
	# 	cart_item = CartItem.objects.get(product=product, cart=cart)
	# 	cart_item.quantity += 1
	# 	cart_item.save()

	# except CartItem.DoesNotExist:
	# 	cart_item = CartItem.objects.create(
	# 		product = product,
	# 		quantity = 1,
	# 		cart = cart,
	# 	)

	# 	cart_item.save()

	# return redirect('cart')


def remove_cart(request, product_id):
	product = get_object_or_404(Product, id=product_id)

	try:
		if request.user.is_authenticated:
			cart_item = CartItem.objects.get(product=product, user=request.user)

		else:
			cart = Cart.objects.get(cart_id=_cart_id(request))
			cart_item = CartItem.objects.get(product=product, cart=cart)

		if cart_item.quantity > 1:
			cart_item.quantity -= 1
			cart_item.save()
		else:
			cart_item.delete()
	
	except:
		pass

	return redirect('cart')


def remove_cart_item(request, product_id):
	product = get_object_or_404(Product, id=product_id)
	if request.user.is_authenticated:
		cart_item = CartItem.objects.get(product=product, user=request.user)

	else:
		cart = Cart.objects.get(cart_id=_cart_id(request))
		cart_item = CartItem.objects.get(product=product, cart=cart)

	cart_item.delete()

	return redirect('cart')


def cart(request, total=0, quantity=0, cart_items=None):
	try:
		# print('ENTERED TRY BLOCK')
		# print('')
		if request.user.is_authenticated:
			cart_items = CartItem.objects.filter(user=request.user, is_active=True)
			# print('ENTERED IF BLOCK')
			# print('')
		else:
			# print('ENTERED ELSE BLOCK')
			# print('')
			cart = Cart.objects.get(cart_id=_cart_id(request))
			cart_items = CartItem.objects.filter(cart=cart, is_active=True)

		for cart_item in cart_items:
			# print('ENTERED FOR LOOP')
			total += (cart_item.product.price * cart_item.quantity)
			quantity += cart_item.quantity

	except ObjectDoesNotExist:
		pass
		# print('ENTERED EXCEPT BlOCK')

	context = {
		'total': total,
		'quantity': quantity,
		'cart_items': cart_items,
	}

	return render(request, 'byteshop/cart.html', context)


@login_required(login_url='login')
def checkout(request, total=0, quantity=0, cart_items=None):
	try:
		if request.user.is_authenticated:
			cart_items = CartItem.objects.filter(user=request.user, is_active=True)
		else:
			cart = Cart.objects.get(cart_id=_cart_id(request))
			cart_items = CartItem.objects.filter(cart=cart, is_active=True)
		for cart_item in cart_items:
			total += (cart_item.product.price * cart_item.quantity)
			quantity += cart_item.quantity

	except ObjectDoesNotExist:
		pass

	context = {
		'total': total,
		'quantity': quantity,
		'cart_items': cart_items,
	}

	return render(request, 'byteshop/checkout.html', context)
