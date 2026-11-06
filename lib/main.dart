import 'package:flutter/material.dart';
import 'cart.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const CartScreen(),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final Cart _cart = Cart();
  int _counter = 1;

  void _addItem() {
    setState(() {
      _cart.add(CartItem(name: 'Товар $_counter', price: 100));
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Моя корзина')),
      body: Column(
        children: [
          Expanded(
            child: _cart.isEmpty
                ? const Center(child: Text('Корзина пуста'))
                : ListView.builder(
              itemCount: _cart.items.length,
              itemBuilder: (_, i) {
                final item = _cart.items[i];
                return ListTile(
                  title: Text(item.name),
                  trailing: Text('${item.total.toStringAsFixed(0)} ₽'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Итого: ${_cart.totalPrice.toStringAsFixed(0)} ₽'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _addItem,
                child: const Text('Добавить товар'),
              ),
              const SizedBox(width: 12),
              OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CheckoutScreen(total: _cart.totalPrice),
                  ),
                ),
                child: const Text('Оформить'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class CheckoutScreen extends StatelessWidget {
  final double total;
  const CheckoutScreen({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Оформление заказа')),
      body: Center(child: Text('К оплате: ${total.toStringAsFixed(0)} ₽')),
    );
  }
}