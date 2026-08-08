package cxx.num;

@:cxxStd
@:numberType(64, true, false)
@:native("double")
@:coreType
@:notNull
@:runtimeValue
@:headerInclude("_TypeUtils.h", true)
extern abstract Float64 to Float from Float {}
