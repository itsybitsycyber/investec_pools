import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
import 'package:provider/provider.dart';
import 'metamask_provider.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Web3Home();
}


class Web3Home extends StatelessWidget {
  const Web3Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: ChangeNotifierProvider(
          create: (context) => MetaMaskProvider()..start(),
          builder: (context, child) {
            return Container(
              child:
              Center(
                child: Consumer<MetaMaskProvider>(
                  builder: (context, provider, child) {
                    late final String message;
                    if (provider.isConnected) {
                      message = 'Connected with address: ${provider.currentAddress}';
                    } else if (provider.isConnected) {
                      message =
                      'Wrong chain. Please connect to ${MetaMaskProvider.operatingChain}';
                    } else if (provider.isEnabled) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          MaterialButton(
                            onPressed: () {
                                context.read<MetaMaskProvider>().connect();
                            },
                            color: Colors.white,
                            padding: const EdgeInsets.all(0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network(
                                  'https://i0.wp.com/kindalame.com/wp-content/uploads/2021/05/metamask-fox-wordmark-horizontal.png?fit=1549%2C480&ssl=1',
                                  width: 250,
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      message = 'Please use a Web3 supported browser.';
                    }
                    return Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
            );
          }),
    );
  }
}