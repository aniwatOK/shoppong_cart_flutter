import 'package:flutter/material.dart';
import 'package:shopping_cart/item.dart';

class CartItem extends StatefulWidget {
  final Item items;
  final ValueChanged<int> onQuantityChanged;

  CartItem({
    super.key,
    required this.items,
    required this.onQuantityChanged,
  });

  @override
  State<CartItem> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  int quantity = 0;

  void resetQuantity() {
    setState(() {
      quantity = 0;
    });
    calculateTotal(); // รีเซ็ตจำนวนและส่งข้อมูลไปยัง MyHomePage
  }

  void calculateTotal() {
    widget.onQuantityChanged(quantity); // ส่งจำนวนสินค้าไปยัง MyHomePage
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.items.name,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Price: \$${widget.items.price}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  if (quantity > 0) {
                    quantity--;
                    calculateTotal(); // ส่งข้อมูลจำนวนที่เปลี่ยนกลับไป
                  }
                });
              },
            ),
            Text(
              '$quantity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  quantity++;
                  calculateTotal(); // ส่งข้อมูลจำนวนที่เปลี่ยนกลับไป
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
