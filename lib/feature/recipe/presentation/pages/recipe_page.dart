import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pantrikita/core/theme/color_value.dart';
import 'package:pantrikita/core/widgets/custom_loading.dart';
import 'package:pantrikita/feature/recipe/presentation/bloc/recipe_bloc.dart';
import 'package:pantrikita/feature/recipe/presentation/widgets/recipe_content.dart';
import 'package:pantrikita/feature/recipe/presentation/widgets/recipe_error.dart';
import '../../../../injection-container.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage>
    with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (_) => sl.get<RecipeBloc>()..add(GetRecipesEvent()),
      child: Scaffold(
        backgroundColor: ColorValue.backgroundColor,
        body: BlocBuilder<RecipeBloc, RecipeState>(
          builder: (context, state) {
            if (state is RecipeLoading) return const CustomLoading();
            if (state is RecipeFailure) return WidgetRecipeError(state: state,);
            if (state is RecipeSuccess) return WidgetRecipeContent(state: state);
            return const SizedBox();
          },
        ),
      ),
    );
  }
}