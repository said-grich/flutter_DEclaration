import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled/pages/news/ComplaintModel.dart';

import '../../Constant.dart';

class ComplaintCard extends StatelessWidget {
  ComplaintModel? complaint;
  Function onCardClick;
  final constant = Constant();
  MaterialAccentColor? materialColor;
  ComplaintCard({
    Key? key,
    this.complaint,
    required this.onCardClick,
  }) {
    String libelle = complaint!.listEtat![0].etat.libelle;
  
    if (libelle == "en attente") {
      materialColor = Colors.redAccent;
    } else if (libelle == "en cours de traitement") {
      materialColor = Colors.amberAccent;
    } else {
      materialColor = Colors.greenAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onCardClick();
      },
      child: Container(
          margin: const EdgeInsets.all(20),
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child:
                        Image.network(constant.baseUrl2 + complaint!.photoUri),
                  ),
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
                        color: Colors.black.withOpacity(0.65))),
              ),
              Positioned(
                bottom: 50,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          bottom: 5, // Space between underline and text
                        ),
                        decoration: const BoxDecoration(
                            border:  Border(
                                bottom:  BorderSide(
                          color: Colors.amber,
                          width: 2.0, // Underline thickness
                        ))),
                        child: Text(complaint!.title,
                            style: GoogleFonts.poppins(
                                fontSize: 22, color: Colors.white)),
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
                      Text("Date: ${complaint!.dateDecl}",
                          style: GoogleFonts.roboto(
                              fontSize: 15, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Text(
                        "l'état : ${complaint!.listEtat![0].etat.libelle}",
                        style: GoogleFonts.roboto(fontSize: 15, color: materialColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
