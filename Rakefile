MRUBY_CONFIG=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
MRUBY_CONFIG_MINGW=File.expand_path(ENV["MRUBY_CONFIG_MINGW"] || "build_config_mingw_archlinux.rb")
MRUBY_VERSION=ENV["MRUBY_VERSION"] || "3.0.0"

file :mruby do
  sh "git clone -b #{MRUBY_VERSION} --depth=1 git://github.com/mruby/mruby.git"
end

desc "compile binary"
task :compile => :mruby do
  sh "cd mruby && rake all MRUBY_CONFIG=#{MRUBY_CONFIG}"
end

desc "test"
task :test => :mruby do
  sh "cd mruby && rake all test MRUBY_CONFIG=#{MRUBY_CONFIG}"
end

desc "cleanup"
task :clean do
  exit 0 unless File.directory?('mruby')
  sh "cd mruby && rake deep_clean"
end

file :mruby_mingw do
  sh "git clone -b #{MRUBY_VERSION} --depth=1 git://github.com/mruby/mruby.git mruby_mingw"
end

desc "compile for windows (host: archlinux)"
task :compile_win => :mruby_mingw do
  sh "cd mruby_mingw && rake all MRUBY_CONFIG=#{MRUBY_CONFIG_MINGW}"
end

task :default => :compile
