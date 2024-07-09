import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';

class BrandPage extends StatelessWidget {
  static const String routeName = 'brand';

  const BrandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Brand'),
      ),
      body: Consumer<TelescopeProvider>(
        builder: (context, provider, child) => provider.brandList.isEmpty
            ? const Center(
          child: Text('No Brand Found'),
        )
        : ListView.builder(
          itemCount: provider.brandList.length,
          itemBuilder: (context,index) {
            final brand = provider.brandList[index];
            return ListTile(
              title: Text(brand.name),
            );
          },
        ),
      ),
    );
  }
}
