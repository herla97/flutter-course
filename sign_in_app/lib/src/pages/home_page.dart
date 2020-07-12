import 'package:flutter/material.dart';
import 'package:sign_in_app/src/blocs/provider.dart';
import 'package:sign_in_app/src/models/product_model.dart';
import 'package:sign_in_app/src/providers/products_provider.dart';

class HomePage extends StatefulWidget {
  
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {

    final bloc  = Provider.of(context);


    return Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: _createProductsList(),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createProductsList() {
    return FutureBuilder(
      future: productsProvider.showProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if(snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) => _createItem(context, products[i]),
          );

        } else {
          return Center( child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(BuildContext context, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) {
        productsProvider.deleteProduct(product.id);
      },
      child: ListTile(
        title: Text('${product.title} - ${product.price}'),
        subtitle: Text(product.id),
        onTap: () => Navigator.pushNamed(context, 'product', arguments: product)
          .then((value) => setState((){})),
      ),
    );
  }

  Widget _createButton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product')
        .then((value) => setState((){})),
    );
  }
}