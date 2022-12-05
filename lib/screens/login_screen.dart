import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:todo_mobx/screens/list_screen.dart';
import 'package:todo_mobx/stores/login_store.dart';

import '../widgets/custom_icon.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginStore loginStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loginStore = Provider.of<LoginStore>(context);
    autorun((_) {
      if (loginStore.loggedIn) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => ListScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(32),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 16,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Observer(builder: (_) {
                    return CustomTextField(
                      hint: 'E-mail',
                      prefix: const Icon(Icons.account_circle),
                      textInputType: TextInputType.emailAddress,
                      onChanged: loginStore.setEmail,
                      enable: !loginStore.loading,
                      obscure: false,
                    );
                  }),
                  const SizedBox(
                    height: 40,
                  ),
                  Observer(builder: (_) {
                    return CustomTextField(
                      hint: 'Senha',
                      prefix: Icon(Icons.lock),
                      textInputType: TextInputType.number,
                      onChanged: loginStore.setPassword,
                      enable: !loginStore.loading,
                      obscure: !loginStore.passVisvible,
                      suffix: CustomIconButton(
                        color: Colors.deepPurpleAccent,
                        radius: 32,
                        iconData: Icons.visibility,
                        onTap: () {},
                      ),
                    );
                  }),
                  Observer(builder: (_) {
                    return ElevatedButton(
                      child: loginStore.loading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text('Login'),
                      onPressed: loginStore.loginPressed as void Function()?,
                    );
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
