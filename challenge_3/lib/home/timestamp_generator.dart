//
// Do not modify this file
//

class TimestampGeneratorState {
  double progress = 0;
  int? result;

  TimestampGeneratorState(this.progress, this.result);
  TimestampGeneratorState.pending(this.progress);
}

class TimestampGeneratorService {
  final interval = 100;
  var getCount = 0;

  // Delivers timestamp with progress state
  Stream<TimestampGeneratorState> getTimestamp() async* {
    int p = 0;
    var id = ++getCount;
    print('Id = $getCount');
    while (p < 1000) {
      await Future.delayed(Duration(milliseconds: interval));
      p = p + interval;
      if(p == 1000) {
        var result = DateTime.now().millisecondsSinceEpoch;
        print('Generator result $id = $result');
        yield TimestampGeneratorState(1, result);
      } else {
        // print('Generator yield result $p');
        yield TimestampGeneratorState.pending(p / 1000);
      }
    }
  }

}

