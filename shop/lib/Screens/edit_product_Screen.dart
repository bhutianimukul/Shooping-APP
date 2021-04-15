import 'package:flutter/material.dart';
import 'package:shop/Providers/product.dart';
import 'package:provider/provider.dart';
import '../Providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  var isinit = true;
  var initValues = {
    'title': "",
    'decription': "",
    'imageUrl': "",
    'price': "",
  };
  @override
  void didChangeDependencies() {
    if (isinit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
        initValues = {
          'title': editedProduct.title,
          'description': editedProduct.description,
          'imageUrl': editedProduct.imageUrl,
          'price': editedProduct.price.toString(),
        };
      }
    }
    isinit = false;
    super.didChangeDependencies();
  }

  final imageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var is_loading = false;
  var editedProduct = Product(
      description: "",
      id: "",
      title: "",
      isFavorite: false,
      price: 0,
      imageUrl: "");
  String imageUrl =
      'https://thumbs.dreamstime.com/z/stop-sign-icon-vector-no-available-denied-access-do-not-enter-etc-suitable-any-purposes-203083675.jpg';

  void images(String value) {
    if (value.length == 0) return;
    setState(() {
      initValues['imageUrl'] = value;
    });
  }

  void saveForm(context) async{
    FocusScopeNode f = FocusScope.of(context);
    if (!f.hasPrimaryFocus) {
      f.unfocus();
    }
    final val = formKey.currentState.validate();
    if (val == true) {
      formKey.currentState.save();
      setState(() {
        is_loading = true;
      });
      final providerData = Provider.of<Products>(context, listen: false);
      if (editedProduct.id == "") {
      try{
       await providerData.addProductListener(editedProduct);
      }catch(_){
             await showDialog<void>(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Error Found"),
                    content: Text('Something went wrong'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK')),
                    ],
                  ));
      }
      finally{
          setState(() {
            is_loading = false;
          });
          Navigator.pop(context);
      }
      } else {
        providerData.update(editedProduct.id, editedProduct);
        setState(() {
          is_loading = false;
        });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => saveForm(context),
          )
        ],
      ),

      /// body: ,
      body: is_loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: initValues['title'],
                        decoration:
                            InputDecoration(labelText: "Enter  new Title"),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          editedProduct = Product(
                              description: editedProduct.description,
                              id: editedProduct.id,
                              title: value,
                              isFavorite: editedProduct.isFavorite,
                              price: editedProduct.price,
                              imageUrl: editedProduct.imageUrl);
                        },
                        autofocus: true,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter value';
                          } else
                            return null;
                        },
                      ),
                      TextFormField(
                        initialValue: initValues['price'],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: "Enter  Price"),
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          editedProduct = Product(
                              description: editedProduct.description,
                              id: editedProduct.id,
                              title: editedProduct.title,
                              isFavorite: editedProduct.isFavorite,
                              price: double.parse(value),
                              imageUrl: editedProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter value';
                          } else if (double.parse(value) <= 0)
                            return 'Only Number allowed';
                          else
                            return null;
                        },
                      ),
                      TextFormField(
                        initialValue: initValues['description'],

                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        decoration:
                            InputDecoration(labelText: "Enter  Decription"),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter value';
                          } else
                            return null;
                        },
                        // textInputAction: TextInputAction.newline,
                        onSaved: (value) {
                          editedProduct = Product(
                              description: value,
                              id: editedProduct.id,
                              title: editedProduct.title,
                              isFavorite: editedProduct.isFavorite,
                              price: editedProduct.price,
                              imageUrl: editedProduct.imageUrl);
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            margin: EdgeInsets.only(top: 8, right: 10),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: initValues['imageUrl'] == ""
                                  ? Image.network(imageUrl)
                                  : Image.network(initValues['imageUrl']),
                            ),
                            decoration:
                                BoxDecoration(border: Border.all(width: 1)),
                          ),
                          Expanded(
                              child: TextFormField(
                            //  initialValue: initValues['imageUrl'],

                            keyboardType: TextInputType.url,
                            decoration:
                                InputDecoration(labelText: "Enter  Image Url"),
                            textInputAction: TextInputAction.done,
                            controller: imageController,
                            onFieldSubmitted: (value) => images(value),
                            validator: (value) {
                              if (initValues['imageUrl'] != "") {
                                return null;
                              } else if (value.isEmpty) {
                                return 'Enter value';
                              } else
                                return null;
                            },
                            onSaved: (value) {
                              editedProduct = Product(
                                  description: editedProduct.description,
                                  id: editedProduct.id,
                                  title: editedProduct.title,
                                  isFavorite: editedProduct.isFavorite,
                                  price: editedProduct.price,
                                  imageUrl: value.length == 0
                                      ? initValues['imageUrl']
                                      : value);
                            },
                          )),
                        ],
                      ),
                      SizedBox(height: 30),
                      Divider(
                        color: Colors.white,
                      ),
                      FlatButton(
                          onPressed: () => saveForm(context),
                          child: Text("Save")),
                      Divider(
                        color: Colors.white,
                      ),
                    ],
                  )),
            ),
    );
  }
}
