import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/customwidgets/image_holder_view.dart';
import 'package:shop_a_z/models/image_model.dart';
import 'package:shop_a_z/models/telescope.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';
import 'package:shop_a_z/utils/helper_functions.dart';
import 'package:shop_a_z/utils/widget_functions.dart';

class TelescopeDetailsPage extends StatefulWidget {
  static const String routeName = 'telescopedetails';
  final String id;

  const TelescopeDetailsPage({super.key, required this.id});

  @override
  State<TelescopeDetailsPage> createState() => _TelescopeDetailsPageState();
}

class _TelescopeDetailsPageState extends State<TelescopeDetailsPage> {
  late Telescope telescope;
  late TelescopeProvider provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = Provider.of<TelescopeProvider>(context);
    telescope = provider.findTelescopeById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          telescope.model,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
        ),
      ),
      body: ListView(
        children: [
          CachedNetworkImage(
            width: double.infinity,
            height: 200,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            imageUrl: telescope.thumbnail.downloadUrl,
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: Card(
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                scrollDirection: Axis.horizontal,
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      getImage(ImageSource.gallery);
                    },
                    tooltip: 'Add Additional Image',
                    child: const Icon(Icons.add),
                  ),
                  if (telescope.additionalImage.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Center(
                        child: Text(
                          'Add Other Images',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                      ),
                    )
                  else
                    ...telescope.additionalImage.map((e) => ImageHolderView(
                          imageModel: e,
                          onImagePressed: () {
                            _showImageOnDialog(e);
                          },
                        )),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(telescope.description == null
                ? 'Add Description'
                : 'Show Description'),
          ),
          ListTile(
            title: Text(telescope.brand.name),
            subtitle: Text(telescope.model),
          ),
          ListTile(
            title: Text(
                'Sale Price (with discount) : ${priceAfterDiscount(telescope.price, telescope.discount)}'),
            subtitle: Text('Original Price : ${telescope.price}'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Edit Price',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Please Wait');
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Discount : ${telescope.discount}%'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Edit Discount',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Please Wait');
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          ListTile(
            title: Text('Stock : ${telescope.stock}%'),
            trailing: IconButton(
              onPressed: () {
                showSingleTextInputDialog(
                    context: context,
                    title: 'Edit Stock',
                    onSubmit: (value) {
                      EasyLoading.show(status: 'Please Wait');
                    });
              },
              icon: const Icon(Icons.edit),
            ),
          )
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source, imageQuality: 50);
    if(file != null){
      EasyLoading.show(status: 'Please Wait');
      final newImage = await provider.uploadImage(file.path);
      telescope.additionalImage.add(newImage);
      provider.updateTelescopeField(
          telescope.id!,
          'additionalImage',
          toImageList(telescope.additionalImage))
          .then((value) {
            EasyLoading.dismiss();
            showMsg(context, 'Added');
            setState(() {

            });
      })
      .catchError((error){
        EasyLoading.dismiss();
        showMsg(context, 'Fail to Add');
      });
    }
  }

  void _showImageOnDialog(ImageModel e) {
    showDialog(context: context, builder: (context)=> AlertDialog(
      content: CachedNetworkImage(
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height/2,
        imageUrl: e.downloadUrl,
        placeholder: (context,url) =>
        const Center(child: CircularProgressIndicator()),
        errorWidget: (context,url,error) => const Icon(Icons.error),
      ),
      actions: [
        IconButton(onPressed: (){
          Navigator.pop(context);
        },
            icon: const Icon(Icons.close),
        ),
        IconButton(
          onPressed: () async {
            Navigator.pop(context);
            EasyLoading.show(status: 'Please Wait');
            try{
              await provider.deleteImage(telescope.id!, e);
              telescope.additionalImage.remove(e);
              await provider.updateTelescopeField(telescope.id!, 'additionalImage', toImageList(telescope.additionalImage));
              EasyLoading.dismiss();
              setState(() {

              });
            }catch(error){
              EasyLoading.dismiss();
            }
        },
          icon: const Icon(Icons.delete),
        )
      ],
    ));
  }
}
