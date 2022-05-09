import 'package:bloc/bloc.dart';
import 'package:ecomappkoray/repositories/authrepo.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<AuthEvent>((event, emit) async {
      if (event is SignInRequested) {
        emit(Loading());
        try {
          
          await authRepository.SignIn(
              Email: event.email, Password: event.password);
          emit(Authenticated());
        } catch (error) {
          emit(AuthError(error: error.toString()));
          emit(UnAuthenticated());
        }
      } else if (event is SignUpRequested) {
        emit(Loading());
        try {
          await authRepository.SignUp(
              Email: event.email, Password: event.password);
          emit(Authenticated());
        } catch (error) {
          emit(AuthError(error: error.toString()));
          emit(UnAuthenticated());
        }
      } else if (event is SignOutRequested) {
        emit(Loading());
        await authRepository.SignOut();
        emit(UnAuthenticated());
      }
    });
  }
}
