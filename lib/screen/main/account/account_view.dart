import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ecommerce/core/components/card/setting_card.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:ecommerce/screen/main/account/viewmodel/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends BaseState<AccountView> {
  AccountViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, AccountViewModel value) =>
            buildScaffold(value),
        viewModel: AccountViewModel(),
        onModelReady: (model) {
          viewModel = model;
          model.setContext(context);
          model.init();
        });
  }

  Scaffold buildScaffold(AccountViewModel value) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: const Icon(Icons.account_box),
          iconTheme: IconThemeData(color: themeData.colorScheme.onBackground),
          title: Text(
            "Hesabım",
            style: themeData.textTheme.titleLarge.copyWith(
                color: themeData.colorScheme.onBackground,
                fontWeight: FontWeight.w400),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.notifications)),
            IconButton(
                onPressed: () {
                  _showMenuBottomSheet(context);
                },
                icon: Icon(Icons.menu)),
          ],
          actionsIconTheme:
              IconThemeData(color: themeData.colorScheme.onBackground),
        ),
        body: Observer(
          builder: (_) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: viewModel.user != null
                  ? Column(
                      children: [
                        buildProfileInfo(),
                        const Divider(),
                        value.user.emailVerified
                            ? const SizedBox()
                            : buildVerifyEmail(),
                        const Divider(),
                        Row(
                          children: [
                            Expanded(
                              child: SettingCard(
                                imageAsset: "assets/order.png",
                                label: "Siparişlerim",
                                onTap: () {
                                  buildShowOrdersBottomSheet();
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: SettingCard(
                                imageAsset: "assets/address.png",
                                label: "Adreslerim",
                                onTap: () {
                                  print("adres");
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SettingCard(
                                imageAsset: "assets/credits.png",
                                label: "Ödeme Bilgilerim",
                                onTap: () {
                                  print("ödeme");
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: SettingCard(
                                imageAsset: "assets/notifications.png",
                                label: "Bildirim Ayarları",
                                onTap: () {
                                  print("bildirim");
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 150,
                        ),
                      ],
                    )
                  : const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      );

  Future<dynamic> buildShowOrdersBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return CustomBottomSheet(header: Icon(Icons.shopping_bag), children: [
            ListTile(
              leading: CircleAvatar(
                child: Text("1"),
              ),
              title: Text("#004574532"),
              subtitle: Text("03-08-2023"),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_right_outlined)),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text("2"),
              ),
              title: Text("Sipariş Adı"),
              subtitle: Text("#054258745"),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_right_outlined)),
            ),
            ListTile(
              leading: CircleAvatar(
                child: Text("3"),
              ),
              title: Text("Sipariş Adı"),
              subtitle: Text("#054258745"),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.keyboard_arrow_right_outlined)),
            ),
          ]);
        });
  }

  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return CustomBottomSheet(
          header: const Icon(Icons.menu),
          children: [
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Ayarlar"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Çıkış Yap"),
              onTap: () {
                viewModel.logout();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildProfileInfo() {
    return InkWell(
      onTap: () {
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
                children: [
                  Text("Profili Düzenle"),
                  SizedBox(
                    width: 8,
                  ),
                  Icon(Icons.edit_note)
                ],
              ),
              children: [
                InkWell(
                    onTap: () {},
                    child: ClipOval(
                      child: Stack(
                        fit: StackFit.loose,
                        children: [
                          Image.network(
                            viewModel.user.photoURL ?? "",
                            errorBuilder: (context, error, stackTrace) {
                              return CircleAvatar(
                                child: Text(viewModel.user.displayName != null
                                    ? viewModel.user.displayName[0]
                                        .toUpperCase()
                                    : "0"),
                              );
                            },
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                color: themeData.colorScheme.primary,
                                child: Text(
                                  'Fotoğrafı Değiştir',
                                  style: themeData.textTheme.bodySmall
                                      .copyWith(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                TextField(
                  controller: viewModel.phoneController,
                  decoration: InputDecoration(
                      hintText: viewModel.user.phoneNumber ?? "Telefon",
                      prefixText: "+90",
                      prefixIcon: Icon(Icons.phone),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {},
                      ),
                      border: InputBorder.none),
                  obscureText: false,
                ),
                const Divider(),
                TextField(
                  controller: viewModel.emailController,
                  decoration: InputDecoration(
                      hintText: viewModel.user.email,
                      prefixIcon: Icon(Icons.email),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          viewModel.updateEmail();
                        },
                      )),
                  obscureText: false,
                ),
                const Divider(),
                TextField(
                  controller: viewModel.displayNameController,
                  decoration: InputDecoration(
                      hintText: viewModel.user.displayName,
                      prefixIcon: Icon(Icons.person),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.check),
                        onPressed: () {
                          viewModel.updateName();
                        },
                      )),
                  obscureText: false,
                ),
                const Divider(),
              ],
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ProjectStyles.boxDecoration,
        child: Observer(
          builder: (_) {
            return ListTile(
              leading: ClipOval(
                child: Image.network(
                  viewModel.user.photoURL ?? "",
                  errorBuilder: (context, error, stackTrace) {
                    return CircleAvatar(
                      child: Text(viewModel.user.displayName != null
                          ? viewModel.user.displayName[0].toUpperCase()
                          : "0"),
                    );
                  },
                ),
              ),
              title: Text(
                viewModel.user.displayName ?? "bilinmiyor",
                style: themeData.textTheme.titleLarge,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.user.email ?? "bilinmiyor",
                    style: themeData.textTheme.labelLarge,
                  ),
                  Text(
                    viewModel.user.phoneNumber ?? "",
                    style: themeData.textTheme.labelLarge,
                  ),
                ],
              ),
              trailing: Icon(Icons.edit),
            );
          },
        ),
      ),
    );
  }

  Widget buildVerifyEmail() {
    return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ProjectStyles.boxDecoration
            .copyWith(color: themeData.colorScheme.secondary),
        child: ListTile(
          leading: Icon(
            Icons.warning_rounded,
            color: themeData.cardColor,
          ),
          title: Text(
            "Hesabınızın güvenliği için lütfen e-posta adresinizi doğrulayın",
            style: themeData.textTheme.bodyMedium
                .copyWith(color: themeData.cardColor),
          ),
          trailing: TextButton(
            child: Text(
              "Gönder",
              style: themeData.textTheme.bodyMedium
                  .copyWith(color: themeData.cardColor),
            ),
            onPressed: () {
              viewModel.sendVerifyEmail();
            },
          ),
        ));
  }
}
