import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/components/card/brand_card.dart';
import 'package:ecommerce/screen/main/main/viewmodel/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/base/view/base_view.dart';
import '../../../core/components/card/horizontal_product_card.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';

class MainView extends StatefulWidget {
  const MainView({Key key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends BaseState<MainView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, MainViewModel value) => buildScaffold(value),
        viewModel: MainViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Scaffold buildScaffold(MainViewModel viewModel) => Scaffold(
        appBar: AppBar(
          leading: Observer(
            builder: (_) {
              return viewModel.isSearching
                  ? IconButton(
                      onPressed: () => viewModel.changeSearch(),
                      icon: Icon(Icons.arrow_back_ios_new))
                  : const Icon(Icons.home_rounded);
            },
          ),
          title: Observer(
            builder: (_) {
              return viewModel.isSearching
                  ? _buildSearchField(viewModel)
                  : Text(
                      "Anasayfa",
                      style: themeData.textTheme.titleLarge.copyWith(
                          color: themeData.colorScheme.onBackground,
                          fontWeight: FontWeight.w400),
                    );
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: themeData.colorScheme.onBackground),
          actionsIconTheme:
              IconThemeData(color: themeData.colorScheme.onBackground),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                if (viewModel.isSearching) {
                  print("aranıyor");
                } else {
                  viewModel.changeSearch();
                }
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Observer(builder: (_) {
            return viewModel.isSearching
                ? SizedBox(
                    height: dynamicHeight(1),
                    child: Observer(
                        builder: (_) => viewModel.searchedList.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                itemCount: viewModel.searchedList.length,
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    onTap: () => NavigationService.instance
                                        .navigateToPage(
                                            path: NavigationConstants
                                                .PRODUCT_DETAILS_VIEW,
                                            data:
                                                viewModel.searchedList[index]),
                                    leading: Image.network(viewModel
                                        .searchedList[index]
                                        .productImageThumbnailUrl),
                                    title: Text(
                                        "${viewModel.searchedList[index].productBrand.brandName} "),
                                    subtitle: Text(viewModel
                                        .searchedList[index].productName),
                                  );
                                })
                            : const SizedBox.shrink()),
                  )
                : Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Observer(builder: (_) {
                              return FilterChip(
                                  label: const Text("Hepsi"),
                                  selected: viewModel.selectedCategory == "all",
                                  onSelected: (value) {
                                    viewModel.selectCategory("all");
                                  });
                            }),
                            buildCategoryChips(viewModel),
                          ],
                        ),
                      ),
                      const Divider(
                        height: 16,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      buildPopularProducts(viewModel),
                      buildNewProducts(viewModel),
                      const Divider(),
                      Observer(builder: (_) {
                        return viewModel.brandsList != null
                            ? viewModel.brandsList.isNotEmpty
                                ? ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: viewModel.brandsList.length,
                                    itemBuilder: (context, index) {
                                      return BrandCard(
                                        brandModel: viewModel.brandsList[index],
                                      );
                                    },
                                  )
                                : const SizedBox.shrink()
                            : const SizedBox.shrink();
                      })
                    ],
                  );
          }),
        ),
      );

  Observer buildNewProducts(MainViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.newProductsList != null
          ? viewModel.newProductsList.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Yeni ürünler"),
                          InkWell(
                            onTap: () {
                              viewModel.goToNewProducts();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tümünü gör",
                                style: themeData.textTheme.bodySmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                        itemCount: viewModel.newProductsList.length,
                        itemBuilder: (context, itemIndex, pageViewIndex) {
                          return HorizontalProductCard(
                            productModel: viewModel.newProductsList[itemIndex],
                            themeData: themeData,
                            onPressed: () {},
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            pageSnapping: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            viewportFraction: 0.95,
                            height: dynamicHeight(0.18))),
                  ],
                )
              : const SizedBox.shrink()
          : const SizedBox.shrink();
    });
  }

  Observer buildPopularProducts(MainViewModel viewModel) {
    return Observer(builder: (_) {
      return viewModel.popularProductsList != null
          ? viewModel.popularProductsList.isNotEmpty
              ? Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Haftanın en popüler ürünleri"),
                          InkWell(
                            onTap: () {
                              viewModel.goToAllPopularProducts();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Tümünü gör",
                                style: themeData.textTheme.bodySmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    CarouselSlider.builder(
                        itemCount: viewModel.popularProductsList.length,
                        itemBuilder: (context, itemIndex, pageViewIndex) {
                          return HorizontalProductCard(
                            productModel:
                                viewModel.popularProductsList[itemIndex],
                            themeData: themeData,
                            onPressed: () {
                              print(viewModel
                                  .popularProductsList[itemIndex].productName);
                            },
                          );
                        },
                        options: CarouselOptions(
                            autoPlay: true,
                            pageSnapping: true,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false,
                            viewportFraction: 0.95,
                            height: dynamicHeight(0.18))),
                  ],
                )
              : const Text("Bu kategoride hiç ürün yok.")
          : const Padding(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
              child: LinearProgressIndicator());
    });
  }

  Widget buildCategoryChips(MainViewModel viewModel) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Observer(builder: (_) {
        return Row(
          children: viewModel.categoryList.map((category) {
            return Observer(builder: (_) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: FilterChip(
                  label: Text(category.categoryName),
                  selected: category.categoryId == viewModel.selectedCategory,
                  onSelected: (a) {
                    viewModel.selectCategory(category.categoryId);
                  },
                ),
              );
            });
          }).toList(),
        );
      }),
    );
  }

  Widget _buildSearchField(MainViewModel viewModel) {
    return TextField(
      controller: viewModel.searchController,
      decoration: const InputDecoration(
        hintText: "Arama yap...",
        border: InputBorder.none,
      ),
      onChanged: (value) async {
        await viewModel.searchProducts(value);
      },
    );
  }
}
