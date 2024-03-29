import 'dart:developer' as dev;

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:lgpdjus/common/exception/non_loggable_error.dart';
import 'package:logging/logging.dart';
import 'package:stack_trace/stack_trace.dart';

typedef T OnError<T>(Object exception, StackTrace? stack);

void warn(String message) {
  dev.log(message);
  FirebaseCrashlytics.instance.log(message);
}

void error(Object exception, [StackTrace? stack]) {
  stack ??= StackTrace.current;
  dev.log(
    exception.toString(),
    level: Level.WARNING.value,
    error: exception,
    stackTrace: stack,
  );
  if (exception is! NonLoggableError) {
    FirebaseCrashlytics.instance.recordError(exception, stack);
  }
}

OnError get catchErrorLogger {
  Trace currentTrace = Trace.current(1);
  return (Object exception, StackTrace? stackTrace) async {
    final trace = Trace.from(stackTrace ?? Trace.current());
    if (!trace.frames.contains(currentTrace.frames.first)) {
      stackTrace = Trace(trace.frames + currentTrace.frames).vmTrace;
    }
    error(exception, stackTrace);
  };
}
