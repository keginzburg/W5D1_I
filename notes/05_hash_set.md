# Hash Set

* With the help of hashing, we can implement a Set that takes in variable input.

```rb
{2,4,8,16,"hello", "dolly"}

# We should mod the hash of the number

[Bucket0, Bucket1, Bucket2, Bucket3]

# =>

2.hashing_func == 7478478646 % 4 == FIRST
4.hashing_func == 7478478646 % 4 == SECOND
8.hashing_func == 7478478646 % 4 == SECOND
16.hashing_func == 7478478646 % 4 == FOURTH

# => 

[Bucket0: [2], Bucket1: [4, 8], Bucket2: [], Bucket3: [16]]
```

* Upon adding new buckets, we would need to rehash and remod our inputs again.
* Please note that we store the original values in the buckets, not their hashed outputs.

```rb
[Bucket0: [2], Bucket1: [4, 8], Bucket2: [], Bucket3: [16]]

# => 

[Bucket0: ["hello"], Bucket1: [], Bucket2: [4], Bucket3: [2], Bucket4: ["dolly", 8], Bucket5: [], Bucket6: [], Bucket7: [16]]
```

## How are our Cases?

* Following this behavior:
* `include?` is O(1) on average and O(n) at worst.
* `insertion` is O(1) on average and O(n) at worst as well.
* `deletion` is O(1) on average and O(n) at worst as well.

## Set Library

* `require 'set'`
* `Set.new` which implements this Hash Set

## Object#hash

```rb
class Object
    def hash
        self.object_id.hash
    end
end
```

* This is bad since two different mutable types (ie. two Arrays) may be equal but different memory locations. As a result, if they don't have a defined `hash` method, then they will attain different hash outputs.