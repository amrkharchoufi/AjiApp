import 'package:ajiapp/views/ClientSpace.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> login(BuildContext context, String email, String password) async {
  late AwesomeDialog loadingDialog;
  try {
    // Show loading dialog
    loadingDialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: Container(
        width: context.size!.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/logoaji.svg"),
            CircularProgressIndicator(),
            Text('Signing in...'),
            SizedBox(height: 16),
          ],
        ),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
    )..show();

    // Authenticate user
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // // Get user data
    // final String userId = userCredential.user!.uid;
    // final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
    //     await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    // // Handle user data
    // if (!userSnapshot.exists) {
    //   loadingDialog.dismiss();
    //   _showErrorDialog(context, 'User account not found');
    //   await FirebaseAuth.instance.signOut();
    //   return;
    // }

    // Navigate based on role
    loadingDialog.dismiss();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Clientspace()),
      (Route<dynamic> route) => false,
    );
  } on FirebaseAuthException catch (e) {
    loadingDialog.dismiss();
    _handleAuthError(context, e);
  } on FirebaseException catch (e) {
    loadingDialog.dismiss();
    _showErrorDialog(context, 'Database error: ${e.message}');
  } catch (e) {
    loadingDialog.dismiss();
    _showErrorDialog(context, 'Unexpected error: ${e.toString()}');
  }
}

void _handleAuthError(BuildContext context, FirebaseAuthException e) {
  String message = 'Sign in failed';
  switch (e.code) {
    case 'invalid-email':
      message = 'Invalid email format';
      break;
    case 'user-disabled':
      message = 'This account has been disabled';
      break;
    case 'user-not-found':
    case 'wrong-password':
      message = 'Invalid email or password';
      break;
    case 'network-request-failed':
      message = 'Network error. Please check your connection';
      break;
  }
  _showErrorDialog(context, message);
}

void _showErrorDialog(BuildContext context, String message) {
  if (!context.mounted) return;

  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.rightSlide,
    title: 'Sign In Problem',
    desc: message,
    btnOkOnPress: () {},
    btnOkColor: Colors.red,
  ).show();
}
