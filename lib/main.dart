import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:yazlab_1_1/service/hive.dart';
import 'package:hive/hive.dart';
import 'package:yazlab_1_1/service/hive_model.dart';

import 'dart:convert';

import 'Model/pc_info_model.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yazlab 1',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Web Scraping'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var baseUrl = Uri.parse("https://www.trendyol.com/laptop-x-c103108");
  List<Bilgisayarin> pcinfo = [];

  Future getData() async {
    var itembox = await Hive.openBox("itembox");
    int i = 0;
    List links = await getUrls();
    for (var url in links) {
      i++;
      print(url);
      var parseUrl = Uri.parse(url);
      var response = await http.get(parseUrl);
      final body = response.body;
      final doc = parser.parse(body);

      pcinfo.add(Bilgisayarin(
        marka: doc
            .getElementsByClassName("pr-new-br")[0]
            .children[0]
            .text
            .toString(),
        ismi: doc
            .getElementsByClassName("pr-new-br")[0]
            .children[1]
            .text
            .toString(),
        fiyati: doc
            .getElementsByClassName("pr-bx-nm with-org-prc")[0]
            .children[0]
            .text
            .toString(),
        islemciTipi: await getSpesificData(url, 0),
        ssdKapasitesi: await getSpesificData(url, 1),
        isletimSistemi: await getSpesificData(url, 2),
        ekranKarti: await getSpesificData(url, 3),
        ram: await getSpesificData(url, 4),
        cozunurluk: await getSpesificData(url, 5),
        ekranBoyutu: await getSpesificData(url, 6),
        linki: url,
      ));

      if (i == 2) {
        break;
      }
    }
    //var json = jsonEncode(pcinfo.map((e) => e.toJson()).toList());
    var json = jsonEncode(pcinfo.map((e) => e.toJsonAttr()).toList());
    //await itembox.addAll(json);
    print(json);

    setState(() {});
  }

  Future<String> getSpesificData(String thisUrl, int indexx) async {
    var url = Uri.parse(thisUrl);
    late String value;
    var response = await http.get(url);
    final body = response.body;
    final doc = parser.parse(body);
    doc
        .getElementsByClassName("detail-attr-container")[0]
        .getElementsByClassName("detail-attr-item")
        .forEach((element) {
      if (element.children[0].text.toString() == 'İşlemci Tipi' &&
          indexx == 0) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'SSD Kapasitesi' &&
          indexx == 1) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'İşletim Sistemi' &&
          indexx == 2) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'Ekran Kartı' &&
          indexx == 3) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() ==
              'Ram (Sistem Belleği)' &&
          indexx == 4) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'Çözünürlük' &&
          indexx == 5) {
        value = element.children[1].text.toString();
      } else if (element.children[0].text.toString() == 'Ekran Boyutu' &&
          indexx == 6) {
        value = element.children[1].text.toString();
      }
    });
    return value;
  }

  Future getUrls() async {
    List urls = [];
    var response = await http.get(baseUrl);
    final body = response.body;
    final doc = parser.parse(body);
    doc
        .getElementsByClassName("prdct-cntnr-wrppr")[0]
        .getElementsByClassName("p-card-wrppr with-campaign-view")
        .forEach((element) {
      urls.add(
          "https://www.trendyol.com/${element.children[0].children[0].attributes['href']}");
    });
    return urls;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title), centerTitle: true),
      body: pcinfo.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: pcinfo.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white38,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  child: ListTile(
                      leading: const Icon(Icons.computer_rounded),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pcinfo[index].ismi,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            "Fiyatı: ${pcinfo[index].fiyati}",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            "Spesifik Özellikler",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            pcinfo[index].cozunurluk,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            pcinfo[index].ekranBoyutu,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            pcinfo[index].ekranKarti,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            pcinfo[index].islemciTipi,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            pcinfo[index].isletimSistemi,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            pcinfo[index].ram,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),
                          Text(
                            pcinfo[index].ssdKapasitesi,
                            style: Theme.of(context).textTheme.subtitle2,
                          ),

                          //Text(pcinfo[index].,style: Theme.of(context).textTheme.subtitle1,),
                        ],
                      )),
                );
              },
            ),
    );
  }
}
