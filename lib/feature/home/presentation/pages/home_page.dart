import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pantrikita/core/widgets/custom_loading.dart';
import 'package:pantrikita/core/widgets/list_item.dart';

import '../../../../core/theme/color_value.dart';
import '../../../../core/theme/text_style.dart';
import '../../../../injection-container.dart';
import '../bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {

    super.build(context);
    return BlocProvider(
      create: (_) => sl.get<HomeBloc>()..add(GetHomeEvent()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5), // ColorValue.backgroundColor
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {

            print(state);
            if (state is HomeLoading) {
              return CustomLoading();
            } else if (state is HomeSuccess) {
              final data = state.home.data;
              return SafeArea(
                child: RefreshIndicator(
                  backgroundColor: ColorValue.whiteColor,
                  color: ColorValue.primary,
                  onRefresh: () async {
                    context.read<HomeBloc>().add(GetHomeEvent());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Hello,\ngrdhck!",
                                style: tsTitleLargeMedium(ColorValue.black)
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.notifications_rounded,
                                  color: Colors.black,
                                  size: 40,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Attention Needed Card
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color:  ColorValue.primaryTransparant,
                              // primary transparent
                              border: Border.all(color: ColorValue.primary),
                              // primary
                              borderRadius: const BorderRadius.all(
                                Radius.circular(14),
                              ),
                            ),
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration:  BoxDecoration(
                                    color: ColorValue.yellowDarkTransparant,
                                    // yellow dark transparent
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(50),
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(15),
                                  child: const Icon(
                                    Icons.warning,
                                    color: Color(0xFFFF6F00),
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Attention Needed",
                                        style: tsBodyMediumMedium(ColorValue.orangeDark),
                                      ),
                                      const SizedBox(height: 10),

                                      // Bullet points
                                      ...data.attentionNeeded.content
                                          .split(',')
                                          .map(
                                            (item) => Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 6,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "• ",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: const Color(
                                                        0xFFFF6F00,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      item.trim(),
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: const Color(
                                                          0xFFFF6F00,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                          .toList(),

                                      const SizedBox(height: 16),

                                      // View All Items Button
                                      SizedBox(
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () => {

                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            side: BorderSide(
                                              color: const Color(0xFFFF6F00),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                8,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "View All Items",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xFFFF6F00),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Statistics Cards Row
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(14),
                                    ),
                                    border: Border.all(
                                      color: const Color(0xFFE0E0E0), // gray
                                      width: 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFE3F2FD),
                                          // blue transparent
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(15),
                                        child: const Icon(
                                          Icons.inventory_2,
                                          color: Color(0xFF1976D2),
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(

                                      data.total.totalItems.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Total Items",
                                        style: tsLabelLargeMedium(
                                          ColorValue.grayDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(14),
                                    ),
                                    border: Border.all(
                                      color: const Color(0xFFE0E0E0), // gray
                                      width: 1,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(30),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFF8E1),
                                          // yellow status transparent
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(50),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(15),
                                        child: const Icon(
                                          Icons.access_time,
                                          color: Color(0xFFF57F17),
                                          size: 30,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(

                                        data.total.expiringSoon.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xFFF57F17), // yellow dark
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        "Expiring Soon",
                                        style: tsLabelLargeMedium(
                                          ColorValue.grayDark,
                                        ),
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Recent Items",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  // Navigate to pantry page
                                },
                                child: Text(
                                  "View All",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFFFF9800), // primary
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Recent Items List
                          data.items.isEmpty
                              ? Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.inventory_2_outlined,
                                        size: 80,
                                        color: Colors.grey[400],
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        "No items found",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : ListItemWidget(items: data.items),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (state is HomeFailure) {
              return Container();
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
