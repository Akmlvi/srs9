class CartItem {
  final String name;
  final double price;
  final int quantity;

  const CartItem({required this.name, required this.price, this.quantity = 1});

  double get total => price * quantity;
}

class Cart {
  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);
  bool get isEmpty => _items.isEmpty;

  void add(CartItem item) {
    if (item.price < 0) throw ArgumentError('Price must not be negative');
    if (item.quantity <= 0) throw ArgumentError('Quantity must be positive');
    _items.add(item);
  }

  void removeAt(int index) => _items.removeAt(index);

  void clear() => _items.clear();

  double get totalPrice => _items.fold<double>(0.0, (sum, i) => sum + i.total);

  double totalWithDiscount(double percent) {
    if (percent < 0 || percent > 100) {
      throw ArgumentError('Discount must be between 0 and 100');
    }
    return totalPrice * (100 - percent) / 100;
  }
}