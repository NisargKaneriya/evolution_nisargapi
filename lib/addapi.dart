  import 'dart:convert';

  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;

class Addapi extends StatefulWidget {
  Map<String,Object?>? map;
  Addapi(map){
    this.map=map;
  }

  @override
  State<Addapi> createState() => _AddapiState();
}

class _AddapiState extends State<Addapi> {
  var nameController = TextEditingController();
  var enrollnoController = TextEditingController();
  var ageController = TextEditingController();

  void initState() {
    nameController.text = widget.map == null ? '' : widget.map!["Name"].toString();
    enrollnoController.text = widget.map == null ? '' : widget.map!["Enrollno"].toString();
    ageController.text = widget.map == null ? '' : widget.map!["Age"].toString();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child:
        Scaffold(
          body: Card(
            child: Column(
              children: [
                Container(
                  child: TextFormField(
                    controller: enrollnoController,
                    decoration: InputDecoration(hintText: 'Enter Enrollnment no.'),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: "Enter name"),
                  ),
                ),
                Container(
                  child: TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(hintText: "Enter Age"),
                  ),
                ),
                Center(
                  child: Container(
                      child: ElevatedButton(onPressed: () async{
                        if(widget.map==null){
                          await insertstudent().then((value)=>Navigator.of(context).pop(true));
                        }
                        else{
                          editstudent(widget.map!["Enrollno"].toString()).then((value)=>Navigator.of(context).pop(true));
                        }
                      },child: Text("Submit"),)
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> insertstudent() async{
    var map={};
    map["Name"]=nameController.text;
    map["Age"]=ageController.text;
    var res = await http.post(
      Uri.parse("https://65fc639c9fc4425c652ffe6f.mockapi.io/studentinfo/"),
      body: map,);


  }
  Future<void> editstudent(String Enrollno) async {
    var map = {};
    map['Name'] = nameController.text;
    map['Age'] = ageController.text;
    var res = await http.put(
      Uri.parse("https://65fc639c9fc4425c652ffe6f.mockapi.io/studentinfo/" + Enrollno),
      body: map,);
    return jsonDecode(res.body);
  }
}
