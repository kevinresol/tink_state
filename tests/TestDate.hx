package ;

import tink.state.*;
import deepequal.DeepEqual.*;

using tink.CoreApi;
using DateTools;

@:asserts
class TestDate {

  public function new() {}

  public function basics() {
    var d = new ObservableDate(),
        log = [];

    var watch = d.becomesOlderThan(1.seconds()).bind(log.push);
    watch &= d.becomesOlderThan(10.seconds()).bind(log.push);

    Observable.updateAll();
    asserts.assert(compare([false,false], log));

    return Future.async(function (done) {
      haxe.Timer.delay(done.bind(Noise), 1100);
    }).next(function (_) {
      asserts.assert(compare([false,false,true], log));
      watch.cancel();
      return asserts.done();
    });
  }
}