import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parky/core/helpers/cache_helper.dart';
import 'package:parky/features/auth/data/models/token_model.dart';
import 'package:parky/features/auth/data/repository/auth_repository.dart';

import '../../data/models/login_model.dart';
import '../../data/models/register_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);

  final AuthRepository _authRepository = AuthRepository();
  TokenModel? tokenModel;
  RegisterModel registerForm = RegisterModel();
  // login
  Future<void> login() async {
    emit(LoginLoading());
    final loginModel = LoginModel(
      email: registerForm.emailController.text,
      password: registerForm.passwordController.text,
    );
    final result = await _authRepository.login(loginModel);
    result.fold((failure) => emit(LoginError(failure.message)), (token) async {
      tokenModel = token;
      await CacheHelper.set(key: 'token', value: token.accessToken);
      await CacheHelper.set(key: 'email', value: loginModel.email);
      emit(LoginSuccess());
    });
  }

  // register
  Future<void> register() async {
    emit(RegisterLoading());
    final result = await _authRepository.register();
    result.fold(
      (failure) => emit(RegisterError(failure.message)),
      (empty) => emit(RegisterSuccess()),
    );
  }
}
