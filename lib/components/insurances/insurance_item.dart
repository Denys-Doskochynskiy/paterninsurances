import 'package:flutter/material.dart';
import 'package:paterninsurances/api/insurance/insurance_model.dart';

class InsuranceItem extends StatelessWidget {
  final InsuranceModel data;

  const InsuranceItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Title: ${data.title}",
                  style: const TextStyle(fontSize: 20),
                ),
                Text(
                  "Condition: ${data.condition}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Country: ${data.country}",
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  "Price: ${data.price}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ],
        ));
  }
}
