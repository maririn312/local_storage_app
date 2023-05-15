// ignore_for_file: avoid_print, prefer_final_fields, unused_field, unused_import, deprecated_member_use, prefer_const_literals_to_create_immutables, duplicate_ignore, depend_on_referenced_packages

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/tenger_input.dart';
import 'package:abico_warehouse/components/tenger_outline_button.dart';
import 'package:abico_warehouse/data/blocs/auth/auth_bloc.dart';
import 'package:abico_warehouse/data/blocs/hr/hr_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/utils/tenger_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/screen args/auth_args.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthBloc _authBloc = AuthBloc();
  final AuthBloc _loginBloc = AuthBloc();
  final HrListBloc _hrListBloc = HrListBloc();

  bool _isLoading = false;
  final TextEditingController _ipController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _ipError;
  String _nameError;
  String _passwordError;
  bool _rememberMe = false;

  String _sessionId;
  String _ip;
  String _login;
  String _password;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    _authBloc?.close();
    _loginBloc?.close();
    _ipController?.dispose();
    _nameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Future<void> _loadSavedCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedIp = prefs.getString('ip');
    String savedName = prefs.getString('name');
    String savedPassword = prefs.getString('password');
    bool savedRememberMe = prefs.getBool('rememberMe') ?? false;
    setState(() {
      // _usernameController.text = savedUsername ?? '';
      _ipController.text = savedIp ?? '';
      _nameController.text = savedName ?? '';
      _passwordController.text = savedPassword ?? '';
      _rememberMe = savedRememberMe;
    });
  }

  Future<void> _saveCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('ip', _ipController.text);
      await prefs.setString('name', _nameController.text);
      await prefs.setString('password', _passwordController.text);
    } else {
      await prefs.remove('ip');
      await prefs.remove('name');
      await prefs.remove('password');
    }
    await prefs.setBool('rememberMe', _rememberMe);
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocListener(
                bloc: _authBloc,
                listener: (_, state) async {
                  if (state is AuthUserLoaded) {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppTypes.SCREEN_HOME, (route) => false,
                        arguments: AuthArgs(_ipController.text));
                  } else if (state is AuthUserLoading) {
                    setState(() {
                      _isLoading = true;
                    });
                  } else if (state is AuthUserError) {
                    setState(() {
                      _isLoading = false;
                      _ipError = Language.ERROR_IP;
                    });
                  } else if (state is AuthUserLogOut) {
                    // Call _loadSavedCredentials() when logged out
                    _loadSavedCredentials();
                    // Reset the "remember me" flag when logged out
                    setState(() {
                      _rememberMe = false;
                    });
                  }
                  // _saveCredentials();
                },
                child: const SizedBox(
                  height: 8,
                ),
              ),
              _buildLogo(),
              _buildLogin()
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).colorScheme.surface,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const Text(Language.FOOTER_COPYRIGHT)],
          ),
        ),
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Widget _buildLogo() {
    return Container(
        margin: const EdgeInsets.only(top: 50),
        color: Theme.of(context).colorScheme.surface,
        child: Image.asset(
          'assets/images/logo/tenger_logo.png',
          width: 350.0,
        ));
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Widget _buildLogin() {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TengerInput(
            labelText: Language.LABEL_CODE_NO,
            controller: _ipController,
            errorText: _ipError,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TengerInput(
            labelText: Language.LABEL_USER_NO,
            controller: _nameController,
            type: TextInputType.emailAddress,
            errorText: _nameError,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: TengerInput(
            labelText: Language.LABEL_PASSWORD,
            controller: _passwordController,
            obscureText: true,
            type: TextInputType.visiblePassword,
            errorText: _passwordError,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Checkbox(
                  activeColor: Theme.of(context).colorScheme.primary,
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value;
                    });
                  }),
              const Text(
                'Нэвтрэх хаяг сануулах',
                style: TextStyle(
                    color: Color(0xff606774),
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
            height: 90,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: TengerOutlineButton(
                color: Theme.of(context).colorScheme.primary,
                child: const Center(
                  child: Text(Language.BTN_LOGIN,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ),
                onPressed: () async => {
                      // if (_validateForm())
                      //   {
                      _authBloc.add(AuthUser(
                          ip: _ipController.text,
                          login: _nameController.text,
                          password: _passwordController.text)),
                      // await DBProvider.db.newUserDetail(UserDetailEntity(
                      //     ip: _ipController.text,
                      //     username: _nameController.text,
                      //     password: _passwordController.text))
                      // },
                      _saveCredentials()
                    })),
      ]),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */

  // bool _validateForm() {
  //   if (TengerUtility.nameRegExp != null) {
  //     setState(() {
  //       _ipError = null;
  //     });
  //   } else {
  //     setState(() {
  //       _ipError = Language.ERROR_IP;
  //     });
  //   }
  //   return false;
  // }
}
