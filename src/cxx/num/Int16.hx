package cxx.num;

@:cxxStd
@:numberType(16, false, true)
#if cxx_imprecise_number_types
@:native("short")
#else
@:native("int16_t")
@:include("cstdint", true)
#end
@:coreType
@:notNull
@:runtimeValue
@:headerInclude("_TypeUtils.h", true)
extern abstract Int16 to Int from Int {}
