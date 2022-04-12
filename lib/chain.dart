import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Network extends GetxService {
  final apiUrl = "http://localhost:8545";

  final Client httpClient = Client();
  late Web3Client ethClient;

  var credentials =
      EthPrivateKey.fromHex("0x63F4676973CfD2f77b80711856544889E6809aED");

  Future<Network> init() async {
    ethClient = Web3Client(apiUrl, httpClient);
    return this;
  }

  Future<double> getBalance() async {
    // You can now call rpc methods. This one will query the amount of Ether you own
    EtherAmount balance = await ethClient.getBalance(credentials.address);
    double amount = balance.getValueInUnit(EtherUnit.ether);
    return amount;
  }
}
