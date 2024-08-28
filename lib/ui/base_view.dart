import 'package:flutter/material.dart';
import 'base_view_model.dart';
import 'package:stacked/stacked.dart';

abstract class PrincipalView<T extends PrincipalViewModel>
    extends StatelessWidget {
  final T _model;
  get model => _model;

  const PrincipalView(this._model, {super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<T>.reactive(
        viewModelBuilder: () => _model,
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) {
          return widget(model, context);
        });
  }

  Widget widget(T model, BuildContext context);

  Widget withProgress({required Widget body, required T model}) {
    return Stack(
      children: [
        body,
        model.loading
            ? const Center(child: CircularProgressIndicator())
            : Container(),
      ],
    );
  }
}
