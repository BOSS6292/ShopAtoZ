import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/customwidgets/radio_group.dart';
import 'package:shop_a_z/models/brand.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';
import 'package:shop_a_z/utils/constants.dart';

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
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Brand? brand;
  String? imageLocalPath;
  DateTime? dateTime;
  String mountDescription = TelescopeUtils.mountList.first;
  String focusType = TelescopeUtils.focusList.first;
  String telescopeType = TelescopeUtils.typeList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add TeleScopes'),
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
                        onPressed: () {},
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera'),
                      ),
                      TextButton.icon(
                        onPressed: () {},
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
                          items: provider.brandList.map((item) => DropdownMenuItem<Brand>(
                                    value: item,
                                    child: Text(item.name),
                                  )).toList(),
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
            )
          ],
        ),
      ),
    );
  }
}
