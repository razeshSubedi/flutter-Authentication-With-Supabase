import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_supabase/main.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<SignUpButtonClickedEvent>((event, emit) async {
      try {
        emit(AuthLoadingState());
        print("checking");
        final check = await supabase
            .from('profiles')
            .select('userId')
            .eq('email', event.email).maybeSingle();
            
        print('checked');

        if (check != null) {
          print("emailexists");
          emit(SignUpFailureState(faliureMessage: "The email already exists!"));
        } else {
          print("email doesnotexits");
          final response = await supabase.auth
              .signUp(email: event.email, password: event.password);
          print("user created");

          final userId = response.user!.id;

          if (response.user != null) {
            await supabase.from("profiles").upsert({
              'userId': userId,
              'name': event.userName,
              "email": event.email,
              "phonenumber": event.phoneNumber,
            });
            final nameOfUser = await supabase
                .from('profiles')
                .select('name')
                .eq('userId', userId);

            emit(SignUpSucessState(name: nameOfUser.toString()));
            
          }
        }
      } catch (error) {
        emit(SignUpFailureState(
            faliureMessage: error.toString()));
      }
    });

    on<AuthInitialEvent>(
      (event, emit) {
        emit(AuthInitialState());
      },
    );
  }
}
