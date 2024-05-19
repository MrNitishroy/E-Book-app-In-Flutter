import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryWidget extends StatelessWidget {
  final String iconPath;
  final String btnName;
  final VoidCallback ontap;
  const CategoryWidget(
      {super.key, required this.iconPath, required this.btnName, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: ontap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background),
          child: Row(
            children: [
              SvgPicture.asset(
                iconPath,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(btnName),
            ],
          ),
        ),
      ),
    );
  }
}
