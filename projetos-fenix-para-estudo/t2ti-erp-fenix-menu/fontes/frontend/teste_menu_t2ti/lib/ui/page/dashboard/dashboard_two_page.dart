import 'package:flutter/material.dart';
import 'package:flutter_uikit/ui/page/dashboard/dashboard_two/dashboard_menu_row_two.dart';
import 'package:flutter_uikit/ui/widgets/common_scaffold.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardTwoPage extends StatelessWidget {
  Widget bodyData() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Vendas - Opções",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              DashboardMenuRowTwo(
                firstIcon: FontAwesomeIcons.bars,
                firstLabel: "Tipo NF",
                secondIcon: FontAwesomeIcons.dollarSign,
                secondLabel: "Condições Pagamento",
                thirdIcon: FontAwesomeIcons.clone,
                thirdLabel: "Orçamentos",
              ),
              DashboardMenuRowTwo(
                firstIcon: Icons.money_off,
                firstLabel: "Venda",
                secondIcon: FontAwesomeIcons.truck,
                secondLabel: "Frete",
                thirdIcon: FontAwesomeIcons.truckMoving,
                thirdLabel: "Romaneio",
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Pendências",
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
                ),
              ),
              DashboardMenuRowTwo(
                firstIcon: FontAwesomeIcons.film,
                firstLabel: "Emissão de Notas",
                secondIcon: FontAwesomeIcons.calendarAlt,
                secondLabel: "Pedidos em Aberto",
                thirdIcon: FontAwesomeIcons.mobile,
                thirdLabel: "Força de Vendas",
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      appTitle: "Vendas",
      showFAB: false,
      bodyData: bodyData(),
    );
  }
}
