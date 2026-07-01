import 'connection_stub.dart'
    if (dart.library.io) 'connection_native.dart'
    if (dart.library.js_interop) 'connection_web.dart' as impl;

import 'package:drift/drift.dart';

QueryExecutor openConnection() => impl.openConnection();
