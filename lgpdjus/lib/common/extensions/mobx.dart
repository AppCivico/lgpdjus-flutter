import 'package:dartz/dartz.dart';
import 'package:mobx/mobx.dart';

extension FutureMobx<T> on Future<T> {
  ObservableFuture observeWith(
    Function1<T, dynamic> onSuccess,
    Function2<Object, StackTrace, dynamic> onError,
  ) =>
      ObservableFuture(then(onSuccess).catchError(onError));
}
