import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

class MetaMaskProvider extends ChangeNotifier {
  static const operatingChain = 4;
  String currentAddress = "";
  int currentChain = -1;
  bool get isEnabled => ethereum != null;
  bool get isInOperatingChain => currentChain == operatingChain;
  bool get isConnected => isEnabled && currentAddress.isNotEmpty;

  String getCurrentAddress() => currentAddress;

  start() {
    print("Running start method");
    if (isEnabled) {
      ethereum!.onAccountsChanged((accounts) {reset();});
      ethereum!.onChainChanged((accounts) {reset();});
    }
  }

  Future<void> connect() async {
    print("Running connect method");
    if (isEnabled) {
      final accs = await ethereum!.requestAccount();
      if (accs.isNotEmpty) {
        currentAddress = accs.first;
      }
      print("Connected address: ${currentAddress}");
      currentChain = await ethereum!.getChainId();
      notifyListeners();
    }
  }

  reset() {
    print("Resetting");
    currentAddress = '';
    currentChain = -1;
    notifyListeners();
  }

}