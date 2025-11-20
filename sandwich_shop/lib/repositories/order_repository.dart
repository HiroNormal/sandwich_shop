class OrderRepository {
  int _quantity = 0;
  final int maxQuantity;

  OrderRepository({required this.maxQuantity});

  int get quantity => _quantity;

  bool get canIncrement => _quantity < maxQuantity;
  bool get canDecrement => _quantity > 0;

  void increment() {
    if (canIncrement) {
      _quantity++;
    }
  }

  void decrement() {
    if (canDecrement) {
      _quantity--;
    }
  }
}

class PricingRepository {
  final int quantity;
  final bool isFootlong;

  static const int sixInchPrice = 7;
  static const int footlongPrice = 11;

  PricingRepository({required this.quantity, required this.isFootlong});

  int totalPrice() {
    final unit = isFootlong ? footlongPrice : sixInchPrice;
    return quantity * unit;
  }
}