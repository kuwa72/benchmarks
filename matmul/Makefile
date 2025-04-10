# The matrix size
MSIZE := 1500

include ../common/commands.mk
.DEFAULT_GOAL := build

rust-ndarray-targets := \
	rust-ndarray/target/release/rust-ndarray

executables := \
	target/matmul_nim_gcc \
	target/matmul_nim_clang \
	target/matmul_nim_arraymancer_gcc \
	target/matmul_nim_arraymancer_clang \
	target/matmul_cr \
	$(GO_TARGETS) \
	target/matmul_go_gccgo \
	target/matmul_c_gcc \
	target/matmul_c_clang \
	matmul.rs/target/release/matmul \
	$(rust-ndarray-targets) \
	target/matmul_swift \
	target/matmul_d \
	target/matmul_d_gdc \
	target/matmul_d_ldc \
	target/matmul_d_lubeck \
	java-nd4j/target/application \
	target/matmul_v_gcc \
	target/matmul_v_clang \
	target/matmul_v_vsl_cblas_gcc \
	target/matmul_v_vsl_cblas_clang \
	target/matmul_v_vsl_default_gcc \
	target/matmul_v_vsl_default_clang \
	target/matmul_vala_gcc \
	target/matmul_vala_clang \
	target/Release/net8.0/matmul \
	target/matmul_cpp_gcc \
	target/matmul_cpp_clang \
	target/matmul_zig

artifacts := $(executables) \
	target/matmul.class \
	target/matmul-kt.jar \
	target/matmul.exe

all_runners := $(patsubst %,run[%], $(artifacts)) \
	run[matmul.js] \
	run[matmul-native.jl] \
	run[single_thread][matmul-native.jl] \
	run[matmul.jl] \
	run[pypy][matmul.py] \
	run[matmul.py] \
	run[matmul-numpy.py] \
	run[matmul.pl] \
	run[matmul.tcl] \
	run[matmul.rb] \
	run[jit][matmul.rb] \
	run[truby-jvm][matmul.rb] \
	run[truby-native][matmul.rb] \
	run[jruby][matmul.rb] \
	run[matmul.scala]

# Build

.PHONY: build
build: $(artifacts)

target/matmul_cr: matmul.cr | target
	$(CRYSTAL_BUILD)

target/matmul_go_gccgo: go/matmul $(GO_SOURCE) | gofmt
	$(GCC_GO_BUILD)

matmul-rs-toml := matmul.rs/Cargo.toml
.PHONY: matmul.rs/target/release/matmul
matmul.rs/target/release/matmul: $(matmul-rs-toml)
	$(CARGO_BUILD)

rust-ndarray-toml := rust-ndarray/Cargo.toml
.PHONY: $(rust-ndarray-targets)
$(rust-ndarray-targets): $(rust-ndarray-toml)
	$(CARGO_BUILD)

target/matmul_swift: matmul.swift | target
	$(SWIFTC_BUILD)

target/matmul_d: matmul.d | $(dfmt)
	$(DMD_BUILD)

target/matmul_d_gdc:matmul.d | $(dfmt)
	$(GDC_BUILD)

target/matmul_d_ldc:matmul.d | $(dfmt)
	$(LDC2_BUILD)

target/matmul_d_lubeck: matmul_d_lubeck.d | $(dfmt)
	$(DUB_BUILD)

target/matmul_nim_gcc: matmul.nim | target
	$(NIM_GCC_BUILD)

target/matmul_nim_clang: matmul.nim | target
	$(NIM_CLANG_BUILD)

.PHONY: arraymancer
arraymancer:
	nimble install -y arraymancer

target/matmul_nim_arraymancer_gcc: NIM_FLAGS += -d:openmp
target/matmul_nim_arraymancer_gcc: matmul_arraymancer.nim | target arraymancer
	$(NIM_GCC_BUILD)

target/matmul_nim_arraymancer_clang: NIM_FLAGS += -d:openmp
target/matmul_nim_arraymancer_clang: matmul_arraymancer.nim | target arraymancer
	$(NIM_CLANG_BUILD)

target/matmul_c_gcc: matmul.c | target libnotify
	$(GCC_BUILD)

target/matmul_c_clang: matmul.c | target libnotify
	$(CLANG_BUILD)

# Marked phony to run always
.PHONY: java-nd4j/target/application
java-nd4j/target/application:
	$(MAKE) -C java-nd4j target/application

target/matmul_v_gcc: matmul.v | $(v_fmt)
	$(V_GCC_BUILD)

target/matmul_v_clang: matmul.v | $(v_fmt)
	$(V_CLANG_BUILD)

target/matmul_v_vsl_default_gcc: matmul-vsl.v | $(v_fmt)
	$(V_GCC_BUILD)

target/matmul_v_vsl_default_clang: matmul-vsl.v | $(v_fmt)
	$(V_CLANG_BUILD)

target/matmul_v_vsl_cblas_gcc: matmul-vsl.v | $(v_fmt)
	$(V_VSL_CBLAS_GCC_BUILD) -d lapacke

target/matmul_v_vsl_cblas_clang: matmul-vsl.v | $(v_fmt)
	$(V_VSL_CBLAS_CLANG_BUILD) -d lapacke

target/matmul_vala_gcc: matmul.vala | target
	$(VALAC_GCC_BUILD)

target/matmul_vala_clang: matmul.vala | target
	$(VALAC_CLANG_BUILD)

target/matmul.class: matmul.java | target
	$(JAVAC_BUILD)

target/matmul-kt.jar: matmul.kt | target
	$(KOTLINC_BUILD)

target/matmul.exe: matmul.cs | target
	$(MCS_BUILD)

.PHONY: target/Release/net8.0/matmul
target/Release/net8.0/matmul: matmul.csproj | target
	$(DOTNET_BUILD)

eigen := target/eigen
$(eigen): | target
	$(GIT_CLONE) "https://gitlab.com/libeigen/eigen.git" $@

target/matmul_cpp_gcc: matmul.cpp | $(eigen) libnotify
	$(GCC_CPP_BUILD) -I$(eigen) -fopenmp

target/matmul_cpp_clang: matmul.cpp | $(eigen) libnotify
	$(CLANG_CPP_BUILD) -I$(eigen) -fopenmp

target/matmul_zig: matmul.zig | $(zig_fmt)
	$(ZIG_BUILD)

# Run

.PHONY: run
run: $(all_runners)

## Common recipe for all runners
.PHONY: $(all_runners)
$(all_runners)::
	$(ECHO_RUN)

## Runners
executable_runners := $(patsubst %,run[%], $(executables))
$(executable_runners):: run[%] : %
	$(EXECUTABLE_RUN) $(MSIZE)

run[matmul.scala]:: run[%]: %
	$(SCALA_RUN) -- $(MSIZE)

run[target/matmul.class]:: run[%]: %
	$(JAVA_CLASS_RUN) $(MSIZE)

run[target/matmul-kt.jar]:: run[%]: %
	$(JAVA_JAR_RUN) $(MSIZE)

run[target/matmul.exe]:: run[%]: %
	$(MONO_RUN) $(MSIZE)

run[matmul.js]:: run[%]: %
	$(NODE_RUN) $(MSIZE)

run[matmul-native.jl]:: run[%]: % | $(julia_fmt)
	$(JULIA_RUN) $(MSIZE)

run[single_thread][matmul-native.jl]:: run[single_thread][%]: % | $(julia_fmt)
	OPENBLAS_NUM_THREADS=1 $(JULIA_RUN) $(MSIZE)

run[matmul.jl]:: run[%]: %  | $(julia_fmt)
	$(JULIA_RUN) $(MSIZE)

run[pypy][matmul.py]:: run[pypy][%]: % | $(py_fmt)
	$(PYPY3_RUN) $(MSIZE)

run[matmul.py]:: run[%]: % | $(py_fmt)
	$(PYTHON3_RUN) $(MSIZE)

run[matmul-numpy.py]:: run[%]: % | $(py_fmt)
	$(PYTHON3_RUN) $(MSIZE)

run[matmul.pl]:: run[%]: %
	$(PERL_RUN) $(MSIZE)

run[matmul.tcl]:: run[%]: %
	$(TCLSH_RUN) $(MSIZE)

run[matmul.rb]:: run[%]: % | $(rubocop)
	$(RUBY_RUN) $(MSIZE)

run[jit][matmul.rb]:: run[jit][%]: % | $(rubocop)
	$(RUBY_JIT_RUN) $(MSIZE)

run[truby-jvm][matmul.rb]:: run[truby-jvm][%]: % | $(rubocop)
	$(TRUBY_JVM_RUN) $(MSIZE)

run[truby-native][matmul.rb]:: run[truby-native][%]: % | $(rubocop)
	$(TRUBY_NATIVE_RUN) $(MSIZE)

run[jruby][matmul.rb]:: run[jruby][%]: % | $(rubocop)
	$(JRUBY_RUN) $(MSIZE)

# Utilities

.PHONY: clean
clean: clean-go
	-rm -rf target
	$(MAKE) -C java-nd4j clean
	cargo clean --manifest-path $(rust-ndarray-toml)
	-rm -rf zig-cache
