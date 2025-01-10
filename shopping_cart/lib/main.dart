import 'package:flutter/material.dart';
import 'package:shopping_cart/CartItem.dart';
import 'package:shopping_cart/item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Shopping Cart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

int total = 0;

class _MyHomePageState extends State<MyHomePage> {
  List<Item> items = <Item>[
    Item(name: 'iPhone 15', price: 1500),
    Item(name: 'MacBook Pro', price: 2500),
    Item(name: 'iPad Pro', price: 10000),
  ];

  final List<GlobalKey<CartItemState>> cartItemKeys = [];
  List<int> quantities = []; // เก็บจำนวนสินค้าของแต่ละรายการ

  @override
  void initState() {
    super.initState();
    cartItemKeys.addAll(items.map((_) => GlobalKey<CartItemState>()));
    quantities = List<int>.filled(items.length, 1); // ตั้งค่าเริ่มต้นเป็น 1
  }

  void updateTotal(int index, int quantity) {
    setState(() {
      quantities[index] = quantity; // อัปเดตจำนวนสินค้าในรายการ
      total = 0;
      for (int i = 0; i < items.length; i++) {
        total += quantities[i] * items[i].price.toInt();
      }
    });
  }

  void resetCart() {
    for (var key in cartItemKeys) {
      key.currentState?.resetQuantity();
    }
    setState(() {
      total = 0;
      quantities = List<int>.filled(items.length, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            for (int i = 0; i < items.length; i++)
              CartItem(
                key: cartItemKeys[i],
                items: items[i],
                onQuantityChanged: (quantity) => updateTotal(i, quantity),
              ),
            Expanded(
              child: Container(),
            ),
            Container(
              width: double.infinity,
              height: 100,
              color: Colors.grey[200],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Total: \$${total.toString()}',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  ElevatedButton(
                    onPressed: resetCart,
                    child: const Text('Reset Cart'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
