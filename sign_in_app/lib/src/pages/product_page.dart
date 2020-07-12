import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sign_in_app/src/utils/utils.dart' as utils;
import 'package:sign_in_app/src/models/product_model.dart';
import 'package:sign_in_app/src/providers/products_provider.dart';

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey     = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final productProvider = new ProductsProvider();

  ProductModel product = new ProductModel();
  bool _saving = false;

  PickedFile photo;

  @override
  Widget build(BuildContext context) {

    final ProductModel prodArg = ModalRoute.of(context).settings.arguments;
    if(prodArg != null ) {
      product = prodArg;
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Product'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _selectPhoto,
          ),
          IconButton(
            icon: Icon(Icons.camera),
            onPressed: _takePhoto,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _showPhoto(),
                _createName(),
                _createPrice(),
                _createAvailable(),
                _createButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product'
      ),
       onSaved: (value) => product.title = value,
      // validator: (value) {
      //   if (value.length < 3) {
      //     return 'Ingrese el nombre del producto'
      //   } else  {
      //     return null
      //   }
      // },
      validator: (value) => value.length < 3 
        ? 'Insert product name' 
        : null,
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.price.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price'
      ),
      onSaved: (value) => product.price = double.parse(value),
      // validator: (value) {
      //   if (utils.isNumeric(value)) {
      //     return null;
      //   }else {
      //     return 'Only numbers';
      //   }
      // },
      validator: (value) => utils.isNumeric(value)
        ? null
        : 'Only numbers',
    );
  }

  Widget _createAvailable() {
    return SwitchListTile(
      value: product.available,
      title: Text('Available'),
      activeColor: Colors.deepPurple,
      onChanged: (value) => setState(() {
        product.available = value;
      })
    );
  }


  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Save'),
      onPressed: (_saving) ? null : _submit,
    );
  }

  void _submit() {
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    setState(() { _saving = true;});

    if(product.id == null){
     productProvider.createProduct(product);
    }else{
      productProvider.editProduct(product);
    }

    // setState(() { _saving = false; });
    showSnackbar('Saved Data');
    // Navigator.pop(context);
  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _showPhoto() {
    if(product.urlImg != null) {
      return Container();
    }else{
      return Image(
        image: AssetImage(photo?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }


  _selectPhoto() {
    _processImage(ImageSource.gallery);
  }

  _takePhoto() {
    _processImage(ImageSource.camera);
  }

  _processImage(ImageSource origin) async {
    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: origin,
    );

    if (photo != null) {
      //clean
    }

    setState(() {
      photo = pickedFile;
    });
  }

}