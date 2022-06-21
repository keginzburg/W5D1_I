# Set

How do we make a HashMap, a fast HashMap: {}
We'll explore other applications built on a HashMap.

## Let's begin by talking about a Set...

A set is an ADT. It consists of objects that can only exist once in the set. No duplicates. A set is also not ordered and can contain different types. There is no first or last element.

All you can do:

``.include?``
``insert``
``delete``

```rb
{1,2,"hi", 0}
```

## A set can be implemented with an array:
```rb
[0, 2, "hi", 2]
```
We could wrap this array within a Set class.
We could push to add an element as long as it doesn't already exist within.
We could also scan for inclusion and then delete from it.
Lastly, we could just scan for inclusion.

For inclusion, the worst case runtime would be O(n).
For insertion, we again have to scan for duplicates, so worst case runtime would be O(n).
For deletion, we again have to scan for inclusion, and then delete, so worst case runtime would be O(n).

Using an array as a Set is not a great implementation.

Is there a more clever way?

## Restrictions

We will use restrictions though.
We can only put values of a certain type:
```rb
{2,1,4,0}
```
With these constraints, what would be a smarter, faster way?

We'll look at a range between the smallest and largest elements.
``0`` --> ``4``

We'll create an array that has five spots to correspond to this range.
```rb
[_,_,_,_,_]
[0,1,2,3,4]
```

What if we initialized this array to have all false values:
```rb
[false, false, false, false, false]
```

And then checked for inclusion for each of our elements. If they exist in our set, then we can set their index position's value to true.
```rb
# 0 --> 4
# {2,1,4,0}

[true, true, true, false, true]
```
Now we have a set that maps onto those integers, and now we can query our set by just taking the index of the element we're looking for.

If we wanted to see if the value of 2 exists in the set, then we can just check ``[true, true, true, false, true][2]``.
Indexing into an array takes 
This is much more efficient.

Underneath the hood, an array is contiguously stored data.
```rb
[3,5,8,10,12]
# RAM | 3 | 5 | 8 | 10 | 12 |->|->|->|->|
       908 916 924 932  940 
```

Your Array knows the @ram_address and the @length

908 is our start address
908 + 8*i in which i is the index we want

If we want 5, we just want 908 + 8*1 == 916
This is known as ``pointer arithmetic``.
This operation is O(1) runtime.
This is what makes Arrays very fast.

## Back to our Set
```rb
[3,5,8,10,12]
# translates to below
[false, false, false, true, false, true, false, false, true, false, true, false, true]

```
If we wanted to insert a value, we can just set the value within the array at that index, which again, is O(1) time.
Checking for inclusion, ``.include?``, will also be O(1) runtime because we jump to that index or place in memory.
Lastly, deletion is also O(1) because we just index to that value at set it to false.

This must be great, right? NO. This is still bad! Why?

1. This is not extensible to floats.
2. With the constraint of integers even, this takes up abysmal space.

## Abysmal Space

What if we wanted a set with only 2 elements:

```rb
{0, 10^20}
```
This array is going to be so arbitrarily large, we don't want this. The space complexity here is O(range) or O(max-min). This is not tenable.