package cxx.num;

@:cxxStd
@:numberType(32, false, true)
#if cxx_imprecise_number_types
@:native("int")
#else
@:native("int32_t")
@:include("cstdint", true)
#end
@:coreType
@:notNull
@:runtimeValue
extern abstract Int32 to Int from Int {
    @:op(-A) private inline function negate():Int32 return -this;
    @:op(A + B) private static inline function add(a:Int32, b:Int32):Int32 return a + b;
    @:op(A - B) private static inline function sub(a:Int32, b:Int32):Int32 return a - b;
    @:op(A * B) private static inline function mul(a:Int32, b:Int32):Int32 return a * b;
    @:op(A / B) private static inline function div(a:Int32, b:Int32):Int32 return Std.int(a / b);
}
