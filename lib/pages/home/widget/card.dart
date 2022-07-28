import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/news/ComplaintModel.dart';

import '../../../Constant.dart';


class AllComplaintCard extends StatelessWidget {
  ComplaintModel? complaint;
  Function? onCardClick;
  final constant =new Constant()  ;

  AllComplaintCard({ this.complaint, this.onCardClick });

  @override
  Widget build(BuildContext context) {

    var libelle=this.complaint!.listEtat![0].etat.libelle;
    MaterialAccentColor color;
    if(libelle=="en attente"){
      color=Colors.redAccent;
    }else if(libelle=="en cours de traitement"){
      color=Colors.amberAccent;
    }else{
      color=Colors.greenAccent;
    }
    return GestureDetector(
      onTap: () {
        this.onCardClick!();
      },
      child: Container(
          margin: EdgeInsets.all(20),
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FittedBox(child: Image.network(constant.baseUrl2+complaint!.photoUri),fit: BoxFit.fill,),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.65)
                    )),
              ),
              Positioned(
                bottom: 50,

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [

                      Container(
                        padding: EdgeInsets.only(
                          bottom: 5, // Space between underline and text
                        ),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.amber,
                              width: 2.0, // Underline thickness
                            ))
                        ),
                        child: Text(this.complaint!.title,
                            style: GoogleFonts.poppins(fontSize: 22,color: Colors.white)),
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 0,
                left: 0,

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [


                      Text("Date: "+this.complaint!.dateDecl,
                          style:GoogleFonts.roboto(fontSize: 15, color: Colors.white)),

                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [

                    Text("l'adresse : "+this.complaint!.adresse,
                        style: GoogleFonts.roboto(fontSize: 15, color: Colors.blue)),

                  ],
                ),
              ),
              )
            ],
          )),
    );
  }
}