# https://gist.github.com/shuujii/675a316b4799f39820512897a2b01829#file-mruby-cross-mingw-rb

# Ubuntu 20.04 requires at least `gcc-mingw-w64-x86-64` package as a
# cross compiler.
#

MRuby::CrossBuild.new("cross-mingw") do |conf|
  conf.toolchain :gcc
  conf.host_target = "x86_64-w64-mingw32"
  conf.gem File.expand_path(File.dirname(__FILE__))
  conf.cc.command = "#{conf.host_target}-gcc-posix"
  conf.linker.command = conf.cc.command
  conf.archiver.command = "x86_64-w64-mingw32-gcc-ar"
  conf.exts.executable = ".exe"
  conf.gembox "full-core"
end
