import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_shop/main.dart';

void main() {
  testWidgets('Главный экран отображает заголовок, текст и кнопки', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartScreen()));

    expect(find.text('Моя корзина'), findsOneWidget);
    expect(find.text('Корзина пуста'), findsOneWidget);
    expect(find.text('Итого: 0 ₽'), findsOneWidget);
    expect(find.text('Добавить товар'), findsOneWidget);
    expect(find.text('Оформить'), findsOneWidget);
  });

  testWidgets('Нажатие на кнопку добавляет товар и меняет сумму', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartScreen()));

    await tester.tap(find.text('Добавить товар'));
    await tester.pump();

    expect(find.text('Товар 1'), findsOneWidget);
    expect(find.text('Корзина пуста'), findsNothing);
    expect(find.text('Итого: 100 ₽'), findsOneWidget);

    await tester.tap(find.text('Добавить товар'));
    await tester.pump();

    expect(find.text('Товар 2'), findsOneWidget);
    expect(find.text('Итого: 200 ₽'), findsOneWidget);
  });

  testWidgets('Переход на экран оформления передаёт сумму', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CartScreen()));

    await tester.tap(find.text('Добавить товар'));
    await tester.pump();
    await tester.tap(find.text('Оформить'));
    await tester.pumpAndSettle();

    expect(find.text('Оформление заказа'), findsOneWidget);
    expect(find.text('К оплате: 100 ₽'), findsOneWidget);
  });
}