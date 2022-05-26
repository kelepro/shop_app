import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './product.dart';
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Smartphone Note 23 Pro',
      description: 'Buy Note23 Pro Unlocked Smartphone, 6.82'
          ' Full Screen Mobile Phone, 216G Dual Standby Phone',
      price: 29.99,
      imageUrl:
          'https://www.ubuy.vn/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNjFFQ3dELTJLSkwuX0FDX1NMMTUwMF8uanBn.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Smartphone OnePlus 5G',
      description:
          'Best smartphone 2019: iPhone, OnePlus, Samsung and Huawei compared and ranked.',
      price: 59.99,
      imageUrl:
          'https://i.guim.co.uk/img/media/2ce8db064eabb9e22a69cc45a9b6d4e10d595f06/392_612_4171_2503/master/4171.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=45b5856ba8cd83e6656fbe5c166951a4',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
    Product(
      id: 'p5',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p6',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p7',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p8',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p9',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p10',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p11',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
    Product(
      id: 'p12',
      title: 'Other product',
      description: 'Prepare any meal you want.',
      price: 99.99,
      imageUrl:
          'https://www.mountaingoatsoftware.com/uploads/blog/2016-09-06-what-is-a-product.png',
    ),
  ];
  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product product) {
    final url = Uri.parse(
      'https://fluttershopapp-9acbe-default-rtdb.firebaseio.com/products.json',
    );
    http
        .post(
      url,
      body: json.encode({
        'title': product.title,
        'description': product.description,
        'imageUrl': product.imageUrl,
        'price': product.price,
        'isFavourite': product.isFavorite,
      }),
    )
        .then((response) {
      print(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: DateTime.now().toString(),
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    });
  }

  void updateProduct(String id, Product newProduct) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
