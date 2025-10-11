import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/resources/constants/constant_manager.dart';
import 'package:evently_app/core/utils/ui_utils.dart';
import 'package:evently_app/core/utils/utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/features/main_layout/main_layout.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/routes_manager.dart';
import '../../../models/user_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool secure = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    ImageAssets.eventlyLogo,
                    width: 136.w,
                    height: 141.h,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    labelText: appLocalizations!.email,
                    prefixIcon: Icons.mail,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Email is required";
                      }
                      if (!ValidationUtils.isValidEmail(input)) {
                        return "email bad format";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextFormField(
                    secureText: secure,
                    labelText: appLocalizations.password,
                    prefixIcon: Icons.lock,
                    suffixIcon: IconButton(
                      onPressed: () {
                        secure = !secure;

                        setState(() {});
                      },
                      icon: secure
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    controller: passwordController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "password is required";
                      }
                      if (input.length < 6) {
                        return "Sorry, password should be at least 6 chars";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  CustomTextButton(
                    text: appLocalizations.forget_password,
                    onPress: () {},
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: 24.h),
                  CustomElevatedButton(
                    text: appLocalizations.login,
                    onPress: _login,
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appLocalizations.dont_have_account,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      CustomTextButton(
                        text: appLocalizations.create_account,
                        onPress: () {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesManager.register,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: ColorsManager.blue,
                          indent: 24.w,
                          endIndent: 16,
                        ),
                      ),
                      Text(
                        appLocalizations.or,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorsManager.blue,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: ColorsManager.blue,
                          indent: 24.w,
                          endIndent: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: REdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      side: BorderSide(color: ColorsManager.blue),
                    ),
                    onPressed: () {},

                    child: Row(
                      spacing: 10.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(ImageAssets.googleIcon),
                        Text(
                          appLocalizations.login_with_google,
                          style: GoogleFonts.inter(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                            color: ColorsManager.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      UIUtils.showLoadingDialog(context);
      UserCredential credential=await FirebaseService.login(emailController.text, passwordController.text);
       UserModel.currentUser=await FirebaseService.getUserFromFirestore(credential.user!.uid);

      UIUtils.hideLoadingDialog(context);
      Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
    } on FirebaseAuthException catch (exception) {
      UIUtils.hideLoadingDialog(context);
      UIUtils.showMessage(context, FirebaseConstants.invalidEmailOrPasswordMessage);
    }catch(e){
      UIUtils.hideLoadingDialog(context);
      UIUtils.showMessage(context, FirebaseConstants.failedToLoginMessage);
    }
  }
}
