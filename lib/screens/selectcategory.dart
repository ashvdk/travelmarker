import 'package:flutter/material.dart';
import 'package:travelpointer/classes/addanewlocation.dart';
import 'package:travelpointer/components/categorieswithicons.dart';
import 'package:travelpointer/screens/adddescriptionaboutthelocation.dart';
import 'package:provider/provider.dart';

class SelectLocationCategory extends StatefulWidget {
  @override
  _SelectLocationCategoryState createState() => _SelectLocationCategoryState();
}

class _SelectLocationCategoryState extends State<SelectLocationCategory> {
  var category;
  void setCategory(String categoryType) {
    setState(() {
      category = categoryType;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              children: [
                CategoriesWithIcons(
                  geticons: Icons.agriculture,
                  title: 'Agriculture',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.ev_station_rounded,
                  title: 'EV Station',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.electric_scooter,
                  title: 'Electric Scooter',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.local_grocery_store_outlined,
                  title: 'Shopping',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.bike_scooter,
                  title: 'Rent Bikes',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.waves,
                  title: 'Beach',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.terrain,
                  title: 'Terrain',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.agriculture,
                  title: 'Agriculture',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.agriculture,
                  title: 'Agriculture',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.agriculture,
                  title: 'Agriculture',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
                CategoriesWithIcons(
                  geticons: Icons.agriculture,
                  title: 'Agriculture',
                  setCategoryFunc: setCategory,
                  category: category,
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: FlatButton(
                  color: Colors.lightBlueAccent,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                  height: 50.0,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
              ),
              Expanded(
                child: FlatButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  splashColor: Colors.blueAccent,
                  height: 50.0,
                  onPressed: () {
                    Provider.of<AddANewLocation>(context, listen: false)
                        .setCategory(category);
                    Navigator.of(context)
                        .pushNamed('adddescriptionaboutthelocation');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) =>
                    //         AddDescriptionAboutTheLocation(),
                    //   ),
                    // );
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
