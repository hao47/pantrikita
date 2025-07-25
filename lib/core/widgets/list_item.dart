import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/api/api.dart';
import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../feature/home/domain/entities/home.dart';
import '../../feature/pantry_detail/presentation/pages/pantry_detail_page.dart';
import '../route/navigator.dart';
import 'card_item.dart';

class ListItemWidget extends StatelessWidget {
  final List<Item> items;

  ListItemWidget({Key? key, required this.items}) : super(key: key);

  // void showOverLay(BuildContext context) async{
  //   OverlayState overlayState = Overlay.of(context);
  //   OverlayEntry overlayEntry = OverlayEntry(builder: (context){
  //     return Positioned(
  //         bottom: 0,
  //         child: Container(
  //           width: MediaQuery.of(context).size.width,
  //           height: MediaQuery.of(context).size.height/2,
  //           color: Colors.black,
  //         ));
  //   });
  //   overlayState.insert(overlayEntry);
  //   await Future.delayed(Duration(seconds: 10));
  //   overlayEntry.remove();
  // }

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
            onTap: () {

              navigatorPush(context, PantryDetailPage(pantryId: item.id));
            },
            child: CardItem(icon: item.icon,textCategory: item.category,textLocation: item.location,status: item.expired.statusColor,textName: item.name,textStatus: item.expired.statusText,));
      },
      separatorBuilder: (context, index) => SizedBox(height: 10),
    );
  }
}
