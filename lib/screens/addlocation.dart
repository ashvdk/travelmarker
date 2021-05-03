import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelpointer/screens/adddescriptionaboutthelocation.dart';
import 'package:travelpointer/screens/addnewlocation.dart';
import 'package:travelpointer/screens/mapwithmarkers.dart';
import 'package:travelpointer/screens/selectcategory.dart';

class AddLocationNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: 'addanewlocation',
      onGenerateRoute: (RouteSettings settings) {
        final Map arguments = settings.arguments;
        WidgetBuilder builder;
        switch (settings.name) {
          case 'addanewlocation':
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'signup/choose_credentials'.
            builder = (BuildContext _) => AddaNewLocation();
            break;
          case 'selectlocationcategory':
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'signup/choose_credentials'.
            builder = (BuildContext _) => SelectLocationCategory();
            break;
          case 'adddescriptionaboutthelocation':
            // Assume CollectPersonalInfoPage collects personal info and then
            // navigates to 'signup/choose_credentials'.
            builder = (BuildContext _) => AddDescriptionAboutTheLocation();
            break;
          case 'showthelocations':
            // Assume ChooseCredentialsPage collects new credentials and then
            // invokes 'onSignupComplete()'.
            // builder = (BuildContext _) => MapWithMarkers(
            //       lat: arguments['lat'],
            //       lng: arguments['lng'],
            //       city: "${arguments['city']}",
            //     );
            builder = (BuildContext _) => MapWithMarkers(
                  latlng: arguments['latlang'],
                  id: arguments['id'],
                );
            break;
          default:
            throw Exception('Invalid route: ${settings.name}');
        }
        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}
