// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sort_child_properties_last, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:movie_maveen/payment.dart';
import 'package:movie_maveen/subscription.dart';
import 'MyDatabse/connection.dart';
import 'payment.dart';

class Subscription extends StatefulWidget {
  const Subscription({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  _Subscription createState() => _Subscription();
}

class _Subscription extends State<Subscription> {
  //late List lessons;
  late List<subscriptionmodel> SubscriptionModel;
  String model = '';
  int UserIdd=-1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    hasBoughtSubscription();
    SubscriptionModel = getLessons();
  }

  Future<void> hasBoughtSubscription() async {
    final SubscriptionData = await getSubscriptionsByUserId(userId.toString());
    if (SubscriptionData.isNotEmpty) {
      for (var row in SubscriptionData) {
        print(row);
        setState(() {
          model = row['modelname'];
          UserIdd =int.parse(row['userld']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here
            Navigator.pop(context);
          },
        ),
        elevation: 0.1,
        backgroundColor: Colors.black,
        title: Text(widget.title),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.list))],
      ),
      body: Container(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: SubscriptionModel.length,
            itemBuilder: (context, index) {
              return Card(
                  elevation: 8.0,
                  margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Colors.red),
                          ),
                        ),
                        child: Icon(
                          Icons.attach_money_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        SubscriptionModel[index].title,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          // Icon(Icons.linear_scale, color: Colors.yellowAccent,),
                          // Text(" Intermediate", style: TextStyle(color: Colors.white),)
                          Expanded(
                            flex: 1,
                            child: Container(
                              child: LinearProgressIndicator(
                                backgroundColor: Colors.white,
                                value: SubscriptionModel[index].indicatorValue,
                                valueColor: AlwaysStoppedAnimation(Colors.red),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                '\$ ' +
                                    SubscriptionModel[index].price.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      trailing: InkWell(
                        onTap: () {
                          // Handle button tap here
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Payment(
                                        modelName:
                                            SubscriptionModel[index].title,
                                        price: SubscriptionModel[index]
                                            .price
                                            .toString(),
                                      )));
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            if (model != SubscriptionModel[index].title) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Payment(
                                    modelName: SubscriptionModel[index].title,
                                    price: SubscriptionModel[index]
                                        .price
                                        .toString(),
                                  ),
                                ),
                              );
                            }
                          },
                          child: Text(
                            userId != UserIdd
                                ? 'Buy'
                                : (model == SubscriptionModel[index].title
                                    ? 'Purchased'
                                    : 'Upgrade'),
                            style: TextStyle(fontSize: 17),
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState> states) {
                              if (model == SubscriptionModel[index].title) {
                                // Color when button is pressed
                                return Colors.grey;
                              } else {
                                // Default color
                                return Colors.red;
                              }
                            }),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}

class subscriptionmodel {
  String title;
  String level;
  double indicatorValue;
  int price;
  String content;

  subscriptionmodel(
      {required this.title,
      required this.level,
      required this.indicatorValue,
      required this.price,
      required this.content});
}

List<subscriptionmodel> getLessons() {
  return [
    subscriptionmodel(
        title: "Pro Weekly",
        level: "Beginner",
        indicatorValue: 0.33,
        price: 50,
        content:
            "Start by taking a couple of minutes to read the info , Start by taking a couple of minutes to read the info , Start by taking a couple of minutes to read the info , Start by taking a couple of minutes to read the info"),
    subscriptionmodel(
        title: "Pro Monthly",
        level: "Beginner",
        indicatorValue: 0.40,
        price: 150,
        content: "Start by taking a couple of minutes to read the info"),
    subscriptionmodel(
        title: "Pro 3 Months",
        level: "Beginner",
        indicatorValue: 0.50,
        price: 300,
        content: "Start by taking a couple of minutes to read the info"),
    subscriptionmodel(
        title: "Pro 6 Months",
        level: "Beginner",
        indicatorValue: 0.70,
        price: 500,
        content: "Start by taking a couple of minutes to read the info"),
    subscriptionmodel(
        title: "Pro 1 Year",
        level: "Beginner",
        indicatorValue: 0.80,
        price: 800,
        content: "Start by taking a couple of minutes to read the info"),
  ];
}
