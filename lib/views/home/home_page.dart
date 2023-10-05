// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:controle_alunos_musica_ft/views/home/alunos_dash_tab.dart';
import 'package:controle_alunos_musica_ft/views/home/aulas_dash_tab.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final void Function()? setAulaFiltroHoje;
  final void Function()? setAulaFiltroMes;
  final void Function()? setAulaFiltroAno;

  const HomePage({
    super.key,
    this.setAulaFiltroHoje,
    this.setAulaFiltroMes,
    this.setAulaFiltroAno,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    if (pageController.hasClients) pageController.jumpToPage(currentPage);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Controle Alunos"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Aulas",
                    style: TextStyle(
                        color:
                            currentPage == 0 ? Colors.black : Colors.grey[400],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentPage = 0;
                  });
                },
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Alunos",
                    style: TextStyle(
                        color:
                            currentPage == 1 ? Colors.black : Colors.grey[400],
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                onTap: () {
                  setState(() {
                    currentPage = 1;
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              //physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },
              children: [
                AulasDashTab(
                  setAulaFiltroHoje: widget.setAulaFiltroHoje,
                  setAulaFiltroMes: widget.setAulaFiltroMes,
                  setAulaFiltroAno: widget.setAulaFiltroAno,
                ),
                AlunosDashTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
