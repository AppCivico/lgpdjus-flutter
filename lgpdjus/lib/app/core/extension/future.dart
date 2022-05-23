import 'package:dartz/dartz.dart';

extension FutureCatch<T> on Future<T> {
  Future<T> switchOnError(Function2<Object, StackTrace, Future<T>> handler) {
    return catchError((Object error, StackTrace stackTrace) async {
      final catched = await handler(error, stackTrace);
      if (catched is Exception) throw catched;
      return catched;
    });
  }
}
