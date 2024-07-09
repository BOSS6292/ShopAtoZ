import 'package:flutter/material.dart';
import 'package:shop_a_z/pages/add_telescope_page.dart';
import 'package:shop_a_z/pages/brand_page.dart';

import '../pages/view_telescope_page.dart';

class DashboardModel {
  final String title;
  final IconData icon;
  final String routeName;

  const DashboardModel({
    required this.title,
    required this.icon,
    required this.routeName
  });
}

const List<DashboardModel> dashboardModelList = [
  DashboardModel(title: 'Add Telescopes', icon: Icons.add, routeName: AddTeleScope.routeName),
  DashboardModel(title: 'View Telescopes', icon: Icons.inventory, routeName: ViewTeleScope.routeName),
  DashboardModel(title: 'Brands', icon: Icons.category, routeName: BrandPage.routeName)
];
