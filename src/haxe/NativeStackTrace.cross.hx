package haxe;

#if cxx_callstack

import haxe.CallStack.StackItem;

@:valueType
@:headerInclude("haxe_CallStack.h", true)
extern class NativeStackItemData {
	public var classname: String;
	public var method: String;

	public var file: String;
	public var line: Int;
	public var col: Int;
}

@:unsafePtrType
@:headerInclude("haxe_CallStack.h", true)
extern class NativeStackItem {
	public var data: NativeStackItemData;
	public static function copyStack(): Array<NativeStackItemData>;
}

@:dox(hide)
@:haxeStd
@:noCompletion
@:headerInclude("iostream", true)
@:headerInclude("algorithm", true)
@:headerInclude("deque", true)
@:headerInclude("memory", true)
@:headerInclude("string", true)
@:headerInclude("haxe_CallStack.h", true)
@:headerCode("
#include <iostream>
#include <algorithm>
#include <deque>
#include <memory>

namespace haxe {
	class Exception;
    class StackItem;
}

#ifndef HCXX_STACK_METHOD
#define HCXX_STACK_METHOD(...) \\
	haxe::NativeStackItem ___s(__VA_ARGS__)
#endif

#ifndef HCXX_LINE
#define HCXX_LINE(line_num) \\
	___s.data.line = line_num
#endif

namespace haxe {

struct NativeStackItemData {
	std::string classname;
	std::string method;
	std::string file;
	int line;
	int col;
};

class NativeStackItem {
public:
	NativeStackItemData data;

	NativeStackItem(std::string file, int line, int col, std::string classname, std::string method) {
		data.file = file;
		data.line = line;
		data.col = col;
		data.classname = classname;
		data.method = method;
		getStack()->push_front(this);
	}

	~NativeStackItem() {
		getStack()->pop_front();
	}

	static std::shared_ptr<std::deque<NativeStackItem*>> getStack() {
		static auto stack = std::make_shared<std::deque<NativeStackItem*>>();
		return stack;
	}

	static std::shared_ptr<std::deque<NativeStackItemData>> copyStack() {
		auto result = std::make_shared<std::deque<NativeStackItemData>>();
		for(auto& item : *getStack()) {
			result->push_back(item->data);
		}
		return result;
	}
};

}
")
@:headerInclude("haxe_CallStack.h", true)
class NativeStackTrace {
	@:noCallstack
	public static function saveStack(exception: Any): Void {}

	@:noCallstack
	public static function callStack(): Array<NativeStackItemData> {
		return NativeStackItem.copyStack();
	}

	@:noCallstack
	public static function exceptionStack(): Array<NativeStackItemData> {
		return NativeStackItem.copyStack();
	}

	@:noCallstack
	public static function toHaxe(nativeStackTrace: Array<NativeStackItemData>, skip: Int = 0): Array<StackItem> {
		final result = [];
		for(i in 0...nativeStackTrace.length) {
			if(i <= skip) {
				continue;
			}
			final item = nativeStackTrace[i];
			result.push(FilePos(Method(item.classname, item.method), item.file, item.line, item.col));
		}
		return result;
	}
}

#else

@:dox(hide)
@:noCompletion
extern class NativeStackTrace {
	public static inline extern function saveStack(exception: Any): Void {}
	public static inline extern function callStack(): Array<Any> { return []; }
	public static inline extern function exceptionStack(): Array<Any> { return []; }
	public static inline extern function toHaxe(nativeStackTrace: Array<Any>, skip: Int = 0): Array<haxe.CallStack.StackItem> { return []; }
}

#end
