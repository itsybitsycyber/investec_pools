
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:investec_pools/Pool.dart';
import 'package:investec_pools/metamask_provider.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;

class PoolPage extends StatelessWidget {
  final Pool pool;

  PoolPage(this.pool);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ChangeNotifierProvider(
          create: (context) => MetaMaskProvider()..start(),
          builder: (context, child) {
            return Container(
              margin: const EdgeInsets.all(50),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      alignment: Alignment.center,
                      child: Text(
                        pool.name,
                        style: GoogleFonts.chivo(
                            textStyle: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(50),
                      height: 200,
                      // width: 400,
                      // color: Colors.blue,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'investec.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                      // decoration: BoxDecoration (
                      //   image: DecorationImage(
                      //     image: Image.network("https://play.google.com/store/apps/developer?id=Investec&hl=en_US&gl=US").image,
                      // )),
                    ),
                    Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        "Target: R ${pool.goal}",
                        style: GoogleFonts.chivo(
                            textStyle: const TextStyle(
                                fontSize: 30
                            )
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      child: Text(
                        "Invested: R ${pool.goal}",
                        style: GoogleFonts.chivo(
                            textStyle: const TextStyle(
                                fontSize: 30
                            )
                        ),
                      ),
                    ),
                    Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0),
                                topLeft: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)),
                            border: Border.all(
                                color: Colors.grey,
                                width: 1
                            )
                        ),
                        child: Container(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              pool.desc,
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            )
                        )
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Text(
                          "Additional links:"
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Row(
                        children: [
                          IconButton(onPressed: () {
                            html.window.open('https://stackoverflow.com/questions/ask', 'new tab');
                          }, icon: Icon(Icons.public))
                        ],
                      ),
                    ),
                    Container(
                      height: 50,
                      // width: double.infinity,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: 300,
                            child: Card(
                              child: Center(
                                child: Text(
                                    "Deployed date: ${pool.deployDate
                                        .day}-${pool.deployDate.month}-${pool
                                        .deployDate.year}"
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 300,
                            child: Card(
                              child: Center(child: Text(
                                  "Investing closing date: ${pool.investClose
                                      .day}-${pool.investClose.month}-${pool
                                      .investClose.year}")),
                            ),
                          ),
                          Container(
                            width: 300,
                            child: Card(
                              child: Center(child: Text(
                                  "Claimable date: ${pool.claimOpen.day}-${pool
                                      .claimOpen.month}-${pool.claimOpen
                                      .year}")),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Consumer<MetaMaskProvider>(
                          builder: (context, provider, child) {
                            if (DateTime.now().isBefore(pool.investClose)) {
                              return ElevatedButton(
                                child: const Text(
                                    "Invest now",
                                    style: TextStyle(
                                      fontSize: 30,
                                    )
                                ),
                                onPressed: () {
                                    context.read<MetaMaskProvider>().connect();
                                  //TODO: Sign and recieve trainaction details
                                },
                              );
                            } else if (DateTime.now().isBefore(pool.claimOpen)) {
                              return const Text(
                                        "In process",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                        ),
                                      );
                            } else {
                              return ElevatedButton(
                                      child: const Text(
                                        "Claim investment",
                                        style: TextStyle(
                                          fontSize: 30
                                        ),
                                      ),
                                      onPressed: () {
                                          context.read<MetaMaskProvider>()
                                              .connect();
                                        //TODO Make server API call to claim an investment
                                      },
                                    );
                            }
                          }
                      ),
                    ),

                    // child: (DateTime.now().isBefore(pool.investClose))?
                    //     : (DateTime.now().isBefore(pool.claimOpen))?
                    //     const Text(
                    //       "In process",
                    //       style: TextStyle(
                    //         fontWeight: FontWeight.bold,
                    //         fontSize: 15,
                    //       ),
                    //     ) :
                    //
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}