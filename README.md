# boxboxbox-mrb   [![Build Status](https://travis-ci.org/eva/boxboxbox-mrb.svg?branch=master)](https://travis-ci.org/eva/boxboxbox-mrb)
BoxboxboxMrb class
## install by mrbgems
- add conf.gem line to `build_config.rb`

```ruby
MRuby::Build.new do |conf|

    # ... (snip) ...

    conf.gem :github => 'eva/boxboxbox-mrb'
end
```
## example
```ruby
p BoxboxboxMrb.hi
#=> "hi!!"
t = BoxboxboxMrb.new "hello"
p t.hello
#=> "hello"
p t.bye
#=> "hello bye"
```

## License
under the MIT License:
- see LICENSE file
