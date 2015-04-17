---
layout: post
title:  Overview of ES6 String Templates
date:   2015-04-16 19:02:24
categories: es6
---
Javascript string templates are a new feature of ECMAScript 6. They bring new (and long sought after) features to string such as variable (and expression) interpolation, white-space preservation and template tagging.

There are some syntactical differences with string templates compared to POS (plain ol' strings). 

###String Interpolation with Variables
This is perhaps the coolest feature of string templates. String interpolation has been available in languages such as Ruby and PHP for as long as I have been programming. 

Before ES6, constructing dynamic string for delivering messages to users or debugging, JS developers had to concatenate strings and variables like this:

{% highlight js %}
let name = "Connor";
let message = "Good Morning " + name + ", would you like some coffee?";
console.log(message);
//Good Morning Connor, would you like some coffee?
{% endhighlight %}   

Obviously the above example is a pain to write, but it is even more of a pain to read. We have the start of a string, that has to include a space before the closing quote, another space (for enhanced readability) the variable and so on. 

Let's take a look at how we can achieve the same result using string templates.

{% highlight js %}
let name = "Connor";
let message = `Good Morning ${name}, would you like some coffee?`;
console.log(message);
//Good Morning Connor, would you like some coffee?
{% endhighlight %} 

Compared to the ES5 way, the ES6 example saved us 5 keystrokes, but it also has the more important benefit of enhanced readability. 

It is important to notice how the `message` string is wrapped in backticks. Backticks are required when using string templates. Without them you do not get access to any of the great new features available.

Also note how the `name` string is still wrapped in quotes. The above code would would perfectly fine if I had wrapped it in backticks, but using quotes for strings that do not include string interpolation is a nice way to let other developers know that they do not need to scan the string for expressions that will later be evaluated.

###Evaluating Expressions in Strings
Not only can we pass a variable into the string template, but we can pass an expression. We can do something as simple as adding 2 number or get a little more fancy and include a date into our string.

{% highlight js %}
let name = "Connor";
let a = 10;
let b = 20;
let message = `Good Morning ${first}, would you like ${a + b} cups of coffee?`;
let time = `What time is it? It is ${new Date().getHours()}:${new Date().getMinutes()}.`
console.log(message);
console.log(time);
//Good Morning Connor, would you 30 cups of coffee?
//What time is it? It is 21:24.
{% endhighlight %}  

###Whitespace Preservation
ES6 templates preserve all whitespace. So it is important to remember this when trying to break up a string onto multiple lines. If you are trying to keep your lines of code within the 80 character guide, you still need to escape the new line character or concatenate multiple other strings over multiple lines like you would with a normal string.

{% highlight js %}
let message = `It is
    A
New Line
            It is
    A 
  New Day
`;
console.log(message);
//It is
//    A
//New Line
//            It is
//    A 
//  New Day
{% endhighlight %}

###Tagged Template Strings
With tagged templates you can use a function to modify the output of a string. This could be useful when you need to modify part of the message being displayed to the user based on some condition, such as a time of day. We do this by creating a function with two arguments, the strings and the values to be evaluated or manipulated. We then alter the first item of the values array based on where or not it is before or after 12. Finally we return a reconstructed string template.

{% highlight js %}
function tag(strings, ...values) {
    if(values[1] >= 12) {
        values[0] = "Afternoon";
    } else {
        values[0] = "Morning";
    }
  
  return `${strings[0]}${values[0]}${strings[1]}${values[1]}${strings[2]}${values[2]}`
}

let message = tag`Good ${""} Connor, the current time is ${new Date().getHours()}:${new Date().getMinutes()}.`
console.log(message);
//Good Afternoon Connor, the current time is 21:40
{% endhighlight %}

Notice how when passing the string template into the tag function we are not using parentheses. Attempting to pass the template into a function with parentheses will not through an error, but it will produce undesired results.

Obviously there is probably a more efficient way of reconstructing the string template that is to be evaluated, but that probably deserves its own blog post.



