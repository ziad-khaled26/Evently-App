import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late TextEditingController eventController;
  late TextEditingController titleController;

  GlobalKey<FormState> formKey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    eventController=TextEditingController();
    titleController=TextEditingController();
  }

  @override
  void dispose() {
    eventController.dispose();
    titleController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var appLocalizations=AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(appLocalizations!.create_event)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: Image.asset(ImageAssets.meeting),
                ),
                SizedBox(height: 16.h,),

                CustomTabBar(
                    categories: CategoryModel.getCategories(context),
                    selectedBgColor: ColorsManager.blue,
                    unSelectedBgColor: Colors.transparent,
                    selectedForegroundColor: ColorsManager.white,
                    unSelectedForegroundColor: ColorsManager.blue
                ),
                SizedBox(height: 16.h,),
                Text(
                  appLocalizations.title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 8.h,),
                CustomTextFormField(
                  labelText: appLocalizations.event_title,
                  prefixIcon: Icons.edit_calendar_outlined,
                  controller: titleController,
                  validator: (input){
                    if(input==null || input.trim().isEmpty){
                      return "Title is Required";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h,),
                Text(
                  appLocalizations.description,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(height: 8.h,),
                CustomTextFormField(
                    lines: 4,
                    labelText: appLocalizations.event_description,
                    controller: eventController,
                    validator: (input){
                      if(input==null || input.trim().isEmpty){
                        return "Description is Required";
                      }
                      return null;
                    },

                  ),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Icon(Icons.date_range_outlined,color: Theme.of(context).canvasColor,),
                    SizedBox(width: 10.w,),
                    Text(
                      appLocalizations.event_date,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Spacer(),
                   CustomTextButton(text: appLocalizations.choose_date, onPress: (){
                     showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
                   }),
                  ],
                ),
                SizedBox(height: 16.h,),
                Row(
                  children: [
                    Icon(Icons.access_time,color: Theme.of(context).canvasColor),
                    SizedBox(width: 10.w,),
                    Text(
                      appLocalizations.event_time,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Spacer(),
                    CustomTextButton(text: appLocalizations.choose_time, onPress: (){
                      showTimePicker(context: context, initialTime: TimeOfDay.now());
                    }),
                  ],
                ),
                SizedBox(height:16.h),
                CustomElevatedButton(text: appLocalizations.add_event, onPress: _addEvent,)





              ],
            ),
          ),
        ),
      ),
    );
  }
  void _addEvent(){
      if(!formKey.currentState!.validate()){
        return;
      }

  }
}
