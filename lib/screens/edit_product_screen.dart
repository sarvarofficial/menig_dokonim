import 'package:flutter/material.dart';
import 'package:menig_dokonim/models/product_model.dart';
import 'package:menig_dokonim/provider/products.dart';
import 'package:menig_dokonim/screens/home_page.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routName = '/edit-product';

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _form = GlobalKey<FormState>();
  final _imageForm = GlobalKey<FormState>();
  var _product = Product(
    id: "",
    title: "",
    description: "",
    imageUrl: "",
    price: 0,
  );
  bool _hasImage=true;
  bool _init=true;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if(_init){
      final productId=ModalRoute.of(context)!.settings.arguments;
      if(productId!=null){
        final _editingProduct=Provider.of<Products>(context).findById(productId as String);
        _product=_editingProduct;
      }
    }
    _init=false;
  }

  Future showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Rasm URL-ni kiriting:"),
            content: Form(
              key: _imageForm,
              child: TextFormField(initialValue: _product.imageUrl,
                decoration: const InputDecoration(
                  labelText: "Rasm URL",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Iltimos rasm URL-ni kiriting:";
                  } else if (!value.startsWith('http')) {
                    return "Iltimos to'g'ri URL-ni kiriting:";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  _product = Product(
                    id: _product.id,
                    title: _product.title,
                    description: _product.description,
                    imageUrl: newValue!,
                    price: _product.price,
                    isFavorite: _product.isFavorite,
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _hasImage=false;

                    });

                    Navigator.of(context).pop();
                  },
                  child: Text("BEKOR QILISH")),
              ElevatedButton(onPressed:(){ _saveImageForm();}, child: Text("SAQLASH"))
            ],
          );
        });
  }

  void _saveImageForm() {
    final isValid = _imageForm.currentState!.validate();
    if (isValid) {
      _imageForm.currentState!.save();
      setState(() {
        _hasImage=true;
      });
      Navigator.of(context).pop();
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();
    print(isValid);
    if(isValid&&_hasImage ){
      _form.currentState!.save();
      setState(() {

      });
      if(_product.id.isEmpty){
        Provider.of<Products>(context,listen: false).addProduct(_product);
      }
      else{
        Provider.of<Products>(context,listen: false).updateProduct(_product);

      }
      Navigator.of(context).pop();


    }


  }

  @override
  Widget build(BuildContext context) {
    print(_product.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("mahsulot qo'shish"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _form,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  initialValue: _product.title,
                  decoration: const InputDecoration(
                    labelText: "Nomi",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot nomini kiriting:";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: newValue!,
                      description: _product.description,
                      imageUrl: _product.imageUrl,
                      price: _product.price,
                      isFavorite: _product.isFavorite,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product.price.toString(),
                  decoration: const InputDecoration(
                    labelText: "Narxi",
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot narxini kiriting:";
                    } else if (double.parse(value) == null) {
                      return "Iltimos to'g'ri narx kiriting:";
                    } else if (double.parse(value) < 1) {
                      return "Mahsulot narxi 0 dan katta bo'lishi kerak:";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      description: _product.description,
                      imageUrl: _product.imageUrl,
                      price: double.parse(newValue!),
                      isFavorite: _product.isFavorite,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  initialValue: _product.description,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    labelText: "Mahsulot haqida",
                    border: OutlineInputBorder(),
                  ),
                  textInputAction: TextInputAction.newline,
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Iltimos mahsulot nomini kiriting:";
                    } else if (value.length < 10) {
                      return "Iltimos batafsilroq ma'lumot kiriting:";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _product = Product(
                      id: _product.id,
                      title: _product.title,
                      description: newValue!,
                      imageUrl: _product.imageUrl,
                      price: _product.price,
                      isFavorite: _product.isFavorite,
                    );
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: _hasImage? Colors.grey:Colors.red,width: _hasImage? 1:2)),
                  child: InkWell(

                    onTap: () {
                      showImageDialog(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 180,
                      width: double.infinity,
                      child: _product.imageUrl.isEmpty? Text(
                        "Rasm URL-ni kiriting:",
                        style: TextStyle(color: _hasImage? Colors.black54:Colors.red, fontSize: 16),
                      ):Image.network(_product.imageUrl,fit: BoxFit.cover,width: double.infinity,)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
