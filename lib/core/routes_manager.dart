import 'package:evently_app/features/authentication/login/login_screen.dart';
import 'package:evently_app/features/authentication/register/register_screen.dart';
import 'package:evently_app/features/create_event/create_event.dart';
import 'package:evently_app/features/create_event/create_event_provider.dart';
import 'package:evently_app/features/create_event/pick_location_screen.dart';
import 'package:evently_app/features/main_layout/main_layout.dart';
import 'package:evently_app/features/main_layout/map/map_tab_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoutesManager{
  static const String register="/register";
  static const String login="/login";
  static const String mainLayout="/mainLayout";
  static const String createEvent="/Create Event";
  static const String pickLocationScreen="/pick location screen";


  static Route? getRoute(settings){
    switch (settings.name){
      case register:
        return CupertinoPageRoute(builder: (context) =>RegisterScreen());

      case login:{
        return CupertinoPageRoute(builder: (context)=> LoginScreen());
      }
      case mainLayout:{
        return CupertinoPageRoute(builder: (context)=>ChangeNotifierProvider(create: (context)=>MapTabProvider(),child: MainLayout(),));
      }
      case createEvent:
        {
          return CupertinoPageRoute(
              builder: (ccc) =>
                  ChangeNotifierProvider(
                    create: (ctx) => CreateEventProvider(),
                    child: CreateEvent(),
                  )
          );
        }

      case pickLocationScreen:{

        return CupertinoPageRoute(
          settings: settings,
            builder: (newContext){
              var createEventProvider=ModalRoute.of(newContext)?.settings.arguments as CreateEventProvider;
              return PickLocationScreen(createEventProvider: createEventProvider);
            }
        );
      }
      }
    }


  }