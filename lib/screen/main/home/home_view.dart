import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/constants/navigation/navigation_constants.dart';
import 'package:ecommerce/core/init/navigation/navigation_service.dart';
import 'package:ecommerce/screen/main/account/account_view.dart';
import 'package:ecommerce/screen/main/categories/categories_view.dart';
import 'package:ecommerce/screen/main/favorites/favorites_view.dart';
import 'package:ecommerce/screen/main/home/viewmodel/home_view_model.dart';
import 'package:ecommerce/screen/main/main/main_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
          onPressed: () async {
            viewModel.showProgress();
            await viewModel.getBasket();
            viewModel.closeProgress();
            buildShowModalBottomSheet();
          },
          child: Observer(builder: (_) {
            return viewModel.productList != null &&
                    viewModel.productList.isNotEmpty
                ? const Icon(Icons.shopping_cart)
                : const Icon(Icons.shopping_cart_outlined);
          }),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      );

  Future<dynamic> buildShowModalBottomSheet() {
    return showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.shopping_cart),
                  SizedBox(
                    width: 4,
                  ),
                  Text("Sepetim"),
                ],
              ),
              Row(
                children: [
                  const Text("Sepeti Boşalt"),
                  IconButton(
                      onPressed: () async {
                        viewModel.showProgress();
                        await viewModel.emptyBasket();
                        await viewModel.getBasket();
                        viewModel.closeProgress();
                      },
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: themeData.colorScheme.error,
                      ))
                ],
              )
            ],
          ),
          children: [
            Observer(builder: (_) {
              return viewModel.productList.isNotEmpty
                  ? ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewModel.productList.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: Key(
                              viewModel.productList[index].product.productId),
                          onDismissed: (direction) {
                            viewModel.removeBasket(
                                viewModel.productList[index].product.productId);
                            viewModel.getBasket();
                          },
                          background: Container(
                            color: themeData.colorScheme.secondary,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 16.0),
                                  child: Icon(
                                    Icons.delete_forever_rounded,
                                    color: themeData.cardColor,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: Icon(
                                    Icons.delete_forever_rounded,
                                    color: themeData.cardColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          child: buildBasketListTile(index),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                    )
                  : Container(
                      padding: const EdgeInsets.all(24),
                      child: const Text("Sepetinizde ürün yok."));
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Observer(builder: (_) {
                  return Text(
                      "Toplam: ${viewModel.totalPrice.toStringAsFixed(2)} ₺");
                }),
                OutlinedButton(
                    onPressed: () async {
                      viewModel.showProgress();
                      await viewModel.completeShop();
                      await viewModel.getBasket();
                      viewModel.closeProgress();
                    },
                    child: Text("Alışverişi Tamamla")),
              ],
            )
          ],
        );
      },
    );
  }

  ListTile buildBasketListTile(int index) {
    return ListTile(
        onTap: () {
          NavigationService.instance.navigateToPage(
              path: NavigationConstants.PRODUCT_DETAILS_VIEW,
              data: viewModel.productList[index].product);
        },
        leading: Image.network(
            viewModel.productList[index].product.productImageThumbnailUrl),
        title: Text(
          viewModel.productList[index].product.productName,
          maxLines: 1,
        ),
        subtitle: Text(
          viewModel.productList[index].product.productBrand.brandName,
          maxLines: 1,
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                "${viewModel.productList[index].product.productPrice * viewModel.productList[index].count} ₺"),
          ],
        ));
  }
}
