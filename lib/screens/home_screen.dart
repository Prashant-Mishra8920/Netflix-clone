import 'dart:math';

import 'package:bflix/screens/main_page.dart';
import 'package:bflix/widgets/heading.dart';
import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Heading(text: "Who's Watching?"),
            // IconButton(
            //   onPressed: () => Null,
            //   icon: Image.asset('lib/images/user.png'),
            //   iconSize: 100,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width/1.5,
              height: MediaQuery.of(context).size.height/2,
              child: GridView.count(
                childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height/1.95),
                // padding: const EdgeInsets.all(10),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,

                children: const [
                  UserCard(),
                  UserCard(),
                  UserCard(),
                  UserCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({Key? key}) : super(key: key);

  String randIcon(){
    Random random = Random();
    String addr = 'lib/images/a${random.nextInt(5)}.png';
    // List<String> n = ['a1','a2','a3','a4','a5','a6'];
    return addr;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 300,
      child: Column(
        children: [
          Card(
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
              },
              child: Image.asset(randIcon()),
            )
          ),
          const Text("User"),
        ],
      ),
    );
  }
}


