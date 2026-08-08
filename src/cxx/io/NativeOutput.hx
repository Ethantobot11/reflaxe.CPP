package cxx.io;

@:cxxStd
@:haxeStd
@:valueType
@:headerInclude("iostream", true)
@:headerInclude("algorithm", true)
@:headerInclude("deque", true)
@:headerInclude("memory", true)
@:headerCode("
#include <iostream>
#include <algorithm>
#include <deque>
#include <memory>

namespace haxe {
    class NativeInt64Struct;
}
")
class NativeOutput extends haxe.io.Output {
	var stream: Null<cxx.Ptr<cxx.std.ios.OStream>>;

	public function new(stream: cxx.Ptr<cxx.std.ios.OStream>) {
		this.stream = stream;
	}

	public override function writeByte(c: Int): Void {
		if(stream != null) {
			stream.put(cast c);
		}
	}

	public override function close(): Void {
		stream = null;
	}

	public override function flush() :Void {
		if(stream != null) {
			stream.flush();
		}
	}

	public override function prepare(nbytes: Int): Void {
	}
}
