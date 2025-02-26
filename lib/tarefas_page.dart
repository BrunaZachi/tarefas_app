import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TarefasPage extends StatefulWidget {
  const TarefasPage({super.key});

  @override
  State<TarefasPage> createState() => _TarefasPageState();
}

class _TarefasPageState extends State<TarefasPage> {
  late SharedPreferences prefs; //instancia do shared preference
  List<String> tarefas = ["Pagar contas", "Comprar roupas"];

  String novatarefa = "";
  //queremos salvar na memoria do dispositivo então colocamos prefs.set(e escolhemos qual vamos salvar)prefs.setStringList, onde colocamos a key e o value, onde value é a função da criação da lista
  void addtarefa() {
    if (novatarefa != "") {
      setState(() {
        tarefas.add(novatarefa);
      });
      prefs.setStringList("Tarefas", tarefas);
    }
  }

  void removertarefa(String tarefa) {
    setState(() {
      tarefas.remove(tarefa);
      prefs.setStringList("Tarefas", tarefas);
    });
  }

  @override //começa escrevendo o initstate que ele faz todo o codigo nescessario(o codigo abaixo), set state é passar um valor, o init é atribuir um valor
  void initState() {
    super.initState();
    carregartarefas();
  }

  Future<void> carregartarefas() async {
    prefs =
        await SharedPreferences.getInstance(); //await significa esperar que a variavel receba um valor antes de avançar, ele está vermelho pois precissamos dizer que ela é assincroma, só clicar nela e colocar async
    //??[] caso seja nula a lista passa um alista vazia para tarefas
    setState(() {
      tarefas = prefs.getStringList("Tarefas") ?? [];
    }); //para mudar o valor de uma variavel o set tem que ser chamado
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
