MRUBY_CONFIG=File.expand_path(ENV["MRUBY_CONFIG"] || "build_config.rb")
MRUBY_CONFIG_MINGW=File.expand_path(ENV["MRUBY_CONFIG_MINGW"] || "build_config_mingw_archlinux.rb")
MRUBY_VERSION=ENV["MRUBY_VERSION"] || "3.0.0"

file :mruby do
  sh "git clone -b #{MRUBY_VERSION} --depth=1 git://github.com/mruby/mruby.git"
end

desc "compile binary"
task :compile => 'dist/boxboxbox'

file 'dist/boxboxbox' => :mruby do
  sh "cd mruby && rake all MRUBY_CONFIG=#{MRUBY_CONFIG}"
  sh "cp mruby/bin/boxboxbox dist/boxboxbox"
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

task :default => :compile

## cross compile

file :mruby_mingw do |task|
  break unless task.needed?
  sh "git clone -b #{MRUBY_VERSION} --depth=1 git://github.com/mruby/mruby.git mruby_mingw"
end

file 'dist/boxboxbox.exe' => :mruby_mingw do |task|
  break unless task.needed?
  sh "cd mruby_mingw && rake all MRUBY_CONFIG=#{MRUBY_CONFIG_MINGW}"
  sh "cp mruby_mingw/build/cross-mingw/bin/boxboxbox.exe dist/boxboxbox.exe"
end

file 'dist/boxboxbox_mingw.zip' => %w[dist/boxboxbox.exe config.txt.sample input_images/.keep how_to_use.txt] do |task|
  break unless task.needed?
  sh "rm -f dist/boxboxbox_mingw.zip"
  sh "rm -rf dist/boxboxbox_mingw"
  sh "mkdir dist/boxboxbox_mingw"
  sh "mkdir dist/boxboxbox_mingw/input_images"
  sh "touch dist/boxboxbox_mingw/input_images/.keep"
  sh "cp #{task.sources.join(' ')} dist/boxboxbox_mingw/"
  sh "mv dist/boxboxbox_mingw/config.txt.sample dist/boxboxbox_mingw/config.txt"
  sh "cd dist && zip boxboxbox_mingw.zip -r boxboxbox_mingw"
end

desc "compile for windows (host: archlinux)"
task :compile_mingw => 'dist/boxboxbox.exe'

desc "pack zip for win"
task :pack_mingw => 'dist/boxboxbox_mingw.zip'
