import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/screen/main/account/account_view.dart';
import 'package:ecommerce/screen/main/home/viewmodel/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
        onPageBuilder: (context, value) =>
            DefaultTabController(length: 4, child: buildScaffold),
        viewModel: HomeViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          viewModel = model;
          model.init();
        });
  }

  Scaffold get buildScaffold => Scaffold(
        extendBody: true,
        body: TabBarView(
          controller: tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            buildCenter(),
            Container(
              color: Colors.redAccent,
            ),
            Container(
              color: Colors.orange,
            ),
            const AccountView()
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
          onPressed: () {},
          child: const Icon(Icons.shopping_cart),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  Center buildCenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Observer(builder: (_) {
            return Column(
              children: [
                Text(viewModel.displayName ?? "İsim yok"),
              ],
            );
          }),
          ElevatedButton(
              onPressed: () {
                viewModel.signOut();
              },
              child: const Text("Çıkış Yap"))
        ],
      ),
    );
  }
}
