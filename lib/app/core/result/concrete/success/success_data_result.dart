import '../../abstract/i_data_result.dart';

class SuccessDataResult<T> implements IDataResult<T> {
  @override
  T? data;

  @override
  String? message;

  @override
  bool success = true;

  SuccessDataResult({this.data, this.message});
}
