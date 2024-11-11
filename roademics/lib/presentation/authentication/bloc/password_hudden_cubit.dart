import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordHiddenCubit extends Cubit<bool> {
  PasswordHiddenCubit() : super(true);

  void togglePasswordVisibility() {
    emit(!state);
  }
}
