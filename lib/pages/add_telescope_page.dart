import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/customwidgets/radio_group.dart';
import 'package:shop_a_z/models/brand.dart';
import 'package:shop_a_z/models/telescope.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';
import 'package:shop_a_z/utils/constants.dart';
import 'package:shop_a_z/utils/widget_functions.dart';

class AddTeleScope extends StatefulWidget {
  static const String routeName = 'addtelescope';

  const AddTeleScope({super.key});

  @override
  State<AddTeleScope> createState() => _AddTeleScopeState();
}

class _AddTeleScopeState extends State<AddTeleScope> {
  final _modelController = TextEditingController();
  final _dimensionController = TextEditingController();
  final _weightController = TextEditingController();
  final _lensDiameterController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Brand? brand;
  String? imageLocalPath;
  String mountDescription = TelescopeUtils.mountList.first;
  String focusType = TelescopeUtils.focusList.first;
  String telescopeType = TelescopeUtils.typeList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add TeleScopes'),
        actions: [
          IconButton(onPressed: _saveTelescope, icon: const Icon(Icons.done))
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Card(
              child: Column(
                children: [
                  imageLocalPath == null
                      ? const Icon(
                          Icons.photo,
                          size: 100,
                        )
                      : Image.file(
                          File(imageLocalPath!),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                  const Text('Select Telescope Image\nfrom',
                      textAlign: TextAlign.center),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          getImage(ImageSource.camera);
                        },
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                        },
                        icon: const Icon(Icons.browse_gallery),
                        label: const Text('Gallery'),
                      )
                    ],
                  )
                ],
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<TelescopeProvider>(
                  builder: (context, provider, child) =>
                      DropdownButtonFormField<Brand>(
                    decoration: const InputDecoration(border: InputBorder.none),
                    hint: const Text('Select Brand'),
                    isExpanded: true,
                    value: brand,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a brand';
                      }
                      return null;
                    },
                    items: provider.brandList
                        .map((item) => DropdownMenuItem<Brand>(
                              value: item,
                              child: Text(item.name),
                            ))
                        .toList(),
                    onChanged: (value) {
                      brand = value;
                    },
                  ),
                ),
              ),
            ),
            RadioGroup(
              groupValue: telescopeType,
              label: 'Select Telescope Type',
              items: TelescopeUtils.typeList,
              onItemsSelected: (value) {
                telescopeType = value;
              },
            ),
            RadioGroup(
              groupValue: focusType,
              label: 'Select Focus Type',
              items: TelescopeUtils.focusList,
              onItemsSelected: (value) {
                focusType = value;
              },
            ),
            RadioGroup(
              groupValue: mountDescription,
              label: 'Select Mount Type',
              items: TelescopeUtils.mountList,
              onItemsSelected: (value) {
                mountDescription = value;
              },
            ),
            //modelController
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _modelController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Model',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            //dimensionController
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _dimensionController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Dimension',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            //weightController
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _weightController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Weight',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            //lensController
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _lensDiameterController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Lens Diameter(mm)',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            //priceController
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _priceController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Price',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
            //stockController
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: _stockController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Stock',
                  filled: true,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field must not be empty';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _modelController.dispose();
    _dimensionController.dispose();
    _weightController.dispose();
    _lensDiameterController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  void getImage(ImageSource imageSource) async {
    final imageFile = await ImagePicker().pickImage(source: imageSource, imageQuality: 50);
    if(imageFile != null){
      setState(() {
        imageLocalPath = imageFile.path;
      });
    }
  }

  void _saveTelescope() async {
    if (imageLocalPath == null) {
      showMsg(context, 'Please select a Telescope Image');
      return;
    }

    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please Wait!');
      try {
        final imageModel =
            await Provider.of<TelescopeProvider>(context, listen: false)
                .uploadImage(imageLocalPath!);
        final telescope = Telescope(
            model: _modelController.text,
            brand: brand!,
            type: telescopeType,
            dimension: _dimensionController.text,
            weightInPound: num.parse(_weightController.text),
            focustype: focusType,
            lensDiameterInMM: num.parse(_lensDiameterController.text),
            mountDescription: mountDescription,
            price: num.parse(_priceController.text),
            stock: num.parse(_stockController.text),
            thumbnail: imageModel,
            additionalImage: []);
        await Provider.of<TelescopeProvider>(context, listen: false)
            .addTelescope(telescope);
        EasyLoading.dismiss();
        showMsg(context, 'Saved!');
        _resetFields();
      } catch (error) {
        if (kDebugMode) {
          EasyLoading.dismiss();
          print(error);
        }
      }
    }
  }

  void _resetFields() {
    setState(() {
      _modelController.clear();
      _dimensionController.clear();
      _weightController.clear();
      _priceController.clear();
      _lensDiameterController.clear();
      _stockController.clear();
      brand = null;
      imageLocalPath = null;
      mountDescription = TelescopeUtils.mountList.first;
      focusType = TelescopeUtils.focusList.first;
      telescopeType = TelescopeUtils.typeList.first;
    });
  }
}
