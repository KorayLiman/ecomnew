import 'package:ecomappkoray/blocs/bloc/auth_bloc.dart';
import 'package:ecomappkoray/pages/Dashboard.dart';
import 'package:ecomappkoray/repositories/firestorerepo.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardLogin extends StatelessWidget {
  DashboardLogin({Key? key,required this.firebaseRepository}) : super(key: key);
  TextEditingController _EmailController = TextEditingController();
  TextEditingController _PasswordController = TextEditingController();
  FirebaseRepository firebaseRepository;

  String? Email;
  String? Password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Dashboard(firebaseRepository: firebaseRepository,)));
        }
        if (state is AuthError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is UnAuthenticated) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxHeight > 600 && constraints.maxWidth > 800) {
                  return LoginForm(context);
                }
                return Container();
              },
            );
          }
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container();
        },
      ),
    ));
  }

  Widget LoginForm(BuildContext context) {
    return Stack(
      children: [
        Container(),
        Center(
          child: Form(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text(
                "YÖNETİM PANELİ",
                style: TextStyle(fontSize: 36),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                child: TextFormField(
                  controller: _EmailController,
                  keyboardType: TextInputType.emailAddress,
                  expands: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (!EmailValidator.validate(value!)) {
                      return "Geçersiz Email";
                    }
                  },
                  onChanged: (value) {
                    Email = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 300,
                child: TextFormField(
                  onChanged: (value) {
                    Password = value;
                  },
                  controller: _PasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.length < 6) {
                      return "Şifre 6 haneden küçük olamaz";
                    }
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: "Şifre",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                      contentPadding: const EdgeInsets.all(5)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    _EmailController.clear();
                    _PasswordController.clear();
                    if (Email != null &&
                        Password != null &&
                        EmailValidator.validate(Email!)) {
                      BlocProvider.of<AuthBloc>(context).add(
                          SignInRequested(email: Email!, password: Password!));
                    }
                  },
                  child: const Text("Giriş yap"),
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(120, 50)))),
            ]),
          ),
        )
      ],
    );
  }
}
