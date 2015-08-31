---
title: "Premise, syntax, and tools"
tags: [program language design, compilers, premise, syntax, tools, yacc, flex]
---

Last week, I aimed to have an idea of the premise of the language, some code samples, and 
research which tools I would use. Lets hop right into a discussion of the premise!

### Premise
The aim of this language is to take the best parts of Javascript and Python, targeting
the web. Given this, the guiding language features will be:

  - Prototypal Inheritance
    - For a great discussion on this, see http://stackoverflow.com/questions/2800964/benefits-of-prototypal-inheritance-over-classical
  - Objects, object literal syntax 
  - First-class functions 
  - Python-esque strong + dynamic type system
  - Python-esque coherent and intuitive standard library

There are certainly languages similar to this - Coffeescript or other compile-to-JS languages may come to mind. However, there are still key differences between what I propose and those languages:
  
  - My compilation target is not JS 
  - I don't aim to add classical inheritance, which most compile-to-JS languages do 
  - Syntax 

At the end of the day, the aim of the language I propose isn't to be innovative. I want to develop an elegant, simple, and sane language for the web. So, lets take a look at some syntax!

### Syntax 
{% highlight python %}
### Some basics
# Some assignments
a = 2
b = 3
c = a + b

# Assign a func to a var
f = func(a) -> print(a)

# Or name it
func say_hello() ->
    print('Hello')

# A for-loop and an array literal
l = [1, 2, 3]
l.each(func(i) -> print(i))

### Prototypal Inheritance Example
one_line_obj = a:1, b:2

Circle =
    init:
        func(radius) ->      
            circle = Object.init(this) # For now, very JS-like
            circle.radius = radius
            return circle
    radius: null
    area: func() -> return 3.14 * radius * radius

a = Circle.init(10)
print(a.area)  # 314

b = Circle.init(5)
print(b.area)  # 78.5
{% endhighlight %}

The syntax will change with time, but the goal is to keep it relatively similar
to the above.

### Tools

Currently, I plan on using C++, Flex for the scanner generator, and Yacc for the parser. 
I've decided to go with these choices because I'm familiar with the tool-chain, there is a lot
of documentation, and they are robust choices that can handle mature languages.  

### Next week's goal
* Come up with a *name* for the language, and retag old posts with the name
* Specify the grammar for a subset of the language
* Stretch - begin work on the scanner
