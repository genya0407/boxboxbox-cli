MRuby::Gem::Specification.new('boxboxbox-mrb') do |spec|
  spec.bins = ['boxboxbox']
  spec.license = 'MIT'
  spec.authors = 'Yusuke Sangenya'
  spec.add_dependency 'mruby-dir'
  spec.add_dependency 'mruby-simplehttp', github: 'matsumotory/mruby-simplehttp'
  spec.add_dependency 'mruby-json'
  spec.add_dependency 'mruby-io'
  spec.add_dependency 'mruby-base64', github: 'mattn/mruby-base64'
  spec.add_dependency 'mruby-logger', github: 'katzer/mruby-logger'
  # spec.add_dependency 'mruby-onig-regexp', github: 'mattn/mruby-onig-regexp'
  # spec.add_dependency 'mruby-regexp-pcre', github: 'iij/mruby-regexp-pcre'
  spec.add_dependency 'mruby-time-strftime', github: 'monochromegane/mruby-time-strftime'
end
