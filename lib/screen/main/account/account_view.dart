import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/bottom_sheet/custom_bottom_sheet.dart';
import 'package:ecommerce/core/components/card/setting_card.dart';
import 'package:ecommerce/core/init/notifier/theme_notifier.dart';
import 'package:ecommerce/core/projectstyles/project_styles.dart';
import 'package:ecommerce/screen/main/account/viewmodel/account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/enums/app_theme_enum.dart';

class AccountView extends StatefulWidget {
  const AccountView({Key key}) : super(key: key);

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends BaseState<AccountView> {
  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, AccountViewModel value) =>
            buildScaffold(value),
        viewModel: AccountViewModel(),
        onModelReady: (model) {
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
                  _showMenuBottomSheet(context, value);
                },
                icon: Icon(Icons.menu)),
          ],
          actionsIconTheme:
              IconThemeData(color: themeData.colorScheme.onBackground),
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Column(
              children: [
                buildProfileInfo(value),
                const Divider(),
                Observer(builder: (_) {
                  return value.emailVerified
                      ? const SizedBox()
                      : buildVerifyEmail(value);
                }),
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
                        onTap: () {},
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
                          buildNotificationSettingBottomSheet(value);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 150,
                ),
              ],
            )),
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

  Future<dynamic> _showMenuBottomSheet(
      BuildContext context, AccountViewModel value) {
    return showModalBottomSheet(
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
                Provider.of<ThemeNotifier>(context, listen: false)
                    .changeValue(AppThemeEnum.DARK);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Çıkış Yap"),
              onTap: () {
                value.logout();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildProfileInfo(AccountViewModel value) {
    return InkWell(
      onTap: () {
        buildEditProfileBottomSheet(value);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: ProjectStyles.boxDecoration,
        child: Observer(
          builder: (_) {
            return value.userModel == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      const CircularProgressIndicator(),
                    ],
                  )
                : ListTile(
                    leading: ClipOval(
                      child: Image.network(
                        value.userModel.photoUrl ?? "",
                        errorBuilder: (context, error, stackTrace) {
                          return CircleAvatar(
                            child: Text(value.userModel.name != null
                                ? value.userModel.name[0].toUpperCase()
                                : "0"),
                          );
                        },
                      ),
                    ),
                    title: Text(
                      "${value.userModel.name}${value.userModel.lastName}" ??
                          "bilinmiyor",
                      style: themeData.textTheme.titleLarge,
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.userModel.email ?? "bilinmiyor",
                          style: themeData.textTheme.labelLarge,
                        ),
                        Text(
                          "+90${value.userModel.phoneNumber ?? ""}",
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

  Future<dynamic> buildEditProfileBottomSheet(AccountViewModel value) {
    return showModalBottomSheet(
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
                      Observer(
                        builder: (_) {
                          return Image.network(
                            value.userModel.photoUrl ?? "",
                            errorBuilder: (context, error, stackTrace) {
                              return CircleAvatar(
                                child: Text(value.userModel.name != null
                                    ? value.userModel.name[0].toUpperCase()
                                    : "0"),
                              );
                            },
                          );
                        },
                      ),
                      Positioned.fill(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
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
            const Divider(),
            TextField(
              controller: value.phoneController,
              decoration: InputDecoration(
                  hintText: "Telefon",
                  prefixText: "+90",
                  prefixIcon: Icon(Icons.phone),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      value.updatePhone();
                    },
                  ),
                  border: InputBorder.none),
              obscureText: false,
            ),
            const Divider(),
            TextField(
              controller: value.displayNameController,
              decoration: InputDecoration(
                  hintText: "Adı Soyadı",
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      value.updateName();
                    },
                  )),
              obscureText: false,
            ),
            const Divider(),
          ],
        );
      },
    );
  }

  final MaterialStateProperty<Icon> thumbIcon =
      MaterialStateProperty.resolveWith<Icon>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  Future<dynamic> buildNotificationSettingBottomSheet(
      AccountViewModel viewModel) {
    return showModalBottomSheet(
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
              Text("Bildirim Ayarları"),
              SizedBox(
                width: 8,
              ),
              Icon(Icons.edit_notifications_rounded)
            ],
          ),
          children: [
            Observer(
              builder: (_) => ListTile(
                title: const Text("Tüm bildirimler"),
                trailing: Switch(
                  thumbIcon: thumbIcon,
                  value: viewModel.allNotifications,
                  onChanged: (bool value) {
                    viewModel.allNotifications = value;
                  },
                ),
              ),
            ),
            Observer(
              builder: (_) => ListTile(
                title: const Text("Sipariş bildirimler,"),
                trailing: Switch(
                  thumbIcon: thumbIcon,
                  value: viewModel.allNotifications,
                  onChanged: (bool value) {
                    viewModel.allNotifications = value;
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildVerifyEmail(AccountViewModel value) {
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
              value.sendVerifyEmail();
            },
          ),
        ));
  }
}
