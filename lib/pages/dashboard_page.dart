import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/auth/auth_service.dart';
import 'package:shop_a_z/customwidgets/dashboard_item_view.dart';
import 'package:shop_a_z/models/dashboard_model.dart';
import 'package:shop_a_z/pages/login_page.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';

class DashBoardPage extends StatefulWidget {
  static const String routeName = '/';

  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  void didChangeDependencies() {
    Provider.of<TelescopeProvider>(context).getAllBrands();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService.logOut()
                    .then((value) => context.goNamed(LoginPage.routeName));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: GridView.builder(
        itemCount: dashboardModelList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          final model = dashboardModelList[index];
          return DashboardItemView(
              model: model,
              onPress: (route) {
                context.goNamed(route);
              });
        },
      ),
    );
  }
}
