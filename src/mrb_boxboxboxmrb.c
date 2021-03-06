/*
** mrb_boxboxboxmrb.c - BoxboxboxMrb class
**
** Copyright (c) Yusuke Sangenya 2021
**
** See Copyright Notice in LICENSE
*/

#include "mruby.h"
#include "mruby/data.h"
#include "mrb_boxboxboxmrb.h"

#define DONE mrb_gc_arena_restore(mrb, 0);

typedef struct {
  char *str;
  mrb_int len;
} mrb_boxboxboxmrb_data;

static const struct mrb_data_type mrb_boxboxboxmrb_data_type = {
  "mrb_boxboxboxmrb_data", mrb_free,
};

static mrb_value mrb_boxboxboxmrb_init(mrb_state *mrb, mrb_value self)
{
  mrb_boxboxboxmrb_data *data;
  char *str;
  mrb_int len;

  data = (mrb_boxboxboxmrb_data *)DATA_PTR(self);
  if (data) {
    mrb_free(mrb, data);
  }
  DATA_TYPE(self) = &mrb_boxboxboxmrb_data_type;
  DATA_PTR(self) = NULL;

  mrb_get_args(mrb, "s", &str, &len);
  data = (mrb_boxboxboxmrb_data *)mrb_malloc(mrb, sizeof(mrb_boxboxboxmrb_data));
  data->str = str;
  data->len = len;
  DATA_PTR(self) = data;

  return self;
}

static mrb_value mrb_boxboxboxmrb_hello(mrb_state *mrb, mrb_value self)
{
  mrb_boxboxboxmrb_data *data = DATA_PTR(self);

  return mrb_str_new(mrb, data->str, data->len);
}

static mrb_value mrb_boxboxboxmrb_hi(mrb_state *mrb, mrb_value self)
{
  return mrb_str_new_cstr(mrb, "hi!!");
}

void mrb_boxboxbox_mrb_gem_init(mrb_state *mrb)
{
  struct RClass *boxboxboxmrb;
  boxboxboxmrb = mrb_define_class(mrb, "BoxboxboxMrb", mrb->object_class);
  mrb_define_method(mrb, boxboxboxmrb, "initialize", mrb_boxboxboxmrb_init, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, boxboxboxmrb, "hello", mrb_boxboxboxmrb_hello, MRB_ARGS_NONE());
  mrb_define_class_method(mrb, boxboxboxmrb, "hi", mrb_boxboxboxmrb_hi, MRB_ARGS_NONE());
  DONE;
}

void mrb_boxboxbox_mrb_gem_final(mrb_state *mrb)
{
}

