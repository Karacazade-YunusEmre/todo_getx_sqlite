import 'i_result.dart';

abstract class IDataResult<T> implements IResult {
  T? data;

  IDataResult({this.data});
}
