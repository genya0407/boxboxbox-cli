##
## BoxboxboxMrb Test
##

assert("BoxboxboxMrb#hello") do
  t = BoxboxboxMrb.new "hello"
  assert_equal("hello", t.hello)
end

assert("BoxboxboxMrb#bye") do
  t = BoxboxboxMrb.new "hello"
  assert_equal("hello bye", t.bye)
end

assert("BoxboxboxMrb.hi") do
  assert_equal("hi!!", BoxboxboxMrb.hi)
end
