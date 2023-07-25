# Hashing

* Hashing will enable a lot of optimizations.
* A hash function has two ends: an in and out.
* Given an input, a hash function will provide certain outputs.

```rb
10^6
5
"hello"
```

* The outout for any value is randomized "garbage".
* It will have a `base64` encoding (ie. "67Zac99Z12").

* Each output will be of the same fixed length (ie. 256 bits). We're turning them from binary into strings.

## Deterministic

* A hashing function is `deterministic`: every single time we hash a specific input, the output will always be the same. This is a requirement.

## Uniformity

* Any string output is just as likely as any other string output. No two inputs should hash out to the same value; it's possible, but unlikely.

## One-Way (highly sensitive)

* Given the output, there's no way to predict the input. There's no way to go backwards.

```rb
"hello" => HASHING FUNCTION => "7499fgdj3736"
"helloo" => HASHING FUNCTION => "838neojrh9u3"
```

## Two Kinds of Hashing Functions

* `Speed and Efficiency`
    * Cityhash
    * CRC32 (checksums)
        * checksums are used to ensure you've received the correct input 
    * Murmurhash
        * Ruby uses this under the hood

* `Cryptographic`
    * MD5 (deprecated due to weaknesses)
    * SHA-2
    * Blowfish
    
* Cryptographic Hashing functions are slower, have less collisions, and are harder to reverse engineer; all of this is by design.

## Ruby

* For every `Object` in Ruby, there is a `def hash` instance method.
* This will hash that object into a specific output.

```rb
5.hash
"hello".hash
[1,2,3].hash
{1 => "hash"}.hash
```