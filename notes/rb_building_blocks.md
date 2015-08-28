- **Numbers, Operators and Expressions:**
  - What's the difference between an `Integer` and a `Float`?
      An `Integer` represents a decimal whole number. A `Float` represents a 
      real number, as a fractional decimal.

  - Why should you be careful when converting back and forth between integers
  and floats?
    Numbers are truncated, not rounded, when they are converted from integers
    to floats.

  - What's the difference between `=`, `==`, and `===`?
    `=` is the assignment operator, `==` the equality operator. `===` is the case equality operator, but really has nothing to do with equality.

From [StackOverflow](http://stackoverflow.com/a/3422349):
	

    I call #=== the case subsumption operator (it's the best I could come up with, I'm open to suggestions, especially from native English speakers).
    
    The best way to describe a === b is "if I have a drawer labeled a, does it make sense to put b in it?"
    
    So, for example, Module#=== tests whether b.is_a?(a). If you have Integer === 2, does it make sense to put 2 in a box labeled Integer? Yes, it does. What about Integer === 'hello'? Obviously not.
    
    Another example is Regexp#===. It tests for a match. Does it make sense to put 'hello' in a box labeled /el+/? Yes, it does.
    
    For collections such as ranges, Range#=== is defined as a membership test: it makes sense to put an element in a box labeled with a collection if that element is in the collection.
    
    So, that's what #=== does: it tests whether the argument can be subsumed under the receiver.
    
    What does that have to with case expressions? Simple:
    
    case foo
    when bar
      baz
    end
    
    is the same as
    
    if bar === foo
      baz
    end


- **Strings:**
	- What's the difference between single and double quotes?
	- What is string interpolation?
	- What are escape characters?
	- What are line breaks?
	- How do you make other things into strings?
	- How do you concatenate strings?
	- How do you access a specific character or substring?
	- How do you split up strings into arrays?
	- How are strings and arrays similar?
	- How do you get and clean up user input on the command line?
	- What does it mean that strings are "mutable" and why care?
	- What is a symbol?
	- How is a symbol different from a string?
	- What is a Regular Expression (RegEx)?
	- How can you center or right-justify a string?
	
- **Arrays:**
	- What are three ways to create an array?
	- How do you prepopulate the array with default data?
	- How do you access items in an array?
	- How do you combine arrays?
	- How do you find the values in one array that aren't in another?
	- How do you find values in both arrays?
	- What is the difference between `push`/`pop` and `shift`/`unshift`?
	- What is the shovel operator?
	- How is `> arr.pop` different from `> arr[-1]`?
	- How is `push`ing or `<<`ing another array into your array different from just adding them together?
	- How do you delete items in an array?
	- Why should you be careful deleting items in an array?
	- How can you convert arrays to strings?
	- How can you convert from other data types to arrays?
	- How can you figure out if an array contains a particular value?
		The `include` method
	- How do you find the biggest item in an array?
		The `max` method
	- How do you find the smallest item in an array?
		The `min` method
	- How do you remove duplicates from your array?
	- How do you find out how big an array is?
	- How do you put an array in order?
		The `sort` method
	- What are the naming conventions for arrays?
	- What should you store in arrays?
- **Hashes:**
	- What is a hash?
	- What are keys and values?
	- How is a hash different from an Array?
	- How is a hash similar to an Array?
	- What are 3 ways to create a hash?
	- What is the hash rocket?
	- How do you access data in a hash?
	- How do you change data in a hash?
	- What types of data are good to store in a hash?
	- What are options hashes?
	- How do you delete data from a hash?
	- How do you add hashes together?
	- How do you list out all the keys or values?
	- How do you see if the hash contains a key or value?
		The `has_key?` and `has_value?` methods? The `include?` method is equivalent to `has_key?`
	- What is a set?

- **Dates and Times:**
	- How do you get the current date and time?
	- How do you find just the year? Month? Hour? Second? Weekday?
	- How do you create a `Time` specifically for 12/25/2013?
	- How do you find how many days have passed between two `Time`'s?
	- What's the difference between UTC and GMT and Local times?
	- How would you find out the time that was 100 seconds ago? 10 days ago?

- **Other Random Stuff:**
	- What is `nil`?
	- How do you check if something is `nil`?
	- What's the difference between `nil` and `blank` and `empty`?
	- Are the following `nil` or `empty`?
		`" "`, `""`, `[]`, `[""]`, `{}`
	- What's the difference between `puts` and `p` and `print`?
	- What does `inspect` do?
	- What do `+=`, `-=`, `*=` and `/=` do?
	- What is parallel assignment?
	- What's the easiest way to swap two variable?
		```:pref
		x ^= y
		y ^= x
		x ^= y
		```
		for integers
		or using a temporary variable

