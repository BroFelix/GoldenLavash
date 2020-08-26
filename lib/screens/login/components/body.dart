import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/screens/home/home.dart';
import 'package:golden_app/services/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBodyScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginBodyScreenState();
}

class _LoginBodyScreenState extends State<LoginBodyScreen> {
  var _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();
  String username;
  String password;

//  int _buttonState = 0; // 0 - initial, 1 - loading
  var checkingLogin = true;

  @override
  void initState() {
    String token;
    SharedPreferences.getInstance().then((prefs) {
      token = prefs.getString("token") ?? null;
      if (token == null || token == "") {
        setState(() {
          checkingLogin = false;
        });
      } else {
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
        _authService.getUser(context).then((response) {
          if (response == null) {
            setState(() {
              checkingLogin = false;
            });
          } else {
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
          }
        }).catchError((error) {
          checkingLogin = false;
        });
      }
    });
    super.initState();
  }

  Widget _getForm() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(256),
            width: ScreenUtil().setWidth(256),
            child: Image.asset('images/logo.png'),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setSp(64),
              vertical: ScreenUtil().setSp(32),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (value) {
                      if (mounted) {
                        username = value;
                      }
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter the login';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Login',
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(24)),
                  TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      if (mounted) {
                        password = value;
                      }
                    },
                    validator: (String value) {
                      if (value.length < 4) {
                        return 'Error';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            color: Colors.lightBlue,
            child: Text(
              'Вход',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                _authService
                    .login(context, username, password)
                    .then((response) {
                  if (response != null) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Sign in done!!!')));
                    Navigator.of(context)
                        .pushReplacementNamed(HomeScreen.route);
                  } else {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Wrong data!!!')));
                  }
                });
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: checkingLogin ? CircularProgressIndicator() : _getForm(),
    );
  }
}
