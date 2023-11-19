




import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:chillx/home/Home.dart';

class Search extends SearchDelegate{
  @override
  // TODO: implement query
  String get query => super.query;
   late Box<String> Search_History;

  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.clear_sharp)),
      // IconButton(onPressed: (){}, icon: const Icon(Icons.filter))
      ];
    }

  @override
  Widget? buildLeading(BuildContext context) {
    return 
      IconButton(onPressed: ()=>
      Navigator.of(context).pop(context),
        
        icon: const Icon(Icons.arrow_back_ios_sharp));
  }

  @override
  Widget buildResults(BuildContext context) {
   
   return   
   const Center(child: Text("No Data"));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return 
    
    ListView(
      children: const [
        Text(""),
        ],
    );
  }
  
}