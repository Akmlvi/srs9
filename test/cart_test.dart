import 'package:flutter_test/flutter_test.dart';
import 'package:my_shop/cart.dart';

void main() {
  group('Cart Unit Tests', () {
    late Cart cart;

    setUp(() {
      cart = Cart();
    });

    test('Пустая корзина имеет сумму 0', () {
      expect(cart.isEmpty, true);
      expect(cart.totalPrice, 0);
    });

    test('Сумма нескольких товаров считается верно', () {
      cart.add(const CartItem(name: 'Хлеб', price: 100, quantity: 2));
      cart.add(const CartItem(name: 'Молоко', price: 50));
      expect(cart.totalPrice, 250);
    });

    test('Удаление товара уменьшает список', () {
      cart.add(const CartItem(name: 'Хлеб', price: 100));
      cart.add(const CartItem(name: 'Молоко', price: 50));
      cart.removeAt(0);
      expect(cart.items.length, 1);
      expect(cart.items.first.name, 'Молоко');
    });

    test('Скидка 10% считается верно', () {
      cart.add(const CartItem(name: 'Хлеб', price: 250));
      expect(cart.totalWithDiscount(10), 225);
    });

    test('Очистка корзины обнуляет сумму', () {
      cart.add(const CartItem(name: 'Хлеб', price: 100));
      cart.clear();
      expect(cart.isEmpty, true);
      expect(cart.totalPrice, 0);
    });

    test('Отрицательная цена вызывает ошибку', () {
      expect(
            () => cart.add(const CartItem(name: 'Баг', price: -5)),
        throwsArgumentError,
      );
    });

    test('Скидка больше 100% вызывает ошибку', () {
      expect(() => cart.totalWithDiscount(150), throwsArgumentError);
    });
  });
}