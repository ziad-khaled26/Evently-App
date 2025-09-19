import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/utils/utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/routes_manager.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool securePassword = true;
  bool securePasswordConfirmation = true;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  void _createAccount(){
    if(formKey.currentState!.validate()){
      Navigator.pushReplacementNamed(context, RoutesManager.login);
    }

  }

  @override
  void initState() {
    super.initState();
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    rePasswordController=TextEditingController();

  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appLocalizations=AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations!.register)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(ImageAssets.eventlyLogo, width: 136.w, height: 186.h),
                SizedBox(height: 24.h),
                CustomTextFormField(
                  labelText: appLocalizations.name,
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  validator: (input){
                    if(input==null || input.trim().isEmpty){
                      return "Name is Required";
                    }
                    if(input.length<5 ){
                      return  "Name should be at least 5ch";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                CustomTextFormField(
                  labelText: appLocalizations.email,
                  prefixIcon: Icons.mail,
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (input){
                    if(input==null || input.trim().isEmpty){
                      return "email is required";
                    }
                    if(!ValidationUtils.isValidEmail(input)){
                      return "Email bad format";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                CustomTextFormField(
                  labelText: appLocalizations.password,
                  secureText: securePassword,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      securePassword = !securePassword;
                      setState(() {});
                    },
                    icon: Icon(
                      securePassword ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: passwordController,
                  validator: (input){
                    if(input==null || input.trim().isEmpty){
                      return "Password is required";
                    }
                    if(input.length <6){
                      return "Password should be at least 6 chars";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                CustomTextFormField(
                  labelText: appLocalizations.re_password,
                  secureText: securePasswordConfirmation,
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () {
                      securePasswordConfirmation = !securePasswordConfirmation;
                      setState(() {});
                    },
                    icon: Icon(
                      securePasswordConfirmation
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  controller: rePasswordController,
                  validator: (input){
                    if(input == null || input.trim().isEmpty){
                      return "plz, confirm password";
                    }
                    if(input != passwordController.text){
                      return "password doesn't match";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                CustomElevatedButton(text: appLocalizations.create_account,
                    onPress: _createAccount),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      appLocalizations.already_have_account,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    CustomTextButton(
                      text: appLocalizations.login,
                      onPress: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesManager.login,
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
