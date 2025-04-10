json_file := /tmp/1.json

include ../common/commands.mk
.DEFAULT_GOAL := build

json-rs-targets := \
	json.rs/target/release/json-pull-rs \
	json.rs/target/release/json-struct-rs \
	json.rs/target/release/json-value-rs \
	json.rs/target/release/json-jq-rs

executables := \
	target/json_cr \
	target/json_pull_cr \
	target/json_schema_cr \
	$(json-rs-targets) \
	$(GO_TARGETS) \
	target/json_d \
	target/json_d_gdc \
	target/json_d_ldc \
	target/json_d_mir_asdf \
	target/json_d_mir_ion \
	target/json_nim_gcc \
	target/json_nim_clang \
	target/packedjson_nim_gcc \
	target/packedjson_nim_clang \
	target/jsony_nim_gcc \
	target/jsony_nim_clang \
	target/json_go_gccgo \
	target/json_boost_ptree_cpp_gcc \
	target/json_boost_json_cpp_gcc \
	target/json_rapid_cpp_gcc \
	target/json_rapid_sax_cpp_gcc \
	target/json_rapid_cpp_precised_gcc \
	target/json_rapid_sax_cpp_precised_gcc \
	target/json_gason_cpp_gcc \
	target/json_libjson_cpp_gcc \
	target/json_simdjson_cpp_gcc \
	target/json_simdjson_dom_cpp_gcc \
	target/json_dawjsonlink_cpp_gcc \
	target/json_dawjsonlink_cpp_unchecked_gcc \
	target/json_nlohmann_json_cpp_gcc \
	target/json_boost_ptree_cpp_clang \
	target/json_boost_json_cpp_clang \
	target/json_rapid_cpp_clang \
	target/json_rapid_sax_cpp_clang \
	target/json_rapid_cpp_precised_clang \
	target/json_rapid_sax_cpp_precised_clang \
	target/json_gason_cpp_clang \
	target/json_libjson_cpp_clang \
	target/json_simdjson_cpp_clang \
	target/json_simdjson_dom_cpp_clang \
	target/json_dawjsonlink_cpp_clang \
	target/json_dawjsonlink_cpp_unchecked_clang \
	target/json_nlohmann_json_cpp_clang \
	target/json_hs \
	json-java/target/application \
	target/json_v_gcc \
	target/json_v_clang \
	target/json_vala_gcc \
	target/json_vala_clang \
	json-fsharp/target/Release/net8.0/json-fsharp \
	target/Release/net8.0/json \
	json-core/target/Release/net8.0/json-core \
	target/json_zig \
	target/json_yajl_gcc \
	target/json_yajl_clang \
	target/json_odin \
	target/json_c3 \

# TODO: Enable Julia test after https://github.com/quinnj/JSON3.jl/issues/276 fixed
artifacts := $(executables) \
	target/test.exe \
	json-scala/target/application.jar

#	run[test.jl] 
all_runners := $(patsubst %,run[%], $(artifacts)) \
	run[test_yajl.rb] \
	run[test.pl] \
	run[test-xs.pl] \
	run[test.js] \
	run[pypy][test.py] \
	run[test.py] \
	run[test_ujson.py] \
	run[test.rb] \
	run[jit][test.rb] \
	run[truby-jvm][test.rb] \
	run[truby-native][test.rb] \
	run[jruby][test.rb] \
	run[test.php] \
	run[test.clj] \
	run[test.rkt]

# Build

.PHONY: build
build: $(artifacts)

target/json_cr: test.cr | target
	$(CRYSTAL_BUILD)

target/json_pull_cr: test_pull.cr | target
	$(CRYSTAL_BUILD)

target/json_schema_cr: test_schema.cr | target
	$(CRYSTAL_BUILD)

json-rs-toml := json.rs/Cargo.toml
.PHONY: $(json-rs-targets)
$(json-rs-targets): $(json-rs-toml)
	$(CARGO_BUILD)

target/json_d: test.d | $(dfmt)
	$(DMD_BUILD)

target/json_d_gdc: test.d | $(dfmt)
	$(GDC_BUILD)

target/json_d_ldc: test.d | $(dfmt)
	$(LDC2_BUILD)

target/json_d_mir_asdf: test_mir_asdf.d | $(dfmt)
	$(DUB_BUILD)

target/json_d_mir_ion: test_mir_ion.d | $(dfmt)
	$(DUB_BUILD)

target/json_nim_gcc: test.nim | target
	$(NIM_GCC_BUILD)

target/json_nim_clang: test.nim | target
	$(NIM_CLANG_BUILD)

.PHONY: packedjson
packedjson:
	nimble -y install packedjson

target/packedjson_nim_gcc: test_packedjson.nim | target packedjson
	$(NIM_GCC_BUILD)

target/packedjson_nim_clang: test_packedjson.nim | target packedjson
	$(NIM_CLANG_BUILD)

.PHONY: jsony
jsony:
	nimble -y install jsony

target/jsony_nim_gcc: test_jsony.nim | target jsony
	$(NIM_GCC_BUILD)

target/jsony_nim_clang: test_jsony.nim | target jsony
	$(NIM_CLANG_BUILD)

target/json_go_gccgo: go/json $(GO_SOURCE) | gofmt
	$(GCC_GO_BUILD)

nlohmann_json := target/nlohmann_json
$(nlohmann_json): | target
	$(GIT_CLONE) "https://github.com/nlohmann/json.git" $@

rapidjson-dir := target/rapidjson
$(rapidjson-dir): | target
	$(GIT_CLONE) "https://github.com/miloyip/rapidjson.git" $@

gason-dir := target/gason
$(gason-dir): | target
	$(GIT_CLONE) "https://github.com/vivkin/gason.git" $@

simdjson-dir := target/simdjson

$(simdjson-dir): | target
	$(GIT_CLONE) "https://github.com/simdjson/simdjson.git" $@

daw_json_link_all := target/daw_json_link_all
$(daw_json_link_all): | target
	$(GIT_CLONE) "https://github.com/beached/daw_json_link.git" $@/daw_json_link
	$(GIT_CLONE) "https://github.com/beached/header_libraries.git" $@/header_libraries
	$(GIT_CLONE) "https://github.com/beached/utf_range.git" $@/utf_range

target/json_boost_ptree_cpp_gcc: test_boost_ptree.cpp | libnotify
	$(GCC_CPP_BUILD)

target/json_boost_json_cpp_gcc: test_boost_json.cpp | libnotify
	$(GCC_CPP_BUILD)

target/json_rapid_cpp_gcc: test_rapid.cpp | $(rapidjson-dir) libnotify
	$(GCC_CPP_BUILD) -I$(rapidjson-dir)/include

target/json_rapid_cpp_precised_gcc: test_rapid.cpp | $(rapidjson-dir) libnotify
	$(GCC_CPP_BUILD) -I$(rapidjson-dir)/include -DPRECISED

target/json_rapid_sax_cpp_gcc: test_rapid_sax.cpp | $(rapidjson-dir) libnotify
	$(GCC_CPP_BUILD) -I$(rapidjson-dir)/include

target/json_rapid_sax_cpp_precised_gcc: test_rapid_sax.cpp | $(rapidjson-dir) libnotify
	$(GCC_CPP_BUILD) -I$(rapidjson-dir)/include -DPRECISED

target/json_gason_cpp_gcc: test_gason.cpp | $(gason-dir) libnotify
	$(GCC_CPP_BUILD) -I$(gason-dir)/src $(gason-dir)/src/gason.cpp

target/json_libjson_cpp_gcc: test_libjson.cpp | target libnotify
	$(GCC_CPP_BUILD) -ljson-c

target/json_simdjson_cpp_gcc: test_simdjson.cpp | $(simdjson-dir) libnotify
	$(GCC_CPP_BUILD) $(simdjson-dir)/singleheader/simdjson.cpp \
		-I$(simdjson-dir)/singleheader/

target/json_simdjson_dom_cpp_gcc: test_simdjson_dom.cpp | $(simdjson-dir) libnotify
	$(GCC_CPP_BUILD) $(simdjson-dir)/singleheader/simdjson.cpp \
		-I$(simdjson-dir)/singleheader/

target/json_dawjsonlink_cpp_gcc: test_dawjsonlink.cpp | $(daw_json_link_all) libnotify
	$(GCC_CPP_BUILD) -I$(daw_json_link_all)/daw_json_link/include \
		-I$(daw_json_link_all)/header_libraries/include \
		-I$(daw_json_link_all)/utf_range/include

target/json_dawjsonlink_cpp_unchecked_gcc: test_dawjsonlink.cpp | $(daw_json_link_all) libnotify
	$(GCC_CPP_BUILD) -I$(daw_json_link_all)/daw_json_link/include \
		-I$(daw_json_link_all)/header_libraries/include \
		-I$(daw_json_link_all)/utf_range/include -DUNCHECKED

target/json_nlohmann_json_cpp_gcc: test_nlohmann_json.cpp | $(nlohmann_json) libnotify
	$(GCC_CPP_BUILD) -I$(nlohmann_json)/single_include

target/json_boost_ptree_cpp_clang: test_boost_ptree.cpp | libnotify
	$(CLANG_CPP_BUILD)

target/json_boost_json_cpp_clang: test_boost_json.cpp | libnotify
	$(CLANG_CPP_BUILD)

target/json_rapid_cpp_clang: test_rapid.cpp | $(rapidjson-dir) libnotify
	$(CLANG_CPP_BUILD) -I$(rapidjson-dir)/include

target/json_rapid_cpp_precised_clang: test_rapid.cpp | $(rapidjson-dir) libnotify
	$(CLANG_CPP_BUILD) -I$(rapidjson-dir)/include -DPRECISED

target/json_rapid_sax_cpp_clang: test_rapid_sax.cpp | $(rapidjson-dir) libnotify
	$(CLANG_CPP_BUILD) -I$(rapidjson-dir)/include

target/json_rapid_sax_cpp_precised_clang: test_rapid_sax.cpp | $(rapidjson-dir) libnotify
	$(CLANG_CPP_BUILD) -I$(rapidjson-dir)/include -DPRECISED

target/json_gason_cpp_clang: test_gason.cpp | $(gason-dir) libnotify
	$(CLANG_CPP_BUILD) -I$(gason-dir)/src $(gason-dir)/src/gason.cpp

target/json_libjson_cpp_clang: test_libjson.cpp | target libnotify
	$(CLANG_CPP_BUILD) -ljson-c

target/json_simdjson_cpp_clang: test_simdjson.cpp | $(simdjson-dir) libnotify
	$(CLANG_CPP_BUILD) $(simdjson-dir)/singleheader/simdjson.cpp \
		-I$(simdjson-dir)/singleheader/

target/json_simdjson_dom_cpp_clang: test_simdjson_dom.cpp | $(simdjson-dir) libnotify
	$(CLANG_CPP_BUILD) $(simdjson-dir)/singleheader/simdjson.cpp \
		-I$(simdjson-dir)/singleheader/

target/json_dawjsonlink_cpp_clang: test_dawjsonlink.cpp | $(daw_json_link_all) libnotify
	$(CLANG_CPP_BUILD) -I$(daw_json_link_all)/daw_json_link/include \
		-I$(daw_json_link_all)/header_libraries/include \
		-I$(daw_json_link_all)/utf_range/include

target/json_dawjsonlink_cpp_unchecked_clang: test_dawjsonlink.cpp | $(daw_json_link_all) libnotify
	$(CLANG_CPP_BUILD) -I$(daw_json_link_all)/daw_json_link/include \
		-I$(daw_json_link_all)/header_libraries/include \
		-I$(daw_json_link_all)/utf_range/include -DUNCHECKED

target/json_nlohmann_json_cpp_clang: test_nlohmann_json.cpp | $(nlohmann_json) libnotify
	$(CLANG_CPP_BUILD) -I$(nlohmann_json)/single_include

newtonsoft_json_dir := target/Newtonsoft.Json/lib/net45
newtonsoft_json := $(newtonsoft_json_dir)/Newtonsoft.Json.dll
$(newtonsoft_json): | target
	$(NUGET_INSTALL) Newtonsoft.Json -OutputDirectory target

target/test.exe: test.cs | $(newtonsoft_json)
	$(MCS_BUILD) -r:$(newtonsoft_json)

.PHONY: target/Release/net8.0/json
target/Release/net8.0/json: json.csproj | target
	$(DOTNET_BUILD)

.PHONY: json-core/target/Release/net8.0/json-core
json-core/target/Release/net8.0/json-core: json-core/json-core.csproj
	$(DOTNET_BUILD)

.PHONY: target/json_hs
target/json_hs:
	$(MAKE) -C json-hs

.PHONY: json-java/target/application
json-java/target/application:
	$(MAKE) -C json-java target/application

.PHONY: json-scala/target/application.jar
json-scala/target/application.jar:
	$(MAKE) -C json-scala target/application.jar

target/json_v_gcc: test.v | $(v_fmt)
	$(V_GCC_BUILD)

target/json_v_clang: test.v | $(v_fmt)
	$(V_CLANG_BUILD)

target/json_vala_gcc: test.vala | target
	$(VALAC_GCC_BUILD) --pkg json-glib-1.0

target/json_vala_clang: test.vala | target
	$(VALAC_CLANG_BUILD) --pkg json-glib-1.0

json-fsharp/target/Release/net8.0/json-fsharp: json-fsharp/json-fsharp.fsproj json-fsharp/Program.fs
	$(DOTNET_BUILD)

target/json_zig: test.zig | $(zig_fmt)
	$(ZIG_BUILD)

target/json_yajl_gcc: test_yajl.c | target libnotify
	$(GCC_BUILD) -lyajl

target/json_yajl_clang: test_yajl.c | target libnotify
	$(CLANG_BUILD) -lyajl

target/json_odin: test.odin
	$(ODIN_BUILD)

target/json_c3: test.c3
	$(C3_BUILD)

# Run

.PHONY: run
run: $(all_runners)

## Common recipe for all runners
.PHONY: $(all_runners)
$(all_runners):: $(json_file)
	$(ECHO_RUN)

## Runners
executable_runners := $(patsubst %,run[%], $(executables))
$(executable_runners):: run[%] : %
	$(EXECUTABLE_RUN)

run[test.jl]:: run[%]: % | $(julia_fmt)
	$(JULIA_RUN)

run[target/test.exe]:: run[%]: %
	MONO_PATH=$(newtonsoft_json_dir) $(MONO_RUN)

.PHONY: yajl-ruby
yajl-ruby:
	gem install yajl-ruby

run[test_yajl.rb]:: run[%]: % | yajl-ruby
	$(RUBY_RUN)

.PHONY: file-slurper
file-slurper:
	$(CPANM) "File::Slurper"

.PHONY: json-tiny
json-tiny:
	$(CPANM) "JSON::Tiny"

.PHONY: cpanel-json-xs
cpanel-json-xs:
	$(CPANM) "Cpanel::JSON::XS"

run[test.pl]:: run[%]: % | file-slurper json-tiny
	$(PERL_RUN)

run[test-xs.pl]:: run[%]: % | file-slurper cpanel-json-xs
	$(PERL_RUN)

run[json-scala/target/application.jar]:: run[%]: %
	$(SCALA_RUN)

run[test.js]:: run[%]: %
	$(NODE_RUN)

run[pypy][test.py]:: run[pypy][%]: % | $(py_fmt)
	$(PYPY3_RUN)

run[test.py]:: run[%]: % | $(py_fmt)
	$(PYTHON3_RUN)

run[test_ujson.py]:: run[%]: % | $(py_fmt)
	$(PYTHON3_RUN)

run[test.rb]:: run[%]: % | $(rubocop)
	$(RUBY_RUN)

run[jit][test.rb]:: run[jit][%]: % | $(rubocop)
	$(RUBY_JIT_RUN)

run[truby-jvm][test.rb]:: run[truby-jvm][%]: % | $(rubocop)
	$(TRUBY_JVM_RUN)

run[truby-native][test.rb]:: run[truby-native][%]: % | $(rubocop)
	$(TRUBY_NATIVE_RUN)

run[jruby][test.rb]:: run[jruby][%]: % | $(rubocop)
	$(JRUBY_RUN)

run[test.php]:: run[%]: %
	$(PHP_RUN)

run[test.clj]:: CLOJURE_FLAGS := -Sdeps '{:deps {cheshire/cheshire {:mvn/version "5.13.0"}}}'
run[test.clj]:: run[%]: %
	$(CLOJURE_RUN)

run[test.rkt]:: run[%]: %
	$(RACKET_RUN)

# Utilities

.PHONY: clean
clean: clean-go
	$(MAKE) -C json-scala clean
	$(MAKE) -C json-java clean
	$(MAKE) -C json-hs clean
	$(DOTNET_CLEAN) json-core/json-core.csproj
	$(DOTNET_CLEAN) json-fsharp/json-fsharp.fsproj
	cargo clean --manifest-path $(json-rs-toml)
	-rm -rf target
	-rm -rf mir-common-json/target
	-rm -rf zig-cache

$(json_file):
	ruby generate_json.rb
