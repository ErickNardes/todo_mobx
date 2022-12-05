import 'package:mobx/mobx.dart';
part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

abstract class _LoginStore with Store {
  @observable
  String email = '';

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = '';

  @observable
  bool passVisvible = false;

  @observable
  bool loading = false;

  @observable
  bool loggedIn = false;

  @action
  void togglePassVivisility() => passVisvible = !passVisvible;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get isEmailValid => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);

  @computed
  bool get isPassValid => password.length >= 6;

  @computed
  Function? get loginPressed =>
      (isEmailValid && isPassValid && !loading) ? login : null;

  @action
  Future<void> login() async {
    loading = true;
    await Future.delayed(Duration(seconds: 3));
    loading = false;

    loggedIn = true;

    email = '';
    password = '';
  }

  @action
  void logout() {
    loggedIn = false;
  }
}
