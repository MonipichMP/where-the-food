import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sura_flutter/sura_flutter.dart';
import 'package:where_the_food/utils/toast_message_util.dart';
import 'package:where_the_food/widgets/empty_list_widget.dart';

class CustomStreamHandler<T> extends StatelessWidget {
  final Widget Function(T) ready;
  final Widget Function(dynamic)? errorWidget;
  final Widget? loading;
  final Stream<T?> stream;
  final Future<void> Function()? onRefresh;
  final bool hasAppBarOnError;

  const CustomStreamHandler({
    Key? key,
    required this.ready,
    this.loading,
    required this.stream,
    this.onRefresh,
    this.hasAppBarOnError = false,
    this.errorWidget,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SuraStreamHandler<T>(
      stream: stream,
      loading: loading ??
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SpinKitFadingFour(
                color: Theme.of(context).accentColor,
                size: 32,
              ),
            ),
          ),
      onError: (dynamic error) async {
        toastMessageError(error.toString(), context);
      },
      error: (error) {
        if (errorWidget != null) return errorWidget!(error);
        return const Center(
          child: EmptyListWidget(
            title: "Data",
          ),
        );
      },
      ready: ready,
    );
  }
}
