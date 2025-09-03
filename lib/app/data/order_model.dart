import 'package:haly/app/data/cart_item_model.dart';

class Order {
  final String id;
  final DateTime orderDate;
  final List<CartItem> items;

  Order({
    required this.id,
    required this.orderDate,
    required this.items,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderDate': orderDate.toIso8601String(),
        'items': items.map((e) => e.toJson()).toList(),
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json['id'],
        orderDate: DateTime.parse(json['orderDate']),
        items: List<CartItem>.from(
            json['items'].map((x) => CartItem.fromJson(x))),
      );
}
