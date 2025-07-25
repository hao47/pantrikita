import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/widgets/custom_loading.dart';
import 'package:pantrikita/feature/pantry/presentation/bloc/pantry_bloc.dart';
import 'package:pantrikita/feature/pantry/presentation/component/pantry_content.dart';
import 'package:pantrikita/feature/pantry/presentation/component/pantry_error.dart';


import '../../../../core/theme/color_value.dart';
import '../../../../injection-container.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});

  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (_) => sl.get<PantryBloc>()..add(GetPantryEvent()),
      child: Scaffold(
        backgroundColor: ColorValue.backgroundColor,
        body: BlocBuilder<PantryBloc, PantryState>(
          builder: (context, state) {
            if (state.pantryStatus == PantryStatus.loading) return const CustomLoading();
            if (state.pantryStatus == PantryStatus.failure) return PantryError(state: state);
            if (state.pantryStatus == PantryStatus.success) return PantryContent(state: state);
            return const SizedBox();
          },
        ),
      ),
    );
  }
}