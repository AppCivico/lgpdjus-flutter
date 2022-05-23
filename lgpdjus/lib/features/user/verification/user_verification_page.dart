import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';

class AccountVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(title: 'Validar conta'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/svg/registration/done.svg'),
              Text(
                'Seu cadastro foi realizado com sucesso!',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Para utilizar todas as funções do aplicativo LGPDjus você precisa verficar sua identidade. Para isso, será necessário enviar uma foto do seu documento e também, uma selfie sua segurando o documento.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Quando quiser, clique em continuar para realizar verificação.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  AppNavigator.pushAndRemoveUntil('/account/verify', '/');
                },
                child: Text('Continuar'),
              ),
              TextButton(
                onPressed: () {
                  AppNavigator.popAuthentication();
                },
                child: Text('Fazer mais tarde'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
