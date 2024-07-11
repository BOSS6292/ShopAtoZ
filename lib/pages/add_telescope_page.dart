import 'package:flutter/material.dart';
import 'package:shop_a_z/models/brand.dart';
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
  String focusType = TelescopeUtils.mountList.first;
  String telescopeType = TelescopeUtils.mountList.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add TeleScopes'),
      ),
      body: const Center(
        child: Text('Add TeleScopes'),
      ),
    );
  }
}
