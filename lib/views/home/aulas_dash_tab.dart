// ignore_for_file: must_be_immutable

import 'package:controle_alunos_musica_ft/components/borded_text.dart';
import 'package:controle_alunos_musica_ft/database/repositories/aulas_repository.dart';
import 'package:controle_alunos_musica_ft/models/aulas_dash.dart';
import 'package:flutter/material.dart';

import '../../config/app_colors.dart';

class AulasDashTab extends StatelessWidget {
  AulasDashTab({
    super.key,
    required this.setAulaFiltroHoje,
    required this.setAulaFiltroMes,
    required this.setAulaFiltroAno,
  });
  final _repository = AulasRepository();
  final void Function()? setAulaFiltroHoje;
  final void Function()? setAulaFiltroMes;
  final void Function()? setAulaFiltroAno;
  bool loadGetAulasIntrutorDash = true;
  int iCores = -1;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 30),
          BordedText(
            text: "Por Período",
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                onGetAulasPeriodoDash(context, _repository.onGetAulasHojeDash(),
                    const Color(0XFF43aa8b), setAulaFiltroHoje),
                onGetAulasPeriodoDash(context, _repository.onGetAulasMesDash(),
                    const Color(0XFF003049), setAulaFiltroMes),
                onGetAulasPeriodoDash(context, _repository.onGetAulasAnoDash(),
                    const Color(0XFFc1121f), setAulaFiltroAno),
              ],
            ),
          ),
          BordedText(
            text: "Por Instrutor",
          ),
          onGetAulasIntrutorDash(context),
        ],
      ),
    );
  }

  FutureBuilder onGetAulasPeriodoDash(BuildContext context,
      Future<dynamic>? future, Color color, void Function()? onTap) {
    return FutureBuilder(
      future: future,
      builder: (context, future) {
        if (future.hasData) {
          AulasDash aulasDash = future.data;
          return GestureDetector(
            onTap: onTap,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
              width: MediaQuery.of(context).size.width / 3 - 25,
              height: 80,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(7.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    aulasDash.descricao,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  Text(
                    aulasDash.qtd.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      height: 0.8,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  FutureBuilder onGetAulasIntrutorDash(BuildContext context) {
    return FutureBuilder(
      future: _repository.onGetAulasInstrutoresDash(),
      builder: (context, future) {
        if (loadGetAulasIntrutorDash) {
          loadGetAulasIntrutorDash = false;
          return const Center(child: CircularProgressIndicator());
        } else {
          loadGetAulasIntrutorDash = true;
          if (future.hasData) {
            List<AulasDash> lstAulasDash = future.data;
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Wrap(
                spacing: 15,
                runSpacing: 15,
                alignment: WrapAlignment.spaceEvenly,
                children: [
                  ...lstAulasDash.map(
                    (aulaDash) {
                      iCores++;
                      if (iCores > AppColors().bkgroundDash.length - 1) {
                        iCores = 0;
                      }

                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 15.0),
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        height: 80,
                        decoration: BoxDecoration(
                          color: AppColors().bkgroundDash[iCores],
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              aulaDash.descricao,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              aulaDash.qtd.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                height: 0.8,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }
      },
    );
  }
}

/*return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                width: MediaQuery.of(context).size.width / 2 - 25,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Color(0XFFFFB259),
                    borderRadius: BorderRadius.circular(7.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Affected",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      "336,851",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                width: MediaQuery.of(context).size.width / 2 - 25,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Color(0XFFFF5959),
                    borderRadius: BorderRadius.circular(7.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Death",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      "9,620",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                width: MediaQuery.of(context).size.width / 3 - 25,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Color(0XFF4CD97B),
                    borderRadius: BorderRadius.circular(7.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Recovered",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      "17,977",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                width: MediaQuery.of(context).size.width / 3 - 25,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Color(0XFF4DB5FF),
                    borderRadius: BorderRadius.circular(7.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Active",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      "301,251",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
                width: MediaQuery.of(context).size.width / 3 - 25,
                height: 100.0,
                decoration: BoxDecoration(
                    color: Color(0XFF9059FF),
                    borderRadius: BorderRadius.circular(7.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Serious",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    Text(
                      "8,702",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );*/

/*
Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Container(
                height: 80,
                width: MediaQuery.of(context).size.width / 3 - 25,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hoje",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      Text(
                        "3",
                        style: TextStyle(color: Colors.white, fontSize: 27),
                      ),
                    ]),
              )
            ],
          ),
        )
        */
