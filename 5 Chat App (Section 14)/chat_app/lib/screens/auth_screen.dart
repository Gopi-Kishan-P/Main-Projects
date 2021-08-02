import 'dart:io';

import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    void _submitAuthForm(
      String email,
      String password,
      String name,
      File image,
      bool isLogin,
      BuildContext ctx,
    ) async {
      AuthResult _authResult;
      try {
        setState(() {
          _isLoading = true;
        });
        if (isLogin) {
          _authResult = await _auth.signInWithEmailAndPassword(
              email: email, password: password);
          print('Success login');
        } else {
          _authResult = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);
          print('Success signup');

          final ref = FirebaseStorage.instance
              .ref()
              .child('user_images')
              .child(_authResult.user.uid + '.jpg');
          await ref.putFile(image).onComplete;
          
          print('***************** IMAGE UPLOAD');
          final userImgUrl = await ref.getDownloadURL();
          print(userImgUrl.toString());

          await Firestore.instance
              .collection('users')
              .document(_authResult.user.uid)
              .setData({
            'username': name,
            'email': email,
            'img-url': userImgUrl,
          });
        }
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      } on PlatformException catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        var message = 'An error occoured, please check your credentials';
        if (e.message != null) message = e.message;

        Scaffold.of(ctx).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, _isLoading),
    );
  }
}
