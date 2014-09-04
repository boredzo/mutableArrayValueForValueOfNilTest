# mutableArrayValueForValueOfNilTest
## Demonstrates a KVC gotcha you might not have guessed

Let's say you're doing something like this:

    things = [obj mutableArrayValueForKey:@"foo"];

This (as of 10.9.3) will return non-nil, *even if `obj.foo` is `nil`*.

In fact, the value of `obj.foo` (`nil`, non-array, or otherwise) when `mutableArrayValueForKey:` is called is actually immaterial. `mutableArrayValueForKey:` simply always succeeds, and returns a mutable array. As of 10.9.3, the class of this array is `NSKeyValueSlowMutableArray`.

What really matters is the value of `obj.foo` when you try to *use* the KVC mutable array.

If `obj.foo` is not `nil`, but is not an array, the KVC array will send that object messages it doesn't recognize (assuming that it's an array and treating it as such), and you will get a `doesNotRecognizeSelector:` exception.

If `obj.foo` is `nil`, an assertion inside the KVC array's code will fail, and you will get an `NSInternalInconsistencyException`.

Either way, *when you try to use the array*, not when you try to get it.

## TL;DR

It's possible to get a `mutableArrayValueForKey:`, optionally try to use it when the value of the property is an array (not `nil` or another kind of object) and succeed, and then, **sometime later,** try to use the same `mutableArrayValueForKey:` and **get an exception** because the value of the property is no longer an array (is now `nil` or a non-array object).
