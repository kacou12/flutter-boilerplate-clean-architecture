abstract class NetworkConstants {
  const NetworkConstants();

  // static const baseUrl = 'http://127.0.0.1:3000/api/v1';
  static const baseUrl =
      "http://51.83.78.223:8080/merchant${NetworkConstants.apiUrl}";
  static const authority = '127.0.0.1:3000';
  static const apiUrl = '/api/v1';

  static const defaultDataCachedDuration = Duration(hours: 1);
  static const headers = {
    'Accept': 'application/json',
    // 'Access-Control-Allow-Origin': '*',
    'Content-Type': 'application/json',
  };
  static const pageSize = 10;
}
