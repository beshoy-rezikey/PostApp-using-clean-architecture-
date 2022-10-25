import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
 Future <bool> get isConnected;
}
class NetworkINfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkINfoImpl(this.connectionChecker);
  @override
  // TODO: implement networkInfo
  Future<bool> get isConnected => connectionChecker.hasConnection;
  
}