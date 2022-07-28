import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashCard extends StatelessWidget {

  const DashCard({Key? key, required this.title, required this.nomber}) : super(key: key);
  final String title;
  final int nomber;

  @override
  Widget build(BuildContext context) {

    MaterialAccentColor color;
    if(title=="en attente"){
      color=Colors.redAccent;
    }else if(title=="en cours de traitement"){
      color=Colors.amberAccent;
    }else{
      color=Colors.greenAccent;
    }
    return GestureDetector(
      onTap: () {
       print("title");
      },
      child: Container(
          margin: EdgeInsets.all(10),
          height: 70,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: color
                    )),
              ),


              Positioned(
                top: 0,
                left: 0,

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text("Declarations "+title,
                          style:GoogleFonts.poppins(fontSize: 15, color: Colors.white ,fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,                child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(nomber.toString(),
                        style: GoogleFonts.poppins(fontSize: 20, color: Colors.white,fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              )
            ],
          )),
    );
  }

}
