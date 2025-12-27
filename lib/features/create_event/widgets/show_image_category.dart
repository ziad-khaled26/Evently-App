import 'package:evently_app/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowImageCategory extends StatefulWidget {
   const ShowImageCategory({super.key});

  @override
  State<ShowImageCategory> createState() => ShowImageCategoryState();
}

class ShowImageCategoryState extends State<ShowImageCategory> {
   late CategoryModel selectedCategory;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    selectedCategory=CategoryModel.getCategories(context)[0];

  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.asset(selectedCategory.imagePath),
    );
  }


  updateImageBasedOnNewCategory(CategoryModel newCategory){
    selectedCategory=newCategory;
    setState(() {

    });
  }
}
