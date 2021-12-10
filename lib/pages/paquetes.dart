import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:local_storage/models/recarga.dart';
import 'package:local_storage/providers/recargas_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaquetesPage extends StatefulWidget {
  PaquetesPage({Key? key}) : super(key: key);

  @override
  _PaquetesPageState createState() => _PaquetesPageState();
}

class _PaquetesPageState extends State<PaquetesPage> {
  bool ready = false;

  late Map<String, List<Recarga>> recargas;

  String current = 'ilimitados';

  Recarga? seleccionado;

  // metodos
  @override
  void initState() {
    super.initState();
    cargarRecargas();
  }

  void cargarRecargas() async {
    recargas = await recargasProvider.cargarData();
    setState(() {
      ready = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: seleccionado != null
          ? Center(
              child: item(recarga: seleccionado, close: true),
            )
          : NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxisScolled) => [
                SliverAppBar(
                  elevation: 25,
                  backgroundColor: Theme.of(context).bottomAppBarColor,
                  title: Text(
                    "Paquetes",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ready
                          ? Row(
                              children: [
                                Wrap(
                                  spacing: 4.0,
                                  children: List.generate(
                                    recargas.length,
                                    (i) => ChoiceChip(
                                      label: Text(recargas.keys.elementAt(i)),
                                      selected:
                                          current == recargas.keys.elementAt(i),
                                      onSelected: (seleted) {
                                        setState(() {
                                          current = recargas.keys.elementAt(i);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const Text("data"),
                    ),
                  ),
                )
              ],
              body:
                  ready ? _lista(recargas) : const CircularProgressIndicator(),
            ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 15),
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            width: MediaQuery.of(context).size.width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  height: 50,
                  child: const TextField(
                    maxLength: 8,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Escriba algo...",
                        border: InputBorder.none,
                        counterText: ""),
                  ),
                ),
                IconButton(
                  splashRadius: 30,
                  onPressed: () {},
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            heroTag: "send",
            mini: true,
            onPressed: enviar,
            child: Icon(
              Icons.send,
              size: 20,
            ),
          )
        ],
      ),
    );
  }

  Widget _lista(Map<String, List<Recarga>> items) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: items[current]!.length,
              itemBuilder: (context, i) {
                return item(recarga: items[current]![i]);
              }),
        ],
      ),
    );
  }

  Widget item({Recarga? recarga, bool close = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          seleccionado = recarga;
        });
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recarga!.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  Visibility(
                    visible: close,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            seleccionado = null;
                          });
                        },
                        icon: const Icon(Icons.close)),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Flexible(
                      child: Text(
                    recarga.description,
                    style: TextStyle(color: Colors.grey),
                  )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    recarga.duracion,
                    style: const TextStyle(color: Colors.blue),
                  ),
                  Text("Lps. ${recarga.price}",
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void enviar() async {
    final input = TextEditingController();
    final pref = await SharedPreferences.getInstance();
    String? pin = pref.getString('pin');
    if (pin == null) {
      final res = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text("Ingrese su pin"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                      "El pin no se le volvera a solicitar se guardara en el dispositivo"),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: input,
                    decoration: InputDecoration(hintText: "Pin"),
                  )
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cancelar")),
                TextButton(
                    onPressed: () {
                      pref.setString('pin', input.text);
                      pin = input.text;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Guardar")),
              ],
            );
          });
    }
    bool? res = await FlutterPhoneDirectCaller.callNumber(
        "*444*${seleccionado!.cod}*$pin#");
  }
}
