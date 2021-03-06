import 'package:flutter/material.dart';

import 'package:email_validator/email_validator.dart';

class AuthForm extends StatefulWidget {
  final bool _isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    String userLastname,
    bool isLoginMode,
    BuildContext ctx,
  ) _submitAuthForm;

  AuthForm(
    this._submitAuthForm,
    this._isLoading,
  );

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userName = '';
  var _userLastname = '';
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!
        .validate(); // чтобы тригернуть все валидаторы, во всех TextFormField
    FocusScope.of(context).unfocus(); // вызвет закрытие клавиатуры
    if (isValid) {
      _formKey.currentState!.save(); //
      widget._submitAuthForm(
        _userEmail
            .trim(), // trim() удаляет все лишние пробелы введенные юзером внчале и в конце
        _userPassword.trim(),
        _userName.trim(),
        _userLastname.trim(),
        _isLogin,
        context,
      );
      // print(_userEmail);
      // print(_userPassword);
      // print(_userName);
      // print(_userLastname);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey, // обязательно создать ключ для формы
              child: Column(
                mainAxisSize: MainAxisSize
                    .min, // чтобы столбец не занимал всё доступное пространство,
                // а только то пространство, которое необходимо его дочерним элементам
                children: [
                  TextFormField(
                    key: ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: 'Email address'),
                    validator: (value) {
                      bool isEmailValid = EmailValidator.validate(value!);
                      print(value);

                      if (!isEmailValid) {
                        print(isEmailValid);
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userEmail = value!;
                    },
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText:
                        _passwordVisible, //obscureText - скрыт или нет ввод пароля
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(_passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          }),
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPassword = value!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      decoration: InputDecoration(labelText: 'Username'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Username must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value!;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('lastname'),
                      decoration: InputDecoration(labelText: 'Lastname'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 3) {
                          return 'Lastname must be at least 3 characters long.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userLastname = value!;
                      },
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading)
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).primaryColor),
                    ),
                  if (!widget._isLoading)
                    ElevatedButton(
                        child: Text(_isLogin ? 'Login' : 'Sing up'),
                        onPressed: _trySubmit),
                  if (!widget._isLoading)
                    TextButton(
                        child: Text(_isLogin
                            ? 'Create new account'
                            : 'I already have an account'),
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
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
