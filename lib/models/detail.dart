import 'package:flutter/material.dart';
import 'package:lastest_broo/models/product.dart';

class Detail extends StatelessWidget {
  final id;
  final title;
  final price;
  final image;
  final description;
  final Rating rating;
  final category;

  Detail({
    this.id,
    this.title,
    this.price,
    this.image,
    this.description,
    required this.rating,
    this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          image != null
              ? Container(
                  height: 250,
                  child: Image.network(image),
                )
              : Container(
                  height: 250,
                  color: Colors.grey[200],
                ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$title',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      'price : ',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '\$$price',
                      style: TextStyle(color: Colors.orange[400], fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 15,
                    ),
                    Text(' ${rating.rate}'),
                    SizedBox(width: 15),
                    Text('${rating.count} Terjual'),
                  ],
                ),
                Divider(),
                RichText(
                  text: TextSpan(
                    text: "$description",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: " #$category'",
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
        backgroundColor: Color.fromARGB(94, 167, 88, 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
