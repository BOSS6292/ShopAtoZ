import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shop_a_z/auth/auth_service.dart';
import 'package:shop_a_z/pages/add_telescope_page.dart';
import 'package:shop_a_z/pages/brand_page.dart';
import 'package:shop_a_z/pages/dashboard_page.dart';
import 'package:shop_a_z/pages/description_page.dart';
import 'package:shop_a_z/pages/login_page.dart';
import 'package:shop_a_z/pages/telescope_details_page.dart';
import 'package:shop_a_z/pages/view_telescope_page.dart';
import 'package:shop_a_z/providers/telescope_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => TelescopeProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }

  final _router = GoRouter(
      initialLocation: DashBoardPage.routeName,
      redirect: (context, state) {
        if (AuthService.currentUser == null) {
          return LoginPage.routeName;
        }
        return null;
      },
      routes: [
        GoRoute(
            name: DashBoardPage.routeName,
            path: DashBoardPage.routeName,
            builder: (context, state) => const DashBoardPage(),
            routes: [
              GoRoute(
                  name: ViewTeleScope.routeName,
                  path: ViewTeleScope.routeName,
                  builder: (context, state) => const ViewTeleScope(),
                  routes: [
                    GoRoute(
                        name: TelescopeDetailsPage.routeName,
                        path: TelescopeDetailsPage.routeName,
                        builder: (context, state) =>
                            TelescopeDetailsPage(id: state.extra! as String),
                        routes: [
                          GoRoute(
                            name: DescriptionPage.routeName,
                            path: DescriptionPage.routeName,
                            builder: (context, state) =>
                                DescriptionPage(id: state.extra! as String),
                          )
                        ]),
                  ]),
              GoRoute(
                name: AddTeleScope.routeName,
                path: AddTeleScope.routeName,
                builder: (context, state) => const AddTeleScope(),
              ),
              GoRoute(
                name: BrandPage.routeName,
                path: BrandPage.routeName,
                builder: (context, state) => const BrandPage(),
              )
            ]),
        GoRoute(
            name: LoginPage.routeName,
            path: LoginPage.routeName,
            builder: (context, state) => const LoginPage())
      ]);
}
