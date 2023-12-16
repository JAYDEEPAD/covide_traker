import 'package:covide_traker/View/world_state.dart';
import 'package:flutter/material.dart';


void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false,));
}


class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int totalCases,totalDeathes,totalRecovered,active,critical,todayRecovered,test;
   DetailScreen({required this.name, required this.image,
    required this.todayRecovered,
    required this.critical,
     required this.active,
     required this.test,
     required this.totalCases,
     required this.totalDeathes,
     required this.totalRecovered
   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
          centerTitle: true,
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                  Padding(
                    padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                    child: Card(
                      child: Column(
                        children: [
                          SizedBox(height: MediaQuery.of(context).size.height*.06,),
                          ReusableRow(title: 'Cases', value: widget.totalCases.toString()),
                          ReusableRow(title: 'Recovered', value: widget.totalRecovered.toString()),
                          ReusableRow(title: 'Death', value: widget.totalDeathes.toString()),
                          ReusableRow(title: "critical", value: widget.critical.toString()),
                          ReusableRow(title: 'Today Recovered', value: widget.todayRecovered.toString()),
                          ReusableRow(title: 'active', value: widget.active.toString()),
                          ReusableRow(title: 'tests', value: widget.test.toString()),

                        ],
                      ),
                    ),
                  ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                )
              ],
            )
          ],
        ) ,
      ),
    );
  }
}
