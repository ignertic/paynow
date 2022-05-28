## [1.0.7] - Fix Paynow Redirect Error
## [1.1.0] - Patch Payment Stream Listener
## [2.0.0] - Enable null-safety
## [2.1.1] - Fix null-safety issues
## [2.1.2] - Change amount type to String [obeying paynow responses]
## [2.2.0] - Auto detect method type in express checkout
## [3.0.0]
  # Breaking Changes
  - Refactored `add` to `addToCart`
  - New cart update method `remoteFromCart`
  - New model PaynowCartItem
  - Changed Payment.total to getter from function
  - Changed Payment.info to getter from function
  - Added Payment.clear method to clear cart
  - Added Payment.deleteCartItem to remove item from cart
  - Added Payment.cartItems to list all items in the cart