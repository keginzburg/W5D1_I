# Resizing Int Set Part 2

Let's find a way to let k grow proportionally to n.

```rb
{ 1,4,6,3,8,9,11 }

[ Bucket0: 4, Bucket1: 1, Bucket2: 6, Bucket 3: 3 ]

k = 4
n = 4
```

* The moment we insert the 5th element, n overtakes k! This should trigger a resize! We want to increase k to overtake n. 
* Let's make a new array with 5 buckets.
* We need to re mod every element by 5 though and add elements back to their appropriate bucket.

```rb
1 % 5 == 1
4 % 5 == 4
6 % 5 == 1
3 % 5 == 3
8 % 5 == 3

[ Bucket0: [] , Bucket1: [1, 6], Bucket2: [], Bucket3: [3, 8], Bucket4: [4]  ]
```

* For insertion, this is not great.
* For each element I insert, I need to remod all previous elements into their new buckets.
* `O(n)`
* The advantage here though will keep k and n in lockstep.
* `k` will increase as `n` increases. The average number of things in each bucket will be n/k or in this case, n/n or 1. This will keep time complexity constant.
* k is greater than or equal to n at all times.

n/k <= 1

For include?:
* This is `O(1)`.

For delete:
* This is `O(1)`.
    * If we want to delete 6 from our Set, then we mod 6 by 5, which gives us 1.
    * We check `Bucket1` and then go through every element in `Bucket1` and delete element 6. If we delete it, it takes time proportional to every element in the bucket, but we know every bucket's length is on average <= 1. So this is very fast. Deletion is Constant or O(1).

For insertion:
* This is `O(n)`. This is still not great. How can we achieve fast insertion?

## Fast Insertion

* As soon as we insert a new element, I have to build a new bucket and remod everything according to their appropriate bucket.

* Could we do more work in advance?

* What if I added 3 new buckets for each added element?
* In this case, if we insert three elements in a row:

```rb
# n is number of elements in our Set
# k is number of buckets in our Set

n=5
k=5

# Upon adding a new element, we need to create three new buckets and then remap our elements from their original buckets into the new buckets. This is O(n).
n=6
k=8 

# Upon adding a new element, we can simply mod our new element into its correct bucket. This is O(1).
n=7
k=8

# Upon adding a new element, we can simply mod our new element into its correct bucket. This is O(1).
n=8
k=8
```

* For every three insertions, we trigger O(n) + O(1) + O(1). The O(n) was necessary to get the "free" O(1) available. This is basically n/3 + n/3 + n/3. On average, each of these pushes will be linear still. Additionally, bucket pushes will just change our denominator and reduce our speed to O(n).

* This is still not keeping pace. We need `O(n)` free pushes to compensate against `O(n)` work of remapping our Set's elements.

## Each Time We Resize

* Each time we resize, an `O(n)` push, we should add the number of the free pushes, proportional to `n`.

* For each insertion, we double our amount of buckets which accounts for the addition of ``O(1)*n`` free pushes. However, we need to mod each element in our collection and add them to their corrected bucket, which is the ``O(n)`` operation. So the time complexity of our number of elements in our collection is ``O(n) + O(1)*n``. We can still compare this to the number of buckets we have added for each addition, which is just the doubling of buckets, or ``2n``. So, our number of elements over number of buckets comparison, or ``n/k`` will be:

`(O(n) + O(1)*n)/2n`

* This then bases down to ``n+1/2n`` or ``n/2n`` or ``1/2``. This will have constant time complexity on average! By inserting elements, the our number of buckets will approach infinity faster than the number of elements we keep adding.
 
* If we can get the number of free pushes to grow, then it will compensate! This is `amortizated` O(1)!

* Amortization refers to a finance concept in which you pay a large sum of money up front and then don't need to pay additional fees until way later on. You live off of your initial investment.

* Additionally, our Space Complexity is `O(n)` because the number of buckets scales with the number of elements.

* Pathological Dataset refers to the clumping of Integers that we're clumped together in `Bucket0`.