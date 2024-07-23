import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';
import 'package:shop_a_z/utils/widget_functions.dart';

class DescriptionPage extends StatefulWidget {
  static const String routeName = 'description';
  final String id;

  const DescriptionPage({super.key, required this.id});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  final controller = TextEditingController();
  String? description;

  @override
  void didChangeDependencies() {
    description = Provider.of<TelescopeProvider>(context, listen: false)
        .findTelescopeById(widget.id)
        .description;
    if (description != null) {
      controller.text = description!;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Description'),
        actions: [
          IconButton(onPressed: _saveDescription, icon: const Icon(Icons.save))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.grey,
          height: double.infinity,
          child: TextField(
            controller: controller,
            maxLines: 1000,
            autofocus: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          )),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _saveDescription() {
    if (controller.text.isEmpty) {
      showMsg(context, 'Field is Empty');
      return;
    }
    EasyLoading.show(status: 'Please Wait');
    Provider.of<TelescopeProvider>(context,listen: false)
        .updateTelescopeField(widget.id, 'description', controller.text)
    .then((value) => {
      showMsg(context, 'Description Updated'),
      EasyLoading.dismiss(),
    })
    .catchError((error){
      EasyLoading.dismiss();
      showMsg(context, error);
    });
  }
}
