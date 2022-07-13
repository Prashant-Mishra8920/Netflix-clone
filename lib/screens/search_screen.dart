import 'dart:ui';

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: (){
      //       showSearch(
      //         context: context,
      //         delegate: CustomSearchDelegate(),);
      //     }, 
      //     icon: const Icon(Icons.search)),
      //   ],
      // ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: AppBar().preferredSize.height,left: 10,right: 10),
            height: AppBar().preferredSize.height,
            width: MediaQuery.of(context).size.width,
            child: InkWell(
              onTap: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),);
              },
              child: Card(
                color: Color.fromARGB(255, 35, 35, 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text("Search",style: TextStyle(color: Colors.grey),),
                    ),
                    IconButton(onPressed: (){
                      showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(),);
                    }, 
                    icon: const Icon(Icons.search,color: Colors.grey,)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      // Center(
      //   child: Text("Search"),
      // ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate{
  List<String> searchTerms = [
    'Apple',
    'Banana',
    'Cat',
    'Dog',
  ];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      // primaryColor: Colors.grey,
      // primaryTextTheme: TextTheme(bodyText1: TextStyle(color: Colors.grey)),
      // primaryColorBrightness: Brightness.dark,
      hintColor: Colors.grey,
      accentColor: Colors.grey,
      // these ↓ do not work ☹️
      appBarTheme: theme.appBarTheme.copyWith(color: Color.fromARGB(255, 35, 35, 35), elevation: 0,titleTextStyle: TextStyle(color: Colors.grey)),
      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
         
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){query = '';}, icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: const Icon(Icons.arrow_back),);
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for(var i in searchTerms){
      if(i.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(i);
      }
    }

    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for(var i in searchTerms){
      if(i.toLowerCase().contains(query.toLowerCase())){
        matchQuery.add(i);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      }
    );
  }

}