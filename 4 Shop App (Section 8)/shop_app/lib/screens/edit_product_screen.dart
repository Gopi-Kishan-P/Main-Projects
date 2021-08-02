import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  // final String title;
  // EditProductScreen({this.title});

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  var _appBarTitleText = 'Add Product';

  bool _firstTime = true;
  bool _isLoading = false;

  Product _edittedProduct = Product(
    description: '',
    id: null,
    imageUrl: '',
    price: 0,
    title: '',
  );

  var _initValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_firstTime) {
      final _productId = ModalRoute.of(context).settings.arguments as String;
      if (_productId != null) {
        _appBarTitleText = 'Edit Product';
        _edittedProduct =
            Provider.of<Products>(context, listen: false).findById(_productId);
        _initValues = {
          'title': _edittedProduct.title,
          'description': _edittedProduct.description,
          'price': _edittedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlController.text = _edittedProduct.imageUrl;
      }
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      String value = _imageUrlController.text;
      if ((!(value.startsWith('http') || value.startsWith('https'))) ||
          (!(value.startsWith('http') || value.startsWith('https')))) return;
      setState(() {});
    }
  }

  Future<void> _submit() async {
    final isValid = _form.currentState.validate();
    if (!isValid) return;
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    if (_edittedProduct.id == null) {
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(_edittedProduct);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Error Occurred'),
            content: Text('Somrthing Went Wrong'),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: Text('OK'),
              )
            ],
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    } else {
      await Provider.of<Products>(context, listen: false)
          .updateProduct(_edittedProduct.id, _edittedProduct);
      Navigator.of(context).pop();
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitleText),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _submit,
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _initValues['title'],
                        decoration: InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _edittedProduct = Product(
                            description: _edittedProduct.description,
                            id: _edittedProduct.id,
                            imageUrl: _edittedProduct.imageUrl,
                            price: _edittedProduct.price,
                            title: value,
                            isFavorite: _edittedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Empty title, Enter the title';
                          return null; // returning null means correct
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['price'],
                        decoration: InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _edittedProduct = Product(
                            description: _edittedProduct.description,
                            id: _edittedProduct.id,
                            imageUrl: _edittedProduct.imageUrl,
                            price: double.parse(value),
                            title: _edittedProduct.title,
                            isFavorite: _edittedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Price is Empty, Enter a Price';
                          if (double.parse(value) == null)
                            return 'Please Enter a valid number';
                          if (double.parse(value) < 0.0)
                            return 'Please Enter a number greater than zero';
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initValues['description'],
                        decoration: InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _edittedProduct = Product(
                            description: value,
                            id: _edittedProduct.id,
                            imageUrl: _edittedProduct.imageUrl,
                            price: _edittedProduct.price,
                            title: _edittedProduct.title,
                            isFavorite: _edittedProduct.isFavorite,
                          );
                        },
                        validator: (value) {
                          if (value.isEmpty)
                            return 'Description is Empty, Enter the Description';
                          if (value.length < 10)
                            return 'Enter the description having greater than 10 characters';
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 10, right: 10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                            ),
                            child: _imageUrlController.text.isEmpty
                                ? Text('Image Preview')
                                : FittedBox(
                                    child:
                                        Image.network(_imageUrlController.text),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  InputDecoration(labelText: 'Image URL'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (value) => _submit(),
                              onSaved: (value) {
                                _edittedProduct = Product(
                                  description: _edittedProduct.description,
                                  id: _edittedProduct.id,
                                  imageUrl: value,
                                  price: _edittedProduct.price,
                                  title: _edittedProduct.title,
                                  isFavorite: _edittedProduct.isFavorite,
                                );
                              },
                              validator: (value) {
                                if (value.isEmpty) return 'Enter a Image URL';
                                if (!(value.startsWith('http') ||
                                    value.startsWith('https')))
                                  return 'Please Enter a Valid URL';
                                if (!(value.endsWith('.png') ||
                                    value.endsWith('.jpg') ||
                                    value.endsWith('.jpeg')))
                                  return 'The URL is not an Image';
                                return null;
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
