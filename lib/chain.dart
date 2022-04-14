import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:leftnix/contracts/subscription.g.dart';
import 'package:leftnix/secrets.dart';
import 'package:web3dart/web3dart.dart';

import 'model.dart';

class Session extends GetxService {
  final apiUrl = "http://localhost:8545";
  final Client httpClient = Client();

  late Web3Client ethClient;
  late Subscription contract;
  late EthereumAddress address;
  Profile? profile;

  EthPrivateKey credentials = EthPrivateKey.fromHex(privateKey);

  Future<Session> init() async {
    ethClient = Web3Client(apiUrl, httpClient);
    address = await credentials.extractAddress();
    print(address.hex);
    contract = Subscription(
        address: EthereumAddress.fromHex(contractAddress), client: ethClient);
    return this;
  }

  Future<double> getBalance() async {
    // You can now call rpc methods. This one will query the amount of Ether you own
    EtherAmount balance = await ethClient.getBalance(credentials.address);
    double amount = balance.getValueInUnit(EtherUnit.ether);
    print(amount);
    return amount;
  }

  Future<bool> login(String key) async {
    credentials = EthPrivateKey.fromHex(key);
    try {
      final resp = await contract.getSubscriberInfo(address);
      print(resp);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(String key, String username) async {
    credentials = EthPrivateKey.fromHex(key);
    try {
      final resp = await contract.register(credentials.address, username,
          credentials: credentials);
      print(resp);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void send() async {
    final resp = await ethClient.sendTransaction(
      credentials,
      Transaction(
        to: EthereumAddress.fromHex(
            '0xC6a502fA18bF4234cE353771E73BBEA241BcE18d'),
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1),
      ),
    );
    return;
  }

  void subscribe(DateTime newDate) async {
    final resp = await contract.subscribe(BigInt.one, newDate.toIso8601String(),
        credentials: credentials,
        transaction: Transaction(value: EtherAmount.inWei(BigInt.one)));
    print(resp);
    return;
    // final resp = await contract.deposit(BigInt.one,
    //     credentials: credentials,
    //     transaction: Transaction(value: EtherAmount.inWei(BigInt.one)));
    // print(resp);
    // return;
  }

  void getInfo() async {
    final resp = await contract.getSubscriberInfo(address);
    return;
  }
}
