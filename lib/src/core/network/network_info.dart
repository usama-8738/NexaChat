import "package:connectivity_plus/connectivity_plus.dart";

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Stream<List<ConnectivityResult>> get onStatusChange;
}

class ConnectivityNetworkInfo implements NetworkInfo {
  ConnectivityNetworkInfo(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    if (results.isEmpty) return false;
    return results.any((status) => status != ConnectivityResult.none);
  }

  @override
  Stream<List<ConnectivityResult>> get onStatusChange => _connectivity.onConnectivityChanged;
}
