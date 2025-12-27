import 'package:evently_app/core/extension/date_time_ex.dart';
import 'package:evently_app/core/resources/assets_manager.dart';
import 'package:evently_app/core/resources/colors_manager.dart';
import 'package:evently_app/core/utils/ui_utils.dart';
import 'package:evently_app/core/widgets/custom_elevated_button.dart';
import 'package:evently_app/core/widgets/custom_tab_bar.dart';
import 'package:evently_app/core/widgets/custom_text_button.dart';
import 'package:evently_app/core/widgets/custom_text_form_field.dart';
import 'package:evently_app/features/create_event/create_event_provider.dart';
import 'package:evently_app/features/create_event/pick_location_screen.dart';
import 'package:evently_app/features/create_event/widgets/pick_location_button.dart';
import 'package:evently_app/features/create_event/widgets/show_image_category.dart';
import 'package:evently_app/firebase/firebase_service.dart';
import 'package:evently_app/l10n/app_localization.dart';
import 'package:evently_app/models/category_model.dart';
import 'package:evently_app/models/event_model.dart';
import 'package:evently_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({super.key});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CreateEventProvider>().getSelectedCategory(context);

  }
  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context);
    return Consumer<CreateEventProvider>(
      builder: (context,provider,_)=>Scaffold(
        appBar: AppBar(title: Text(appLocalizations!.create_event)),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: provider.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ShowImageCategory(
                    key: provider.showImageStateKey,
                  ),
                  SizedBox(height: 16.h),
                  CustomTabBar(
                    categories: CategoryModel.getCategories(context),
                    selectedBgColor: ColorsManager.blue,
                    unSelectedBgColor: Colors.transparent,
                    selectedForegroundColor: ColorsManager.white,
                    unSelectedForegroundColor: ColorsManager.blue,
                    onCategoryItemSelected: (selectedCategory) {
                      provider.currentCategory=selectedCategory;
                      provider.showImageStateKey.currentState?.updateImageBasedOnNewCategory(selectedCategory);

                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    appLocalizations!.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    labelText: appLocalizations.event_title,
                    prefixIcon: Icons.edit_calendar_outlined,
                    controller:provider.titleController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Title is Required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    appLocalizations.description,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomTextFormField(
                    lines: 4,
                    labelText: appLocalizations.event_description,
                    controller: provider.descriptionController,
                    validator: (input) {
                      if (input == null || input.trim().isEmpty) {
                        return "Description is Required";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        color: Theme.of(context).canvasColor,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        provider.selectedDate.toFormattedDate,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Spacer(),
                      CustomTextButton(
                        text: appLocalizations.choose_date,
                        onPress: (){
                          provider.selectEventDate(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Theme.of(context).canvasColor,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        provider.selectedDate.toFormattedTime,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Spacer(),
                      CustomTextButton(
                        text: appLocalizations.choose_time,
                        onPress: (){
                          provider.selectEventTime(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    appLocalizations.location,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  SizedBox(height: 8.h),
                  PickLocationButton(createEventProvider: provider),
                  SizedBox(height: 16.h),

                  CustomElevatedButton(
                    text: appLocalizations.add_event,
                    onPress: (){
                      provider.addEvent(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



}
