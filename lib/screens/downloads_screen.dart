import 'package:flutter/material.dart';

class DownloadsScreen extends StatefulWidget {
  DownloadsScreen({Key? key}) : super(key: key);

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Downloads"),
      ),
    );
  }
}