import 'dart:convert';
import 'package:get/get_state_manager/src/rx_flutter/rx_notifier.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:paint_app/models/user_model.dart';


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<UserModel> userList=[];
  Future<List<UserModel>> getUserApi()async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data =jsonDecode(response.body.toString());
    if(response.statusCode==200){
    for(Map i in data){
      print(i['name']);
      userList.add(UserModel.fromJson(i));
    }

      return userList;
    }else{
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("api"),
      ),
      body: Column(
        children: [
        Expanded(
          child: FutureBuilder(future: getUserApi(), builder: (context, AsyncSnapshot<List<UserModel>> snapshot){
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            else {
              return ListView.builder(
                  itemCount: userList.length, itemBuilder: (context, index) {
                return Card(child: Column(
                  children: [
                    ReusableRow(title: 'Name', value: snapshot.data![index].name.toString()),
                    ReusableRow(title: 'Email', value: snapshot.data![index].email.toString()),
                    ReusableRow(title: 'username', value: snapshot.data![index].username.toString()),
                    ReusableRow(title: 'Address', value: snapshot.data![index].address!.city.toString()),
                  ],

                ),);
              });
            }
          }),
        )
        ],
      ),
    );
  }
}
// reusable row widget
class ReusableRow extends StatefulWidget {
  final String title,value;
  const ReusableRow({Key? key, required this.title, required this.value}) : super(key: key);
  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
          Text(widget.value),
        ],
      ),
    );
  }
}

