import 'package:flutter/material.dart';
import "package:investec_pools/Pool.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:investec_pools/PoolPage.dart';

void main() async {
  var links = [
    Uri.parse("https://ipfs.io/ipfs/QmeKppUZsPWvgoJJAwC4RXqMRDyFKAhN79CPdsraf8ugnq"),
    Uri.parse("https://ipfs.io/ipfs/QmZ8Heqn9iHd5fKZzt8ZpV4yvtg1Ph4QNaUNhBUiUasx4P"),
    Uri.parse("https://ipfs.io/ipfs/QmeKppUZsPWvgoJJAwC4RXqMRDyFKAhN79CPdsraf8ugnq"),
    Uri.parse("https://ipfs.io/ipfs/QmZ8Heqn9iHd5fKZzt8ZpV4yvtg1Ph4QNaUNhBUiUasx4P"),
    Uri.parse("https://ipfs.io/ipfs/QmeKppUZsPWvgoJJAwC4RXqMRDyFKAhN79CPdsraf8ugnq")
  ];

  var pools = await Pool.getPools(links);

  runApp(MaterialApp(
    home: DashboardPage(pools),
    theme: new ThemeData(
      scaffoldBackgroundColor: const Color(0x0B1742),
      backgroundColor: const Color(0x0B1742),
    ),
  ));
}

class DashboardPage extends StatelessWidget {
  var pools = <Pool>[];
  DashboardPage(this.pools);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(50),
          child: Container(
            width: 1000,
            child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 8.0,
                children: List.generate(pools.length, (index) {
                  var pool = pools[index];
                  return Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PoolPage(pool)),
                        );
                      },
                      child: Center(
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40), // if you need this
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Expanded(
                                      child: Column(
                                        children: [
                                          Expanded(flex: 2, child: Container(),),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              pool.name,
                                              style: GoogleFonts.chivo(
                                                textStyle: TextStyle(
                                                    fontSize: 30,
                                                  )
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.bottomCenter,
                                    margin: EdgeInsets.only(right: 10, left: 10, bottom: 30),
                                    child: Text(
                                        pool.desc,
                                      style: GoogleFonts.chivo(),
                                    ),
                                  )

                                ],
                              )
                          ),
                        ),
                      ),
                    ),
                  );

                  return Center(
                    child: ListTile(
                      title: Text(pool.name),
                      subtitle: Text(pool.desc),
                    ),
                  );
                }),
            ),
          ),
        ),
      ),
    );
  }

}