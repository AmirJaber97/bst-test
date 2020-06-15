import 'package:bsttest/app/locator.dart';
import 'package:bsttest/constants/app_styles.dart';
import 'package:bsttest/enums/notifier_state.dart';
import 'package:bsttest/services/api.dart';
import 'package:bsttest/ui/app_base_widget.dart';
import 'package:bsttest/ui/views/login/login_viewmodel.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();

    final userNameField = TextField(
      controller: userNameController,
      obscureText: false,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username, default: 20234561",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password, default: ladevi31",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    return BaseWidget<LoginViewModel>(
      viewModel: LoginViewModel(api: locator<Api>()),
      builder: (_, model, __) {
        return model.state != NotifierState.Loading ? Scaffold(
          body: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 45.0),
                    userNameField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(
                      height: 35.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: Color(0xff01A0C7),
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () {
                          model.authorize(userNameController.text, passwordController.text);
                        },
                        child: Text("Login",
                            textAlign: TextAlign.center,
                            style: style.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ) : Center(child: CircularProgressIndicator(),);
      },
    );
  }
}
