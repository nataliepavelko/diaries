import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:selftherapy_diaries/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String password,
    String userName,
    String userLastname,
    bool isLoginMode,
    BuildContext ctx,
  ) async {
    UserCredential _authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (isLoginMode) {
        _authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        _authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection(
                'users') //Такой коллекции пока нет, но она будет создаваться «на лету».
            //Так что не нужно создавать его заранее.
            .doc(_authResult.user!.uid)
            .set({
          'username': userName,
          'userLastname': userLastname,
          'email': email,
        });
      }
    } on FirebaseAuthException catch (error) {
      // on для добавления типа ошибки, т.е. catch отлавлтвает только ошибки типа PlatformException,
      // а именно - ошибки FirebaseAuth(неправильный email, password etc)
      var messege = 'Error occurred, please check your credentials';
      if (error.message != null) {
        messege = error.message!;
      }
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text(messege),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
