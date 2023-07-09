import '../../model/concrete/view_model/register_view_model.dart';
import '../../model/concrete/view_model/sign_in_view_model.dart';
import '../../result/abstract/i_data_result.dart';
import '../../result/abstract/i_result.dart';

abstract class IAuthService<T> {
  Future<IDataResult<T>> register({required RegisterViewModel model});

  Future<IDataResult<T>> signIn({required SignInViewModel model});

  Future<IResult> signOut();
}
