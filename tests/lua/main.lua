-- comment 1
-- comment 2
-- comment 3
global_table = {
  1, 2, 3, 4, 5
}

local function test_variables()
  local number = 3
  local string = "ghi"

  local function foo()
    local foo_number = 2
    local foo_string = "def"

    local function bar(a, b)
      local bar_nil
      local bar_boolean = true
      local bar_number = 1
      local bar_vector = vector.create(100, 200, 300)
      local bar_string = "abc"
      local bar_table = {
        a = 1,
        b = 2,
      }
      local bar_array = {}
      for i = 1, 10000 do
        bar_array[i] = i
      end
      local bar_nested_table = {
        a = 1,
        b = 2,
        c = {
          d = 3,
          e = 4,
          f = {
            g = 5,
            h = 6,
          }
        }
      }
      local table_with_circle = {
        a = 1,
        b = {
          c = 2,
        },
        e = {
          f = 3
        }
      }
      table_with_circle.b.d = table_with_circle
      table_with_circle.e.g = table_with_circle.b

      local userdata = {}
      setmetatable(userdata, {
        __iter = function(x)
          return next, table_with_circle
        end
      })

      local table_with_getter = {}
      setmetatable(table_with_getter, {
        __tostring = function() return "table_with_getter" end,
        __getters = {
          a = function()
            return 1
          end,
          b = function()
            return 2
          end
        }
      })

      local multi_line_string = [[
        hello
        world
      ]]

      local bar_function = function() end
      foo_string = "ghi"
      print("Hello, World!")
      print(foo_string, foo_number)
    end

    bar(500, 600)
  end

  foo()
end

local function foo()
  local a = 1
  local b = 2
end

local function bar()
  local c = 3
  local d = 4
end

local function test_step()
  foo()
  bar()
  foo()
  bar()
end

local math = require("./math/math")

local function test_coroutine()
  local v = vector.create(1, 2, 3)
  local test_coroutine = coroutine.create(function()
    print("coroutine start")
    local a = 1
    local b = 2
    local c = { a, b, "hello coroutine" }
    local function co2()
      local foo = "hello"
      coroutine.yield()
      print(foo)
    end

    local co2_instance = coroutine.create(co2)
    coroutine.resume(co2_instance)
    local d, e = coroutine.yield(a, b, c)
    print("coroutine resume", d, e)
  end)

  local a, b, c = coroutine.resume(test_coroutine)
  print("coroutine yield", a, b, c)
  coroutine.resume(test_coroutine, 3, 4)

  -- test coroutine.wrap
  local co = coroutine.wrap(function()
    print("coroutine wrap")
  end)
  co()
end


local function test_math()
  local add = math.add
  local sub = math.sub
  local mul = math.mul
  local a = 1
  local b = 2
  print("add", add(a, b))
  print("sub", sub(a, b))
  print("mul", mul(a, b))
end

local function test_error()
  -- error should output to debug console
  -- abc.def()
end

local function test_assert()
  -- assert(nil, "this is a nil assert")
end

local function test_print()
  local number = 3.1415
  local string = "hello world"
  local v = vector.create(1, 2, 3)
  print(number)
  print(string)
  print(vector)
  print(number, string, vector)
end

local function test_condition()
  for i = 1, 10 do
    print(i)
  end
  local str = "hello, debugger"
  for i = 1, #str do
    local a = string.sub(str, 1, i)
    print(a)
  end
end

local function test_self()
  local mt = {
    base = 100,
  }
  function mt:add(a)
    self.base = self.base + a
    print(self.base)
  end

  mt:add(300)
  mt:add(200)
end

local function test_break_from_code()
  debug.break_here()
end

local function test_table_with_number_and_string_keys()
  local table_with_number_idx = {
    [1] = 1,
    [2] = 2,
    ["1"] = 2,
    [100] = 100,
    ["100"] = 200,
  }
  print(table_with_number_idx)
end

local function test_metatable()
  local mt = {
    __index = {
      a = 1,
      b = 2,
    }
  }
  local t = {
    c = 3
  }
  setmetatable(t, mt)
  print(t.a)
  print(t.b)
end

local function main()
  test_variables()
  test_step()
  test_coroutine()
  test_math()
  test_print()
  test_error()
  test_assert()
  test_condition()
  test_self()
  test_break_from_code()
  test_table_with_number_and_string_keys()
  test_metatable()
  print('=============================================')
end

main()


-- while true do
--   main()
-- end
