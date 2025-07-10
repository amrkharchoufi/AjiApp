// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:ajiapp/routing.dart';
import 'package:ajiapp/services/notification/notifications_system.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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
      showErrorDialog(context, 'User account not found');
      await FirebaseAuth.instance.signOut();
      return;
    }
    if (userSnapshot.get("isEmailVerified") == false) {
      await userCredential.user!.reload(); // force refresh
      final user = FirebaseAuth.instance.currentUser!;

      if (user.emailVerified) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .update({'isEmailVerified': true});
      } else {
        Navigator.of(context, rootNavigator: true).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Sign In Problem',
          desc: 'Please verify your email.',
          btnOkText: "Resend Email",
          btnOkOnPress: () async {
            try {
              await user.sendEmailVerification();
              showSuccessDialog(
                context,
                'A new verification link has been sent to your email.',
                'Email Sent',
              );
            } catch (e) {
              showErrorDialog(context, 'Could not send email: $e');
            } finally {
              // 👇 Move signOut here
              await FirebaseAuth.instance.signOut();
            }
          },
          btnCancelText: "Cancel",
          btnCancelOnPress: () async {
            await FirebaseAuth.instance.signOut(); // also handle cancel
          },
        ).show();
        return;
      }
    }

    String FCMTOKEN = await NotificationService.instance.getFCMtoken();

    await FirebaseFirestore.instance
        .collection("user")
        .doc(userCredential.user!.uid)
        .update({"FCMtoken": FCMTOKEN});
    // Save credentials if 'Remember Me' is checked
    if (rememberme) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    }

    if (!context.mounted) return;

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
      showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Unexpected error: ${e.toString()}');
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
  showErrorDialog(context, message);
}

void showErrorDialog(BuildContext context, String message) {
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

void showSuccessDialog(BuildContext context, String message, String title) {
  if (!context.mounted) return;

  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.rightSlide,
    title: title,
    desc: message,
    btnOkOnPress: () {
      Navigator.of(context, rootNavigator: true).pop();
    },
    btnOkColor: Colors.green,
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
      showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      // Dismiss loading dialog
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Unexpected error: ${e.toString()}');
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
      if (!context.mounted) return;
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Google sign-in canceled.');
      return;
    }

    String FCMTOKEN = await NotificationService.instance.getFCMtoken();
    // Obtain authentication details
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create Firebase credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final user = userCredential.user;

    if (user == null) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Authentication failed.');
      return;
    }

    final userDocRef =
        FirebaseFirestore.instance.collection('user').doc(user.uid);
    final docSnapshot = await userDocRef.get();

    if (!docSnapshot.exists) {
      // First time login with Google, set user data
      await userDocRef.set({
        'username': googleUser.displayName ?? '',
        'email': googleUser.email,
        'phone': user.phoneNumber ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'isAdmin': false,
        "FCMtoken": FCMTOKEN
      });
    } else {
      // User already exists: don't overwrite existing values
      // But optionally update missing fields only (safe merge)
      Map<String, dynamic> existingData = docSnapshot.data() ?? {};
      Map<String, dynamic> updateData = {};
      updateData['FCMtoken'] = FCMTOKEN;
      if ((existingData['username'] ?? '').isEmpty &&
          googleUser.displayName != null) {
        updateData['username'] = googleUser.displayName;
      }

      if ((existingData['email'] ?? '').isEmpty) {
        updateData['email'] = googleUser.email;
      }

      if ((existingData['phone'] ?? '').isEmpty && user.phoneNumber != null) {
        updateData['phone'] = user.phoneNumber;
      }

      if (updateData.isNotEmpty) {
        await userDocRef.update(updateData);
      }
    }

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    Get.offNamed(Routes.PROFILE);
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      _handleAuthError(context, e);
    }
  } on FirebaseException catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
  }
}

Future<void> resetPassword(String email, BuildContext context) async {
  late AwesomeDialog loadingDialog;

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(email)) {
    showErrorDialog(context, 'Please enter a valid email address.');
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
        showErrorDialog(context, 'No account found with this email.');
        break;
      case 'invalid-email':
        showErrorDialog(context, 'Invalid email format.');
        break;
      default:
        showErrorDialog(context, 'Error: ${e.message}');
    }
  } on FirebaseException catch (e) {
    if (context.mounted) {
      loadingDialog.dismiss();
      showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      loadingDialog.dismiss();
      showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
  }
}

Future<void> changeEmail(
  String newEmail,
  String currentPassword,
  BuildContext context,
) async {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(newEmail)) {
    showErrorDialog(context, 'Please enter a valid email address.');
    return;
  }

  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    showErrorDialog(context, 'No user is currently logged in.');
    return;
  }

  try {
    showLoadingDialog(context, "Updating email...");

    // Step 1: Re-authenticate the user with their current password
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );

    await user.reauthenticateWithCredential(credential);

    // Step 2: Update the email
    await user.verifyBeforeUpdateEmail(newEmail);

    await FirebaseFirestore.instance
        .collection('user')
        .doc(user.uid)
        .update({'email': user.email});

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.bottomSlide,
      title: 'Email Updated',
      desc: 'A confirmation link has been sent to your new email address.',
      btnOkOnPress: () {
        Navigator.pop(context);
      },
    ).show();
  } on FirebaseAuthException catch (e) {
    Navigator.of(context, rootNavigator: true).pop();
    switch (e.code) {
      case 'email-already-in-use':
        showErrorDialog(
            context, 'This email is already associated with another account.');
        break;
      case 'invalid-email':
        showErrorDialog(context, 'Invalid email format.');
        break;
      case 'wrong-password':
        showErrorDialog(context, 'The current password is incorrect.');
        break;
      case 'requires-recent-login':
        showErrorDialog(
            context, 'You need to re-login to perform this action.');
        break;
      default:
        showErrorDialog(context, 'Error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
  }
}

Future<void> updateUserPassword(
  String currentPassword,
  String newPassword,
  BuildContext context,
) async {
  // Show loading dialog
  showLoadingDialog(context, 'Loading...');
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) {
    Navigator.of(context, rootNavigator: true).pop();
    showErrorDialog(context, "No user is currently signed in.");
    return;
  }

  try {
    // Step 1: Re-authenticate
    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: currentPassword,
    );
    await user.reauthenticateWithCredential(credential);

    // Step 2: Check if the new password is different
    if (currentPassword == newPassword) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context,
          'The new password must be different from the current password.');
      return;
    }

    // Step 3: Update password
    await user.updatePassword(newPassword);
    Navigator.of(context, rootNavigator: true).pop();
    // Step 4: Show success
    showSuccessDialog(
      context,
      "Your password has been updated successfully.",
      "Password Updated",
    );
    Get.back(); // Or Navigator.pop(context) if you're not using GetX
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'wrong-password':
        Navigator.of(context, rootNavigator: true).pop();
        showErrorDialog(context, 'The current password is incorrect.');
        break;
      case 'weak-password':
        Navigator.of(context, rootNavigator: true).pop();
        showErrorDialog(
            context, 'The new password is too weak. Try a stronger one.');
        break;
      case 'requires-recent-login':
        Navigator.of(context, rootNavigator: true).pop();
        showErrorDialog(
            context, 'Please log in again and try updating your password.');
        break;
      default:
        Navigator.of(context, rootNavigator: true).pop();
        showErrorDialog(context, 'Firebase error: ${e.message}');
    }
  } catch (e) {
    Navigator.of(context, rootNavigator: true).pop();
    showErrorDialog(context, 'Unexpected error: ${e.toString()}');
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
  final user = FirebaseAuth.instance.currentUser;

  if (user == null) return false;

  try {
    await user.reload(); // ⬅️ Refresh session with server
    final refreshedUser = FirebaseAuth.instance.currentUser;

    // Check if user still exists (after reload)
    return refreshedUser != null;
  } on FirebaseAuthException catch (e) {
    // If user was deleted, Firebase may throw an error
    if (e.code == 'user-not-found') {
      await FirebaseAuth.instance.signOut(); // cleanup
      return false;
    }
    rethrow;
  } catch (_) {
    return false;
  }
}

Future<void> signup(BuildContext context, String email, String password,
    String username, String phone, String country) async {
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

      // Send email verification
      await user.sendEmailVerification();
      String FCMTOKEN = await NotificationService.instance.getFCMtoken();

      // Save user data in Firestore
      await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
        'username': username,
        'email': email,
        'phone': phone,
        'createdAt': FieldValue.serverTimestamp(),
        'isAdmin': false,
        'isEmailVerified': false,
        'country': country,
        "FCMtoken": FCMTOKEN
      });

      // Sign out to prevent unverified access
      await FirebaseAuth.instance.signOut();

      Navigator.of(context, rootNavigator: true).pop(); // Close loading
      // Show info dialog
      showSuccessDialog(
        context,
        'A verification link has been sent to your email. Please verify before logging in.',
        'Verify Your Email',
      );
    }
  } on FirebaseAuthException catch (e) {
    Navigator.of(context, rootNavigator: true).pop();
    String errorMessage = 'An error occurred. Please try again.';
    if (e.code == 'email-already-in-use') {
      errorMessage = 'This email is already in use.';
    } else if (e.code == 'weak-password') {
      errorMessage = 'The password is too weak.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'Invalid email format.';
    }
    showErrorDialog(context, errorMessage);
  } catch (e) {
    Navigator.of(context, rootNavigator: true).pop();
    debugPrint('Signup error: $e');
    showErrorDialog(context, e.toString());
  }
}

Future<void> loginWithApple(BuildContext context) async {
  if (!Platform.isIOS) {
    showErrorDialog(context, 'Apple Sign-in is only supported on iOS.');
    return;
  }

  try {
    // Show loading dialog
    showLoadingDialog(context, 'Signing in with Apple...');

    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    String FCMTOKEN = await NotificationService.instance.getFCMtoken();

    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    // Sign in with Firebase
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    final user = userCredential.user;

    if (user == null) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Authentication failed.');
      return;
    }

    final userDocRef =
        FirebaseFirestore.instance.collection('user').doc(user.uid);
    final docSnapshot = await userDocRef.get();

    final displayName = (appleCredential.givenName != null &&
            appleCredential.familyName != null)
        ? '${appleCredential.givenName} ${appleCredential.familyName}'
        : '';

    final email = user.email ?? appleCredential.email;

    if (!docSnapshot.exists) {
      // First-time Apple sign-in
      await userDocRef.set({
        'username': displayName,
        'email': email,
        'phone': user.phoneNumber ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'isAdmin': false,
        "FCMtoken": FCMTOKEN
      });
    } else {
      // Update only missing fields
      Map<String, dynamic> existingData = docSnapshot.data() ?? {};
      Map<String, dynamic> updateData = {};
      updateData['FCMtoken'] = FCMTOKEN;

      if ((existingData['username'] ?? '').isEmpty && displayName.isNotEmpty) {
        updateData['username'] = displayName;
      }

      if ((existingData['email'] ?? '').isEmpty && email != null) {
        updateData['email'] = email;
      }

      if ((existingData['phone'] ?? '').isEmpty && user.phoneNumber != null) {
        updateData['phone'] = user.phoneNumber;
      }

      if (updateData.isNotEmpty) {
        await userDocRef.update(updateData);
      }
    }

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    Get.offNamed(Routes.PROFILE);
  } on SignInWithAppleAuthorizationException catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      if (e.code == AuthorizationErrorCode.canceled) {
        showErrorDialog(context, 'Apple sign-in was canceled.');
      } else {
        showErrorDialog(context, 'Apple sign-in error: ${e.message}');
      }
    }
  } on FirebaseAuthException catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      _handleAuthError(context, e);
    }
  } on FirebaseException catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Database error: ${e.message}');
    }
  } catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Unexpected error: ${e.toString()}');
    }
  }
}

Future<void> deleteUserAccount(BuildContext context) async {
  try {
    showLoadingDialog(context, 'Deleting your account...');

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'No user is currently signed in.');
      return;
    }

    // Delete Firestore user doc
    final docRef = FirebaseFirestore.instance.collection('user').doc(user.uid);
    await docRef.delete();

    try {
      await user.delete(); // attempt deletion
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        Navigator.of(context, rootNavigator: true).pop(); // close loader
        bool reauthSuccess = await _reauthenticateUser(context, user);
        if (!reauthSuccess) return;

        // Try again after reauthentication
        showLoadingDialog(context, 'Deleting your account...');
        await user.delete();
      } else {
        rethrow;
      }
    }

    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    Get.offAllNamed(Routes.CLIENT_SPACE);
  } catch (e) {
    if (context.mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      showErrorDialog(context, 'Error deleting account: ${e.toString()}');
    }
  }
}

Future<bool> _reauthenticateUser(BuildContext context, User user) async {
  try {
    final providerId = user.providerData.first.providerId;

    if (providerId == 'google.com') {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        showErrorDialog(context, 'Google reauthentication canceled.');
        return false;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    }

    if (providerId == 'apple.com') {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await user.reauthenticateWithCredential(oauthCredential);
      return true;
    }

    if (providerId == 'password') {
      final password = await _promptPasswordDialog(context);
      if (password == null) {
        showErrorDialog(
            context, 'Password is required to delete your account.');
        return false;
      }

      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);
      return true;
    }

    showErrorDialog(
        context, 'Unsupported authentication provider: $providerId');
    return false;
  } catch (e) {
    showErrorDialog(context, 'Reauthentication failed: ${e.toString()}');
    return false;
  }
}

Future<String?> _promptPasswordDialog(BuildContext context) async {
  final controller = TextEditingController();
  return await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text('Re-enter Password'),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, null),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: Text('Confirm'),
          ),
        ],
      );
    },
  );
}
