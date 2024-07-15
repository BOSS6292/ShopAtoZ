import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/pages/telescope_details_page.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';

class ViewTeleScope extends StatefulWidget {
  static const String routeName = 'viewtelescope';

  const ViewTeleScope({super.key});

  @override
  State<ViewTeleScope> createState() => _ViewTeleScopeState();
}

class _ViewTeleScopeState extends State<ViewTeleScope> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telescopes'),
      ),
      body: Consumer<TelescopeProvider>(
        builder: (context, provider, child) => ListView.builder(
          itemCount: provider.telescopeList.length,
          itemBuilder: (context, index) {
            final telescope = provider.telescopeList[index];
            return InkWell(
              onTap: () {
                context.goNamed(TelescopeDetailsPage.routeName,extra: telescope.id);
              },
              child: Card(
                elevation: 0,
                color: Colors.transparent,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      imageUrl: telescope.thumbnail.downloadUrl,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            telescope.brand.name,
                            style: const TextStyle(fontSize: 16),
                          ),
                          Text(
                            telescope.model,
                            style: const TextStyle(
                                color: Colors.grey,
                                overflow: TextOverflow.ellipsis),
                          ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
