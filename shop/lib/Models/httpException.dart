class HttpException implements Exception{
  final String msg;
  HttpException(this.msg);
  String toString(){
    return msg;
  }
}