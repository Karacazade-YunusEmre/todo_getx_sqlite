import '../../abstract/i_result.dart';

class ErrorResult implements IResult {
  @override
  String? message;

  @override
  bool success = false;

  ErrorResult({this.message});
}
