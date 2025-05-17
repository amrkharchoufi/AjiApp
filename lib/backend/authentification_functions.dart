// ignore_for_file: use_build_context_synchronously

import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/common/ClientSpace.dart';
import 'package:ajiapp/settings/colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<void> login(BuildContext context, String email, String password,
    bool rememberme) async {
  try {
    // Show loading dialog
    showLoadingDialog(context, 'Signing in...');

    // Authenticate user
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    //Get user data
    final String userId = userCredential.user!.uid;
    final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('user').doc(userId).get();

    // // Handle user data
    if (!userSnapshot.exists || userSnapshot.get("isAdmin") == true) {
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'User account not found');
      await FirebaseAuth.instance.signOut();
      return;
    }

    // Save credentials if 'Remember Me' is checked
    if (rememberme) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    }

    if (!context.mounted) return;

    // Navigate based on role
    // Dismiss loading dialog
    Navigator.of(context, rootNavigator: true).pop();
    Get.back();
    Get.toNamed(Routes.PROFILE);
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _handleAuthError(context, e);
    }
  } on FirebaseException catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
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
  try {
    // Show loading dialog
    showLoadingDialog(context, 'Signing out...');

    FirebaseAuth.instance.signOut();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    if (!context.mounted) return;

    // Dismiss loading dialog
    Navigator.of(context, rootNavigator: true).pop();
    Get.back();
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _handleAuthError(context, e);
    }
  } on FirebaseException catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
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
  try {
    // Show loading dialog
    showLoadingDialog(context, 'Signing in...');

    // Google Sign-In
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      // User canceled the sign-in
      if (!context.mounted) return;
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
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
    // final userCredential =
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
    if (!context.mounted) return;
    // Navigate to client space
    // Dismiss loading dialog
    Navigator.of(context, rootNavigator: true).pop();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Clientspace()),
      (Route<dynamic> route) => false,
    );
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _handleAuthError(context, e);
    }
  } on FirebaseException catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      _showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
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

    if (!context.mounted) return;
    loadingDialog.dismiss();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Email Sent',
      desc:
          'A password reset link has been sent to your email. Please check your inbox.',
      btnOkOnPress: () {
        Navigator.pop(context);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => VerifyemailView(email: email)),
        // );
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
    if (context.mounted) {
      loadingDialog.dismiss();
      _showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      loadingDialog.dismiss();
      _showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
  }
}

void showLoadingDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/logoaji.svg",
              width: 80,
            ),
            const SizedBox(height: 20),
            const CircularProgressIndicator(),
            const SizedBox(height: 10),
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Future<bool> checkIfUserIsLoggedIn() async {
  User? user = FirebaseAuth.instance.currentUser;
  return user != null;
}

Future<void> signup(
  BuildContext context,
  String email,
  String password,
  String username,
  String phone,
) async {
  try {
    // Show loading dialog
    showLoadingDialog(context, 'Signing up...');
    final auth = FirebaseAuth.instance;

    // Create user with email and password
    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      // Update display name
      await user.updateDisplayName(username);

      // Save extra user data in Firestore
      await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
        'username': username,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
        'isAdmin': false
      });
      Navigator.of(context, rootNavigator: true).pop();
      Get.back();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Account created successfully!'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(Routes.PROFILE);
              },
              child: Text('OK', style: TextStyle(color: ajired)),
            ),
          ],
        ),
      );
    }
  } on FirebaseAuthException catch (e) {
    String errorMessage = 'An error occurred. Please try again.';
    if (e.code == 'email-already-in-use') {
      errorMessage = 'This email is already in use.';
    } else if (e.code == 'weak-password') {
      errorMessage = 'The password is too weak.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'Invalid email format.';
    }
    Navigator.of(context, rootNavigator: true).pop();
    _showErrorDialog(context, errorMessage);
  } catch (e) {
    debugPrint('Signup error: $e');
    _showErrorDialog(context, e.toString());
  }
}
