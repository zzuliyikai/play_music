import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'recommend_logic.dart';

const String recommendName = "/recommend";

class RecommendPage extends StatelessWidget {
  const RecommendPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(RecommendLogic());

    return Container();
  }
}
