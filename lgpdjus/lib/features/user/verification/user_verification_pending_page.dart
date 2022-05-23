import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lgpdjus/app/shared/navigation/navigator.dart';
import 'package:lgpdjus/app/shared/widgets/appbar/appbar.dart';

class AccountPendingVerificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemedAppBar(title: 'Validar conta'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/svg/registration/done.svg'),
              Text(
                'Aguarde a verificação',
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Sua solicitação foi recebida e seu pedido será analisado em até 15 dias pelo TJSC.',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  AppNavigator.pop();
                },
                child: Text('Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
