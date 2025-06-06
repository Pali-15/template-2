import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/core/common_widgets/base_screen.dart';
import 'package:template/core/extensions/context_extensions/context_design_extension.dart';
import 'package:template/app/screens/page_1/page_1_nested/bloc/bloc.dart';

class Page1Nested extends StatelessWidget {
  const Page1Nested({super.key});

  @override
  Widget build(BuildContext context) {
    return BasePage(
      enableBackButton: true,
      children: BlocBuilder<Page1Bloc, Page1BlocState>(
        builder: (context, state) {
          if (state is Page1BlocStateLoaded) {
            return Column(
              children: [
                Center(
                  child: Text("Page 1 Nested", style: context.textStyles.body),
                ),
                ...state.data.map((e) => Text(e)),
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
