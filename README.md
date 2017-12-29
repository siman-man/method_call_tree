[![Build Status](https://travis-ci.org/siman-man/method_call_tree.svg?branch=master)](https://travis-ci.org/siman-man/method_call_tree)

# MethodCallTree

MethodCallTree is like tree command for method call stack.

## Installation

```ruby
gem 'method_call_tree'
```

## Usage

```ruby
require 'method_call_tree'

class Foo
  def foo
    bar
    baz
  end

  def bar
  end

  def baz
    hoge
  end

  def hoge
  end
end

tree = MethodCallTree.create do
  Foo.new.foo
end

puts tree
```

result

```
Foo::foo
├───── Foo::bar
└───── Foo::baz
        └───── Foo::hoge
```

`args` options enable

```ruby
require 'method_call_tree'
def fibonacci(a = 1, b = 0)
  return if a > 10
  fibonacci(a + b, a)
end

tree = MethodCallTree.create(args: true) do
  fibonacci
end

puts tree
```

result

```
Object::fibonacci(a = 1, b = 0)
└───── Object::fibonacci(a = 1, b = 1)
        └───── Object::fibonacci(a = 2, b = 1)
                └───── Object::fibonacci(a = 3, b = 2)
                        └───── Object::fibonacci(a = 5, b = 3)
                                └───── Object::fibonacci(a = 8, b = 5)
                                        └───── Object::fibonacci(a = 13, b = 8)
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MethodCallTree project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/siman-man/method_call_tree/blob/master/CODE_OF_CONDUCT.md).
