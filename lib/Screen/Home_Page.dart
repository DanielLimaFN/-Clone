import 'package:flutter/material.dart';
import 'package:movies/Core/CoreApp.dart';
import '../Core/ApiPopular.dart';
import '../Models/Models_Popular.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String endpoint = 'https://image.tmdb.org/t/p/original/';

  Api? api;
  List? l = [];

  @override
  void initState() {
    api = Api();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _GuiaAtiva = 0;

  bool ativa(recebe) {
    if (_GuiaAtiva == recebe) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    double Altura = MediaQuery.of(context).size.height;
    double Largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: verificarTema() ? FundoDark : FundoLight,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                child: Image.asset(
                  'assets/icons/logoBranco.png',
                  height: Altura * 0.05,
                ),
              ),
            ),
            SizedBox(
              height: Altura * 0.04,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _GuiaAtiva = 0;
                        });
                      },
                      child: Text('Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: ativa(0) ? 3 : 0,
                            color:
                                ativa(0) ? Colors.white : Colors.transparent),
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _GuiaAtiva = 1;
                        });
                      },
                      child: Text('Series',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: ativa(1) ? 3 : 0,
                            color:
                                ativa(1) ? Colors.white : Colors.transparent),
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _GuiaAtiva = 2;
                        });
                      },
                      child: Text('Filmes',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: ativa(2) ? 3 : 0,
                            color:
                                ativa(2) ? Colors.white : Colors.transparent),
                      ),
                    ),
                  ),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _GuiaAtiva = 3;
                        });
                      },
                      child: Text('Originais',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: ativa(3) ? 3 : 0,
                            color:
                                ativa(3) ? Colors.white : Colors.transparent),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            FutureBuilder(
                future: api!.getAllPopular(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PopularModel>?> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('erro'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<PopularModel>? movies = snapshot.data;
                      print(movies?.length);
                      PopularModel popular = movies![0];
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          '${this.endpoint}${popular.backdrop_path}',
                          height: Altura * 0.3,
                        ),
                      );
                    } else {
                      return Text('erro');
                    }
                  }
                }),
            Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text('Em Alta',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'BeVietnamPro',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(
                future: api!.getAllPopular(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PopularModel>?> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('erro'),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<PopularModel>? movies = snapshot.data;
                      return Container(
                        width: double.infinity,
                        height: Altura * 0.3,
                        child: GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this produces 2 rows.
                          crossAxisCount: 1,
                          scrollDirection: Axis.horizontal,
                          // Generate 100 widgets that display their index in the List.
                          children: List.generate(20, (index) {
                            PopularModel popular = movies![index];
                            return Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 5,
                              semanticContainer: true,
                              margin: EdgeInsets.all(10),
                              child: Image.network(
                                  '${this.endpoint}${popular.poster_path}',
                                  fit: BoxFit.fill),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            );
                          }),
                        ),
                      );
                    } else {
                      return Text('erro');
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }
}
