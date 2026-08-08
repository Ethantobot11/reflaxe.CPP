package cxx.num;

@:cxxStd
@:numberType(32, false, false)
@:include("cstddef", true)
@:native("std::size_t")
@:notNull
@:runtimeValue
@:coreType
@:headerInclude("_TypeUtils.h", true)
extern abstract SizeT from Int to Int {
}
