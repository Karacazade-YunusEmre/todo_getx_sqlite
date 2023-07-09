import '../abstract/i_data_result.dart';

class ErrorDataResult<T> implements IDataResult<T> {
  @override
  T? data;

  @override
  String? message;

  @override
  bool success = false;

  ErrorDataResult({this.data, this.message});

  ErrorDataResult.onlyMessage({this.message});
}
