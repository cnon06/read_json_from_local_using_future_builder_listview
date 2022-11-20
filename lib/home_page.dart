

import 'package:flutter/material.dart';

import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Car>> _lastCarList;

  @override
  void initState() {
    super.initState();

    _lastCarList = carsJsonRead();
  }

  @override
  Widget build(BuildContext context) {
    carsJsonRead();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material App Bar'),
      ),
     
      body: Center(
          child: FutureBuilder(
            // initialData: [
            //   Car(brand: "brand", country: "country", foundationYear: 1900, models: [] ),
            // ],
        future: _lastCarList,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            List<Car> dataList = snapshot.data;
            return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (contex, index) {
                  return ExpansionTile(
                    title: Text(dataList[index].brand),
                    subtitle: Text(dataList[index].country),
                    initiallyExpanded: false,
                    children: dataList[index]
                        .models
                        .map((e) => ListTile(
                              leading: Text(
                                "Price: \$${e.price}",
                              ),
                              title: Text(e.modelName),
                              subtitle:
                                  Text("Is It Automatic?: ${e.isAutomatic}"),
                            ))
                        .toList(),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }

  Future<List<Car>> carsJsonRead() async {
    try {
      debugPrint("carsJsonRead");
      await Future.delayed(const Duration(milliseconds: 1500));
      // ignore: use_build_context_synchronously
      final data = await DefaultAssetBundle.of(context)
          .loadString("assets/data/cars.json");


      List<Car> liste = carFromJson(data);

      return liste;
    } catch (e) {
      return Future.error(e);
    }
  }
}
