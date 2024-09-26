import 'package:flutter/material.dart';

class CategoryModel {
  String title;
  String name;
  String image;
  String quantity;
  String order;
  String date;
  String price;
  String weight;
  Color boxColor;
  bool viewIsSelected;
  

  CategoryModel({
    required this.title,
    required this.name,
    required this.image,
    required this.quantity,
    required this.order,
    required this.date,
    required this.boxColor,
    required this.viewIsSelected,
    required this.price,
    required this.weight,

  });

  static List < CategoryModel > getCategories() {
    List < CategoryModel > categories = [];

    categories.add(
      CategoryModel(
       title: '    Received',
       name: 'Royal Cannin             ',
       image: 'assets/images/roycan3.png',
       quantity: 'number: 1',
       order: 'Order Number: 567',
       date: 'Order Date: 20.08.21',
       viewIsSelected: true,
       boxColor: Colors.white,
       price: '10',
       weight: 'kg: 1,5'
      )
    );

    categories.add(
      CategoryModel(
       title: '    Received',
       name: 'Wiskas                  ',
       image: 'assets/images/wiskas.png',
       quantity: 'number: 1',
       order: 'Order Number: 394',
       date: 'Order Date: 16.06.21',
       viewIsSelected: false,
       boxColor: Colors.white,
       price: '10',
       weight: 'gr: 200'
      )
    );

    return categories;
  }
}