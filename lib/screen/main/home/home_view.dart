import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/account/account_view.dart';
import 'package:ecommerce/screen/main/categories/categories_view.dart';
import 'package:ecommerce/screen/main/favorites/favorites_view.dart';
import 'package:ecommerce/screen/main/home/viewmodel/home_view_model.dart';
import 'package:ecommerce/screen/main/main/main_view.dart';
import 'package:flutter/material.dart';

import '../../../core/components/bottom_sheet/custom_bottom_sheet.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends BaseState<HomeView> with TickerProviderStateMixin {
  TabController tabController;
  HomeViewModel viewModel;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onPageBuilder: (context, value) =>
            DefaultTabController(length: 5, child: buildScaffold),
        viewModel: HomeViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          viewModel = model;
          model.init();
        });
  }

  Scaffold get buildScaffold => Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                MainView(),
                CategoriesView(),
                SizedBox(),
                FavoritesView(),
                AccountView()
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(), //shape of notch
          notchMargin: 8,
          child: TabBar(
            controller: tabController,
            labelColor: themeData.bottomAppBarTheme.surfaceTintColor,
            unselectedLabelColor: themeData.disabledColor,
            indicator: const BoxDecoration(),
            tabs: const <Widget>[
              Tab(
                text: "Anasayfa",
                icon: Icon(Icons.home_rounded),
                iconMargin: EdgeInsets.only(bottom: 2),
              ),
              Tab(
                text: "Kategoriler",
                icon: Icon(Icons.category),
                iconMargin: EdgeInsets.only(bottom: 2),
              ),
              SizedBox.shrink(),
              Tab(
                text: "Favoriler",
                icon: Icon(Icons.favorite),
                iconMargin: EdgeInsets.only(bottom: 2),
              ),
              Tab(
                text: "Hesabım",
                icon: Icon(Icons.account_circle),
                iconMargin: EdgeInsets.only(bottom: 2),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              context: context,
              builder: (BuildContext context) {
                return CustomBottomSheet(
                  header: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("Sepetim"),
                      SizedBox(
                        width: 4,
                      ),
                      Icon(Icons.shopping_cart),
                    ],
                  ),
                  children: [Text("data")],
                );
              },
            );
          },
          child: const Icon(Icons.shopping_cart),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );
}
