import 'my_collector.dart';

final _finalizer = Finalizer<int>((hashCode) => myCollector.free(hashCode));

abstract class MyObject {
  final int myHashCode;

  MyObject(this.myHashCode) {
    _finalizer.attach(this, myHashCode);
  }

  @override
  int get hashCode => myHashCode;

  @override
  bool operator ==(Object other) {
    return other is MyObject && other.myHashCode == myHashCode;
  }
}
