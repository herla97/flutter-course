import 'package:flutter/material.dart';
import 'package:sign_in_app/src/blocs/provider.dart';
import 'package:sign_in_app/src/models/product_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ProductsBloc productsBloc;

  @override
  Widget build(BuildContext context) {
    productsBloc = Provider.productsBloc(context);
    productsBloc.loadingProducts();

    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: _createProductsList(productsBloc),
      floatingActionButton: _createButton(context),
    );
  }

  Widget _createProductsList(ProductsBloc productsBloc) {
    return StreamBuilder(
      stream: productsBloc.productsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, i) =>
                _createItem(context, productsBloc, products[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(
      BuildContext context, ProductsBloc productsBloc, ProductModel product) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direction) => productsBloc.deleteProduct(product.id),
      child: Card(
        child: Column(
          children: <Widget>[
            (product.urlImg == null)
                ? Image(image: AssetImage('assets/no-image.png'))
                : FadeInImage(
                    image: NetworkImage(product.urlImg),
                    placeholder: AssetImage('assets/jar-loading.gif'),
                    height: 300.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
            ListTile(
              title: Text('${product.title} - ${product.price}'),
              subtitle: Text(product.id),
              onTap: () =>
                  Navigator.pushNamed(context, 'product', arguments: product)
                      .then((value) => setState(() {})),
            )
          ],
        ),
      ),
    );
  }

  Widget _createButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: () => Navigator.pushNamed(context, 'product')
          .then((value) => setState(() {})),
    );
  }
}
