import '../../model/abstract/i_model.dart';
import '../../result/abstract/i_data_result.dart';
import '../../result/abstract/i_result.dart';

abstract class IStorageService<T extends IModel> {
  Future<IResult> add(T model);

  Future<IResult> delete(T model);

  Future<IDataResult<List<T>?>> getAll();

  Future<IResult> update(T model);
}
