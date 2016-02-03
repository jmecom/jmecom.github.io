---
layout: post
title: "First class functions (in Python)"
date: 2015-08-08
tags: [python, functional programming, functions, virtual6502]
---

Functions are first-class citizens in Python. This means that functions can be stored in variables and used
anywhere you would reference a variable. While Python isn't a functional programming (FP) language, it does support some
FP features - first-class functions being one of them. It turns out that this feature is very useful, even in
object-oriented programs. I'll show some simple examples followed by an application of first-class functions
that I've used in a hobby project. But first let's take a look at some basic uses.

Lets define some functions.
{% highlight python %}
def foo(x):
    print('Foo: ' + str(x))

def bar(y):
    print('Bar: ' + str(y))
{% endhighlight %}

You can save functions to variables, and call them from those variables.
{% highlight python %}
f = foo
f(3)
# Output
# Foo: 3
{% endhighlight %}

You can store functions in data structures, such as lists.
{% highlight python %}
l = [1, 2, 3, f, foo]
for e in l:
    print(e)
# Output
# 1
# 2
# 3
# <function foo at 0x107120c80>
# <function foo at 0x107120c80>
#
# Note, same address
{% endhighlight %}

You can also call functions from data structures. In this example, the value at each
key is a function. So, you can mentally replace `d[k]` with `foo` or `bar`, and append
the parens + argument(s), just like a normal function call.
{% highlight python %}
d = { 'apple': foo, 'pie': bar }
for k in d.keys():
    d[k]('Note the syntax')
# Output
# Foo: 'Note the syntax'
# Bar: 'Note the syntax'
{% endhighlight %}

Lastly, you can pass functions as arguments to other functions.
{% highlight python %}
>>> def map(list, func):
...     return [func(e) for e in list]
...
>>> map([1, 2, -3, 4, -3], abs)
[1, 2, 3, 4, 3]
{% endhighlight %}

That covers some of the uses of first-class functions. How can we use them in our
real programs though? Lets take a look at a use-case I found while implementing Virtual6502.

### An application - Virtual6502
Virtual6502 emulates the NES' 6502 CPU. To do this, it must implement each instruction in the
6502's instruction set. I chose to implement each instruction as its own function.
Now, each instruction has an `opcode`, which is just a number that corresponds to it.

CPUs work on a fetch and execute cycle, which goes like this:
1. The value at the memory address stored in the Program Counter (a special register in a CPU)
is saved.
2. That value, which contains an opcode and 'arguments' to the instruction, is decoded.
3. The address from the decoded value is read.
4. The instruction is executed.

As you can see, instructions need to be looked up and executed very often in a CPU, so we want
constant-time access. How can we achieve this? Well, we implemented each instruction as a separate
function, and each instruction has a number associated with it (its opcode). We have all the tools
at our disposal to easily solve this problem. Just put the instruction functions in a big list, with
each instruction at the index of its opcode!

For an example, suppose we had a CPU with just two instructions: `A` and `B`, with opcodes
`0` and `1` respectively. Then we can do the following:
{% highlight python %}
def A(args):
    # Do the stuff specified by the A instruction
    # ...

def B(args):
    # Do the stuff specified by the B instruction
    # ...

instruction_functions = [A, B] # A at 0, B at 1

# Later, in our fetch and execute cycle, we can get
# the opcode and arguments, and then execute the instruction:
instruction_functions[opcode](args)
{% endhighlight %}

The solution turns out to be simple and readable!
