import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medic_meditation_app/utils/consts/image_consts.dart';
    
class MedicAppbar extends StatelessWidget implements PreferredSizeWidget{

  const MedicAppbar({ Key? key }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SvgPicture.asset(ImageConsts.HAMBURGER),
        Image.asset(ImageConsts.SMALL_LOGO),
        const CircleAvatar(backgroundColor: Colors.amber,
        backgroundImage: AssetImage(ImageConsts.AVATAR),),
      ],
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}