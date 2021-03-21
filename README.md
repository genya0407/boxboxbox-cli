# Boxboxbox CLI

## How to use

```shell
$ rake
# => generates ./mruby/bin/boxboxbox
$ cp some_image.jpg input_images/
$ ./mruby/bin/boxboxbox
# => generates csv file
```

## Build for windows

```shell
$ MRUBY_CONFIG=build_config_mingw_archlinux.rb rake
# => generates ./mruby/build/cross-mingw/bin/boxboxbox.exe
```
