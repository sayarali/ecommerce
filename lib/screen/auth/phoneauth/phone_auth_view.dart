import 'package:ecommerce/core/base/state/base_state.dart';
import 'package:ecommerce/core/base/view/base_view.dart';
import 'package:ecommerce/core/components/text_field/custom_bordered_text_field.dart';
import 'package:ecommerce/screen/auth/phoneauth/viewmodel/phone_auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../core/components/gradiant_box.dart';

class PhoneAuthView extends StatefulWidget {
  const PhoneAuthView({Key key}) : super(key: key);

  @override
  State<PhoneAuthView> createState() => _PhoneAuthViewState();
}

class _PhoneAuthViewState extends BaseState<PhoneAuthView> {
  PhoneAuthViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return BaseView(
        onPageBuilder: (context, value) => buildScaffold,
        viewModel: PhoneAuthViewModel(),
        onModelReady: (model) {
          model.setContext(context);
          viewModel = model;
          model.init();
        });
  }

  Scaffold get buildScaffold => Scaffold(
        appBar: AppBar(
          title: Text(
            "Telefon ile Giriş",
            style: themeData.textTheme.titleLarge.copyWith(
                color: themeData.cardColor, fontWeight: FontWeight.w300),
          ),
          flexibleSpace: GradiantBox(
            a: themeData.primaryColor,
            b: themeData.colorScheme.secondary,
          ),
        ),
        body: GestureDetector(
          onTap: (() => FocusScope.of(context).unfocus()),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: <Widget>[
                Image(
                  image: const AssetImage('assets/phone.png'),
                  width: MediaQuery.of(context).size.width * 0.45,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                        "Telefon numaranız ile giriş yapmak için doğrulama mesajı gönderilecektir.\n")),
                Container(
                    alignment: Alignment.centerLeft,
                    child: const Text("Lütfen numaranızı giriniz:")),
                TextField(
                  controller: viewModel.phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                  ],
                  decoration: InputDecoration(
                    prefixText: "+90",
                    prefixIcon: Icon(Icons.phone)
                  ),
                ),
                const SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                    viewModel.signInWithPhoneNumber();
                  },
                  style: ButtonStyle(
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      )),
                      backgroundColor: MaterialStateProperty.all(
                          themeData.colorScheme.secondary),
                      shadowColor: MaterialStateProperty.all(
                          themeData.colorScheme.secondary)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      Text("Gönder"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
