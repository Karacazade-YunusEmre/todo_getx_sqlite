import '../../model/abstract/i_model.dart';
import '../../result/abstract/i_data_result.dart';
import '../../result/abstract/i_result.dart';

abstract class IRepository<T extends IModel> {
  Future<IDataResult<T>> add(T item);

  Future<IResult> delete(T item);

  Future<IDataResult<List<T>?>> getAll();

  Future<IResult> update(T item);
}
