import 'package:ajiapp/services/e-sim_service/controller/e-sim_controller.dart';
import 'package:ajiapp/settings/size.dart';
import 'package:ajiapp/widgets/e-sim_widget.dart';
import 'package:ajiapp/widgets/myappbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EsimView extends StatelessWidget {
  const EsimView({super.key});

  @override
  Widget build(BuildContext context) {
    final E_simController controller = Get.put(E_simController());
    SizeConfig().init(context);
    return Scaffold(
        body: Container(
      width: ScreenSize.width,
      height: ScreenSize.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            MyappbarWidget(
              title: "E-Sim",
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.getBlockSizeHorizontal(5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select Data Plan",
                      style: TextStyle(
                        fontSize: SizeConfig.getBlockSizeHorizontal(7),
                        fontWeight: FontWeight.bold,
                      )),
                  Obx(
                    () {
                      return Column(
                        children: controller.E_sims.map((plan) {
                          return E_simWidget(
                            data: plan["data"],
                            durations: plan["durations"],
                            price: plan["price"],
                          );
                        }).toList(),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
