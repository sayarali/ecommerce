import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:ecommerce/screen/main/categories/viewmodel/categories_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/navigation/navigation_service.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({Key key}) : super(key: key);

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends BaseState<CategoriesView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, CategoriesViewModel viewModel) =>
            buildScaffold(viewModel),
        viewModel: CategoriesViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        });
  }

  Scaffold buildScaffold(CategoriesViewModel viewModel) => Scaffold(
        appBar: AppBar(
          title: const Text("Tüm Kategoriler"),
          leading: const Icon(Icons.category_rounded),
        ),
        body: Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Observer(builder: (_) {
              return viewModel.categoryList != null &&
                      viewModel.categoryList.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      itemCount: viewModel.categoryList.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.all(8),
                            alignment: Alignment.center,
                            decoration: ProjectStyles.boxDecoration,
                            child: InkWell(
                              onTap: () {
                                Map<String, dynamic> data = {};
                                data["title"] =
                                    viewModel.categoryList[index].categoryName;
                                data["option"] = "no";
                                data["category"] =
                                    viewModel.categoryList[index].categoryId;
                                data["brand"] = "no";
                                NavigationService.instance.navigateToPage(
                                    path: NavigationConstants.PRODUCTS_VIEW,
                                    data: data);
                              },
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Image.network(
                                      viewModel
                                          .categoryList[index].categoryImageUrl,
                                      errorBuilder:
                                          (context, object, stackTrace) {
                                        return CircleAvatar(
                                          child: Text(viewModel
                                              .categoryList[index]
                                              .categoryName[0]),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      viewModel
                                          .categoryList[index].categoryName,
                                      style: themeData.textTheme.titleSmall,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                    )
                  : const LinearProgressIndicator();
            })),
      );
}
