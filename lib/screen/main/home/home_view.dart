import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/gradiant_box.dart';
import 'package:ecommerce/screen/auth/login/login_view.dart';
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
    tabController = TabController(length: 3, vsync: this);
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
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            buildCenter(),
            Container(color: Colors.redAccent,),
            Container(color: Colors.orange,),
            Container(color: Colors.green,),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: TabBar(
            labelColor: themeData.bottomAppBarTheme.surfaceTintColor,
            unselectedLabelColor: themeData.unselectedWidgetColor,
            indicator: const BoxDecoration(),
            tabs: const <Widget>[
             Tab(text: "Anasayfa", icon: Icon(Icons.home_rounded), iconMargin: EdgeInsets.only(bottom: 2),),
             Tab(text: "Kategoriler", icon: Icon(Icons.category), iconMargin: EdgeInsets.only(bottom: 2),),
             Tab(text: "Favoriler", icon: Icon(Icons.favorite), iconMargin: EdgeInsets.only(bottom: 2),),
             Tab(text: "Hesabım", icon: Icon(Icons.account_circle_rounded), iconMargin: EdgeInsets.only(bottom: 2),),

            ],
          ),


        ),
      );

  Center buildCenter() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Observer(builder: (_) {
            return Text("viewModel.user.email");
          }),
          ElevatedButton(
              onPressed: () {
                viewModel.signOut();
              },
              child: Text("Çıkış Yap"))
        ],
      ),
    );
  }
}
