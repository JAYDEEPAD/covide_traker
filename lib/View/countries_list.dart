import 'package:covide_traker/Services/state_service.dart';
import 'package:covide_traker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


void main(){
  runApp(MaterialApp(title: "CountryListScreen", debugShowCheckedModeBanner: false,));
}

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({Key? key}) : super(key: key);

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  TextEditingController searchcontroller=TextEditingController();
  StateServices stateServices=StateServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor:Colors.black
      ),
      body: SafeArea(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value){
                setState(() {

                });
              },
              controller: searchcontroller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hintText: "Search with Country Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.0),
                )
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                future: stateServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                    if(!snapshot.hasData){
                      return ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context,index){
                            return Shimmer.fromColors(baseColor: Colors.grey.shade700,
                              highlightColor: Colors.grey.shade100,
                              child:   Column(children: [ListTile(
                            title:Container(color: Colors.white,height: 10,width: 89,),
                            subtitle:Container(color: Colors.white,height: 10,width: 10,),
                            leading: Container(color: Colors.white,height: 50,width: 50,),
                              ),
                              ],),
                            );

                          });
                    }else{
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                          itemBuilder: (context,index){
                          String name=snapshot.data![index]['country'];

                          if(searchcontroller.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country'],
                                    active: snapshot.data![index]['active'],
                                    critical: snapshot.data![index]['critical'],
                                    test: snapshot.data![index]['tests'],
                                    todayRecovered: snapshot.data![index]['todayRecovered'],
                                    totalCases: snapshot.data![index]['cases'],
                                    totalDeathes: snapshot.data![index]['deaths'],
                                    totalRecovered: snapshot.data![index]['recovered'],

                                  )));
                            },
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']),
                                    subtitle:Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  ),
                                )
                              ],
                            );

                          }else if(name.toLowerCase().contains(searchcontroller.text.toLowerCase()))
                          {
                            return Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                      image: snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      active: snapshot.data![index]['active'],
                                      critical: snapshot.data![index]["critical"],
                                      test: snapshot.data![index]['tests'],
                                      todayRecovered: snapshot.data![index]['todayRecovered'],
                                      totalCases: snapshot.data![index]['cases'],
                                      totalDeathes: snapshot.data![index]['deaths'],
                                      totalRecovered: snapshot.data![index]['recovered'],

                                    )));
                                  },
                                  child: ListTile(
                                    title:Text(snapshot.data![index]['country']),
                                    subtitle:Text(snapshot.data![index]['cases'].toString()),
                                    leading: Image(
                                      height:50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag']),),
                                  ),
                                )
                              ],
                            );
                          }else{
                              return Container();
                          }

                                                      });
                    }
              }),)
        ],
      )),
    );
  }
}
