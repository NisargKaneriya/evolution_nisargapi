import 'dart:convert';
import 'package:evolution_nisargapi/addapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Row(
                        children: [
                          Expanded(child: Text(snapshot.data![index]['Enrollno'].toString())),
                          Expanded(child: Text(snapshot.data![index]['Name'].toString())),
                          Expanded(child: Text(snapshot.data![index]['Age'].toString())),
                          Expanded(child: InkWell(
                              onTap: () {
                                deleData(snapshot.data![index]['Enrollno'].toString()).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Icon(Icons.delete_forever_outlined)
                          )
                          ),
                          Expanded(child: InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Addapi(snapshot.data![index]),)).then((value) {
                                  setState(() {});
                                },);
                              },
                              child: Icon(Icons.edit)
                          )
                          )
                        ],
                      ),
                    );
                  });
            }
            else if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()));
            }
            else{
              return Center(child: Container(child: CircularProgressIndicator(),));
            }
          }
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Addapi(null),)).then((value) {
              if(value==true){
                setState(() {

                });
              }
            },);
          },
          child: Icon(Icons.add)
      ),
    );
  }
}

Future<List> getData() async{
  var res= await http.get(Uri.parse('https://65fc639c9fc4425c652ffe6f.mockapi.io/studentinfo/'));
  return jsonDecode(res.body);
}
Future<void> deleData(String id) async{
  var res =await http.delete(Uri.parse('https://65fc639c9fc4425c652ffe6f.mockapi.io/studentinfo/'+id));
  return jsonDecode(res.body);
}
