import 'package:bflix/widgets/heading.dart';
import 'package:flutter/material.dart';

class CreditWidget extends StatelessWidget {
  final Map<dynamic,dynamic> credit;
  const CreditWidget({
    Key? key,
    required this.credit,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(5),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: Color.fromARGB(255, 35, 35, 35),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (credit['profile_path'] != null) ? Image.network('https://image.tmdb.org/t/p/w500/${credit['profile_path']}',fit: BoxFit.cover,):
                Image.asset('lib/images/user_icon.png',scale: 1,fit: BoxFit.cover,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(credit['name']),
              ),
            ],
          ),
        ),
    );
  }
}