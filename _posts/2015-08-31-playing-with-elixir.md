---
layout: post
title:  Playing with Elixir
date:   2015-08-31 19:02:24
categories: elixir
---

Well I did a crap job about keeping up with this blog. Almost 5 months have gone by... I haven't been doing nothing, though. I have been refactoring a CLI framework written in node that I started many months ago. But the past few days I have really been distracted by Elixir.

Im a complete n00b with functional programming so it has really been a major shift. But after a couple hours of messing around in **iex** and reading the docs I decided to dive right in.

I decided that I was going to attempt to copy all of the Array methods from [Underscore.js](http://underscorejs.org) and create a Elixir module to be used with Lists. I am fully aware of the **List** module, but that's not the point. I wanted to try to recreate the functionality in these methods using only basic Elixir code, pattern matching and a whole lot of recursion. Even though Elixir has `case`, `cond` and `if` I wanted to focus on pattern matching (the concept that pulled me into Elixir).

So far I have the first 4 Array methods from Underscore.js `first`, `initial`, `rest`, `compact` as well as two helper functions `reverse` and `length`. You can see my progress [here](https://github.com/connormckelvey/learning-elixir) as I continue to add functions, a readme and some tests. I won't go into all of these but I do want to go into the one I had the most difficulty with: `initial`. And Hey! I've only been messing with Elixir (and FP) for 3 days, so thats allowed. Feel free to stop reading this post now.

###Linked Lists
Coming from a Javascript background I think of Arrays when I think of linked lists (even though I should think of tuples ). Lists in FP are similar to Arrays in Object Oriented languages, in that they are well... lists with multiple values. However Arrays in Javascript, for example, are still Objects, and they inherit the Array prototype, so you get all sorts of helpful properties and methods that make manipulating the array and retrieving information about the array much easier.

You don't get that in Elixir or really any other functional programming language. You can use the List module that comes with Elixir, but that's no good for learning functional programming.

A linked list is basically a value taking up a chunk of memory, pointing to the next value taking up a chunk of memory, pointing to the next chunk of memory, until the last value does't point anywhere else. So when you have a list, you really only know what the first element (also known as head) of the list is. Keep that in mind as I review the `initial` function.

###Intial

If you are not familiar with the `initial` method in Underscores, here is the definition:

_Returns everything but the last entry of the list. Passing **n** will
  return all the values in the list, excluding the last N._

Ok. Onward.


The first two functions are the public functions of my Underscore module

{% highlight elixir %}
def initial(list, n) do
  do_initial list, n
end

def initial(list) do
  do_initial list
end
{% endhighlight %}

Notice how they bot have the same name. In Elixir the first function is actually called `initial/2` and the second is called `initial/1`, where the appropriate function is called depending on the number of arguments being passed in. I'll take this simplicity over an `if/else` block any day.

To test my function I open **iex** and run `iex> Underscore.initial([1,2,3,4,5])`. (And because I am an amazing developer, it returns _1_.)  Before _1_ is returned, `initial` takes the input and passes it on to the `do_initial` private functions (notice `defp`).

{% highlight elixir %}
defp do_initial([]) do
  nil
end

defp do_initial(list) do
  [head | tail] = reverse list
  reverse(tail)
end
{% endhighlight %}

But wait, there are two functions now with the same name, and same arity. This is where pattern matching really comes into play. All Elixir wants is peace and balance, so from many aspects of that language it is just try to match patterns to attain that balance. The first function listed does only take one argument but pattern matching allows us to check for an empty list. So the list will only be passed in if its empty.

So upon calling `Underscore.initial([1,2,3,4,5])` the list gets passed to:

{% highlight elixir %}
defp do_initial(list) do
  [head | tail] = reverse list
  reverse(tail)
end
{% endhighlight %}

Two new variables are created inside the function, `head` and `tail` which are then equated to the list after it has been passed through the `reverse` function. As I said earlier, Elixir only knows the first element of a List, and in `initial` we want a new list with some stuff knocked off the end. That in addition to the fact that Elixir wants to balance the equation `[head|tail] = [5,4,3,2,1]`, the only outcome could be `head` which would be return to `5` and `tail` which would return `[4,3,2,1]`, the remainder of the list. I then reverse `tail` in order to return a new list where the last element has been removed: `[1,2,3,4]`.

I also added the `initial/1` function with a condition to catch empty lists. Elixir throws and error when you try to get the head or tail of an empty list so I decided to return a falsey value, in this case `nil`.

{% highlight elixir %}
defp do_initial([]) do
  nil
end
{% endhighlight %}

In the case that we wanted to get a new copy of the list without the last **n** elements we would call: `Underscore.initial([1,2,3,4,5], 2)`. And yet again do to my special set of skills, we get `[1,2,3]`.

The `initial/2` function passes on `list` and `n` to:

{% highlight elixir %}
defp do_initial(list, n) do
  [head | tail] = reverse list
  do_initial reverse(tail), n - 1
end
{% endhighlight %}

Hear, `head` and `tail` are created from the reversed list and then `do_initial` calls itself passing in reversed tail and a number 1 less than `n`. This will continue until some other pattern is matched. `head` and `tail` are created from the new, shorter, reversed list and then `do_initial` calls itself again.

Because this function is recursive we need function that will stop the recursion and return the value we actually want.

{% highlight elixir %}
defp do_initial(list, 0) do
  list
end
{% endhighlight %}

When the second parameter is equal to zero, `do_inital/2` returns our new list that is missing the last **n** elements.

Success!
