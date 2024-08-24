import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:habittrackerapp/common/Constant.dart';
import 'package:habittrackerapp/common/custom_text_field.dart';
import 'package:habittrackerapp/common/spacing.dart';
import 'package:habittrackerapp/feature/auth/screens/LoginScreen.dart';
import 'package:habittrackerapp/feature/auth/widget/custom_button.dart';
import 'package:habittrackerapp/theme/Colors.dart';
import 'package:habittrackerapp/theme/text_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final _formKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  bool isLoading = false; 

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    username.dispose();
    firstName.dispose();
    lastName.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  // Function to handle registration
  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Create the user in Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      User? user = userCredential.user;

      // Store the user's additional details in Firestore
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': username.text.trim(),
          'firstName': firstName.text.trim(),
          'lastName': lastName.text.trim(),
          'phoneNumber': phoneNumber.text.trim(),
          'email': user.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const Loginscreen()),
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = e.message ?? 'Registration failed. Please try again.';

 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool obscureText;
    return Scaffold(
      backgroundColor: AppColors.kBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightSpacer(40),
                Center(
                  child: Image.asset(
                    AppConstants.logo,
                    height: 150.h,
                    width: 150.w,
                  ),
                ),
                heightSpacer(30),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Register your account here",
                    style: TextStyle(
                      fontSize: 20.sp,
                      color: Color(0xff522258),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                heightSpacer(25),
                _buildTextField("UserName", username, "Enter your Username"),
                _buildTextField("First Name", firstName, "Enter your First name"),
                _buildTextField("Last Name", lastName, "Enter your Last name"),
                _buildTextField("Contact Number", phoneNumber, "Enter your contact number"),
                _buildTextField("Email Address", email, "Enter your Email address", TextInputType.emailAddress),
                _buildTextField("Password", password, "Enter your Password", TextInputType.visiblePassword,obscureText=true),
                heightSpacer(25),
                isLoading
                    ? Center(child: CircularProgressIndicator())
                    : CustomButton(
                        buttonText: "Register",
                        onTap: _registerUser,
                      ),
                heightSpacer(10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // A reusable method to build text fields
  Widget _buildTextField(String label, TextEditingController controller, String hint, [TextInputType? keyboardType, bool obscureText = false]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextTheme.kLabelStyle),
        CustomTextField(
          controller: controller,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xffd1d8ff)),
            borderRadius: BorderRadius.circular(14),
          ),
          inputHint: hint,
          obscureText: obscureText,
          validator: (value) {
            if (value!.isEmpty) {
              return '$label is required';
            }
            return null;
          },
        ),
        heightSpacer(15),
      ],
    );
  }
}
