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
class NativeInput extends haxe.io.Input {
	var stream: Null<cxx.Ptr<cxx.std.ios.IStream>>;

	public function new(stream: cxx.Ptr<cxx.std.ios.IStream>) {
		this.stream = stream;
	}

	public override function readByte(): Int {
		return stream.get();
	}

	public override function close(): Void {
	}
}
