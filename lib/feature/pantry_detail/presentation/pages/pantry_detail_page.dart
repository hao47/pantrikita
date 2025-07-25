import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/route/navigator.dart';
import 'package:pantrikita/core/theme/text_style.dart';
import 'package:pantrikita/core/widgets/custom_loading.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/bloc/pantry_detail_bloc.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/component/pantry_detail_content.dart';
import 'package:pantrikita/feature/pantry_detail/presentation/component/pantry_detail_error.dart';


import '../../../../core/theme/color_value.dart';
import '../../../../injection-container.dart';

class PantryDetailPage extends StatefulWidget {
  const PantryDetailPage({super.key, required this.pantryId});

  final String pantryId;

  @override
  State<PantryDetailPage> createState() => _PantryDetailPageState();
}

class _PantryDetailPageState extends State<PantryDetailPage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (_) => sl.get<PantryDetailBloc>()..add(GetPantryDetailEvent(pantryId: widget.pantryId)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorValue.black),
            onPressed: () => navigatorPop(context),
          ),
          title: Text(
            'Pantry Detail',
            style: tsTitleMediumBold(ColorValue.black),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<PantryDetailBloc, PantryDetailState>(
          builder: (context, state) {
            if (state.pantryDetailStatus == PantryDetailStatus.loading) return const CustomLoading();
            if (state.pantryDetailStatus == PantryDetailStatus.failure) return PantryDetailError(state: state, pantryId: widget.pantryId);
            if (state.pantryDetailStatus == PantryDetailStatus.success) return PantryDetailContent(state: state);
            return const SizedBox();
          },
        ),
      ),
    );
  }
}