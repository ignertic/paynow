import '_paynow_cart_item.dart';

class Payment {
  /// The unique identifier for the transaction.
  final String reference;

  /// Cart Items.
  /// [PaynowCartItem]
  /// To hold a product or service information
  /// [int]
  /// Represents the quantity of the item

  final Map<PaynowCartItem, int> items;
  get cartItems => items;

  /// The user's email address.
  final String authEmail;

  Payment({
    required this.reference,
    required this.authEmail,
    required this.items,
  });

  factory Payment.fromMap(data){
    return Payment(
      reference: data['reference'],
      authEmail: data['authEmail'],
      items: data['items']
        .map((paynowCartItemData)
          =>PaynowCartItem.fromMap(paynowCartItemData))
    );
  }

  /// Clear all the items in the cart
  void clearCart(){
    this.items.clear();
  }

  /// Delete Item from cart
  void deleteCartItem(PaynowCartItem cartItem){
    this.items.remove(cartItem);
  }

  /// Adding [PaynowCartItems] to [Payment.items]
  /// [quantity]
  void addToCart(PaynowCartItem cartItem, { int? quantity }) {
    if (this.items.containsKey(cartItem)){
      /// then increment quantity by 1 if [quantity] is null
      this.items[cartItem] = this.items[cartItem]! + (quantity ?? 1);
    }else{
      /// Add new item to cart with initial quantity of 1 if [quantity] is null
      this.items[cartItem] = quantity ?? 1;
    }
  }

  /// Remove [PaynowCartItem]s from [Payment.items]
  void removeFromCart(PaynowCartItem cartItem, { int? quantity }) {
    if (this.items.containsKey(cartItem)){

      /// then decreement quantity by 1 if [quantity] is null
      this.items[cartItem] = this.items[cartItem]! - (quantity ?? 1);
      // remove map if it has reached 0 or below
      if (this.items[cartItem]! <= 0){
        this.items.remove(cartItem);
      }
    }

  }

  /// Return Info of items in cart.
  String get info => this.items.keys.fold<String>('', (previous, item)=>previous+item.title);

  /// Total amount of items in cart.

  double get total => this.items.entries.fold<double>(
    0.0, (previous, item)
      => double.parse(
        (previous+item.key.amount * item.value).toStringAsExponential(2)
      ) );

}
