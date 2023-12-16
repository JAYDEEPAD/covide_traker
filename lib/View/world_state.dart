import 'package:covide_traker/Models/WorldStatesModels.dart';
import 'package:covide_traker/Services/state_service.dart';
import 'package:covide_traker/View/countries_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';


void main(){
  runApp(MaterialApp(title: "WorldState Screen", debugShowCheckedModeBanner: false,));
}

class WorldState extends StatefulWidget {
  const WorldState({Key? key}) : super(key: key);

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {

  late final AnimationController _controller=AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  void dispose(){

    super.dispose();
    _controller.dispose();
  }

  final colorlist=<Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];


  @override
  Widget build(BuildContext context) {
    StateServices stateServices=StateServices();
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding:  EdgeInsets.all(15.0),
            child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height* .01,),
          FutureBuilder(
              future: stateServices.fetchWorldstates(),
              builder: (context,AsyncSnapshot<
              WorldStatesModels>snapshot){
            if(!snapshot.hasData)
              {
                return Expanded(
                    flex: 1,
                    child: SpinKitFadingCircle(
                  color: Colors.white,
                  size: 50.0,
                  controller: _controller,
                ));
              }
            else{
              return Column(
                children: [
                  PieChart(

                    dataMap:  {
                      'Total':double.parse(snapshot.data!.cases.toString()),
                      "Recovered":double.parse(snapshot.data!.recovered.toString()),
                      "Deaths":double.parse(snapshot.data!.deaths.toString()),

                    },
                    chartValuesOptions: ChartValuesOptions(
                      showChartValuesInPercentage: true,
                    ),
                    chartRadius: MediaQuery.of(context).size.width/3.2,
                    legendOptions: const LegendOptions(
                        legendPosition: LegendPosition.left
                    ),
                    animationDuration: Duration(milliseconds: 1200),
                    chartType: ChartType.ring,
                    colorList: colorlist,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06),
                    child: Card(
                      child: Column(
                        children: [
                          ReusableRow(title: "Total", value: snapshot.data!.cases.toString()),
                          ReusableRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                          ReusableRow(title: "deaths", value: snapshot.data!.deaths.toString()),
                          ReusableRow(title: "Active", value: snapshot.data!.active.toString()),
                          ReusableRow(title: "critical", value: snapshot.data!.critical.toString()),
                          ReusableRow(title: "Today Deaths", value: snapshot.data!.todayDeaths.toString()),
                          ReusableRow(title: "todayRecovered", value: snapshot.data!.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                 GestureDetector(
                   onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryListScreen()));
                   },
                   child: Container(
                     decoration: BoxDecoration(
                       color: Colors.cyan
                     ),
                     height: 50.0,
                     child: const Center(
                       child: Text("Track Countrties"),
                     ),
                   ),
                 )
                ],
              );
            }

          }),



        ],
      ),
          )
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

   ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 10,right: 10,top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
