# Resizing Set Int Part 1

What if we resize the set? What if we made it a fixed size and worked around that constraint?

```rb
# fixed of 4
[_,_,_,_]

# the elements we have
{1, 4, 6, 64, 128, 129}
```

We have 4 slots but 7 elements, so what can we do? We'll need to double down. Each index will be a bucket.
We need to map these elements into specific buckets and query the buckets for an element.
We need to deterministically decide which bucket they go into.

```rb
[Bucket 1, Bucket 2, Bucket 3, Bucket 4]
```

We can use the ``modulo`` operator!

1 % 4 -> 1
6 % 4 -> 2
(0..n)

If we take each of our values and mod them by the number of buckets, we can decide which bucket they go into.

```rb
[ Bucket 1: 4, 64, 128, Bucket 2: 1, 129, Bucket 3: 6, Bucket 4]

# to look up 6, we could mod it by 4, which tells us bucket 2, then scan bucket 2 and see if 6 is included.
# to delete, we can scan and then remove from a bucket.
# to add, we can scan and if it does not exist, then add it to the bucket.
```

This set is fixed size. We could evaluate 10^20 and mod that by 4 which should allow us to add it to bucket 0.

What is the asymptotic time complexity here though?

## Time Complexity

For include?:
We mod our element which is O(1), and then we need to search our bucket. How many things on average will be in our bucket? If we have k buckets, then it should be n/k elements on average in each bucket. In our case, it should be n/4 or O(n). So now our include is just O(n) time complexity.

For insert:
Because of our duplicate case, it is also O(n) because we need to scan each bucket.

For delete:
Same thing again, O(n).

We're getting linear behavior again. This is no better.

While the time complexity is n/k, k is fixed, but n has the ability to still reach infinity. What if we could have k grow with n? Then it might reach n/n or O(1). We want n and k to compete in tandem.