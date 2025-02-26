import 'package:flutter/material.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  List<String> tarefas = ["Pagar contas", "Comprar roupas"];

  String novatarefa = "";

  void addtarefa() {
    if (novatarefa != "") {
      setState(() {
        tarefas.add(novatarefa);
      });
    }
  }

  void removertarefa(String tarefa) {
    setState(() {
      tarefas.remove(tarefa);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        backgroundColor: const Color.fromARGB(255, 158, 194, 255),
        title: Text(
          "Tarefas Page",
          style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            ...tarefas.map(
              (tarefa) => GestureDetector(
                onTap: () {
                  removertarefa(tarefa);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(tarefa),
                  ),
                ),
              ),
            ), //arrow function se assemelha ao looping, foi cortado o card e colado aqui dentro e mudamos o text
          ],
        ),
      ),

      bottomNavigationBar: Container(
        height: 60,
        color: Colors.deepPurple,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 400,
                child: TextFormField(
                  onChanged: (valor) {
                    novatarefa = valor;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  addtarefa();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(Icons.heart_broken),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(500),
                      bottomRight: Radius.circular(500),
                      topLeft: Radius.circular(500),
                      topRight: Radius.circular(500),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
