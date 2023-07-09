import '../abstract/i_result.dart';

class SuccessResult implements IResult {
  @override
  String? message;

  @override
  bool success = true;

  SuccessResult({this.message});
}
