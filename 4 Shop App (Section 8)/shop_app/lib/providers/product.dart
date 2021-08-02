import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double price;
  bool isFavorite;

  Product({
    @required this.description,
    @required this.id,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
    this.isFavorite = false,
  });

  void _revertBack(bool oldStatus) {
    this.isFavorite = oldStatus;
    notifyListeners();
  }

  Future<void> toggleFavorite(String authToken, String userId) async {
    bool oldStatus = this.isFavorite;
    this.isFavorite = !this.isFavorite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-shop-app-udemy-6bf88-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken');
    try {
      final res = await http.put(
        url,
        body: json.encode(isFavorite),
      );
      if (res.statusCode >= 400) {
        _revertBack(oldStatus);
      }
    } catch (e) {
      _revertBack(oldStatus);
    }
  }
}
