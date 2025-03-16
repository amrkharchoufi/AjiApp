import 'package:ajiapp/views/ClientSpace.dart';
import 'package:ajiapp/views/VerifyEmail_view.dart';
import 'package:ajiapp/views/login_view.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> login(BuildContext context, String email, String password,
    bool rememberme) async {
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

    // Save credentials if 'Remember Me' is checked
    if (rememberme) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    }

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

Future<void> signout(BuildContext context) async {
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
            Text('Signing Out...'),
            SizedBox(height: 16),
          ],
        ),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
    )..show();

    FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    loadingDialog.dismiss();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginView()),
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

void loadSavedCredentials(
    TextEditingController email, TextEditingController pwd) async {
  final prefs = await SharedPreferences.getInstance();
  final savedEmail = prefs.getString('email') ?? '';
  final savedPassword = prefs.getString('password') ?? '';

  if (savedEmail.isNotEmpty && savedPassword.isNotEmpty) {
    email.text = savedEmail;
    pwd.text = savedPassword;
  }
}

Future<void> loginWithGoogle(BuildContext context) async {
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
            fit: BoxFit.cover,
          ),
        ),
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

    // Google Sign-In
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // User canceled the sign-in
      loadingDialog.dismiss();
      _showErrorDialog(context, 'Google sign-in canceled.');
      return;
    }

    // Obtain the GoogleSignIn authentication details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create credential for Firebase
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Authenticate user with Firebase
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // // Check if user exists in Firestore
    // final String userId = userCredential.user!.uid;
    // final userSnapshot =
    //     await FirebaseFirestore.instance.collection('Users').doc(userId).get();

    // if (!userSnapshot.exists) {
    //   loadingDialog.dismiss();
    //   _showErrorDialog(context, 'User account not found.');
    //   await FirebaseAuth.instance.signOut();
    //   return;
    // }

    // Navigate to client space
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

Future<void> resetPassword(String email, BuildContext context) async {
  late AwesomeDialog loadingDialog;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(email)) {
    _showErrorDialog(context, 'Please enter a valid email address.');
    return;
  }

  try {
    loadingDialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.bottomSlide,
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset("assets/images/logoaji.svg"),
            CircularProgressIndicator(),
            Text('Sending email...'),
            SizedBox(height: 16),
          ],
        ),
      ),
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
    )..show();

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    loadingDialog.dismiss();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Email Sent',
      desc:
          'A password reset link has been sent to your email. Please check your inbox.',
      btnOkOnPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => VerifyemailView(email: email)),
        );
      },
    ).show();
  } on FirebaseAuthException catch (e) {
    loadingDialog.dismiss();

    switch (e.code) {
      case 'user-not-found':
        _showErrorDialog(context, 'No account found with this email.');
        break;
      case 'invalid-email':
        _showErrorDialog(context, 'Invalid email format.');
        break;
      default:
        _showErrorDialog(context, 'Error: ${e.message}');
    }
  } on FirebaseException catch (e) {
    loadingDialog.dismiss();
    _showErrorDialog(context, 'Database error: ${e.message}');
  } catch (e) {
    loadingDialog.dismiss();
    _showErrorDialog(context, 'Unexpected error: ${e.toString()}');
  }
}
