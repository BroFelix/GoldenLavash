import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:golden_app/common/function/get_user.dart';
import 'package:golden_app/resources/values/colors.dart';
import 'package:golden_app/screens/home/home.dart';
import 'file:///C:/Users/Farrukh/Android/golden_app/lib/services/auth.dart';
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
  int _buttonState = 0; // 0 - initial, 1 - loading
  var checkingLogin = true;

  Widget setUpButtonChild() {
    if (_buttonState == 0) {
      return new Text(
        "Войти",
        style: TextStyle(
          color: Colors.white,
          fontSize: ScreenUtil().setSp(24),
        ),
      );
    } else if (_buttonState == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
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
          SizedBox(height: ScreenUtil().setHeight(24)),
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
                        return 'Введите логин';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'Логин',
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
                      if (value.isEmpty) {
                        return 'Введите пароль ';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Пароль',
                    ),
                  ),
                ],
              ),
            ),
          ),
          MaterialButton(
            height: ScreenUtil().setHeight(64),
            color: AppColors.buttonColor,
            textColor: Colors.white,
            minWidth: ScreenUtil().setWidth(200),
            padding: EdgeInsets.all(16),
            child: setUpButtonChild(),
            onPressed: () {
              if (_formKey.currentState.validate() && _buttonState == 0) {
                print('$username, $password');
                setState(() {
                  _buttonState = 1;
                });
                _formKey.currentState.save();
                _authService
                    .login(context, username, password)
                    .then((response) {
                  setState(() {
                    _buttonState = 0;
                  });
                  if (response != null) {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Вход выполнен!')));
                    _authService.getUser(context).then((response) {
                      Navigator.of(context)
                          .pushReplacementNamed(HomeScreen.route);
                    }).catchError((error) {
                      setState(() {
                        checkingLogin = false;
                      });
                    });
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('Неправильные данные входа!'),
                    ));
                  }
                }).catchError((error) {
                  setState(() {
                    _buttonState = 0;
                  });
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text("Ошибка во время входа! повторите снова"),
                  ));
                });
              }
            },
          ),
        ],
      ),
    );
  }

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
        getUser().then((user) {
          if (user == null) {
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getForm(),
    );
  }
}
