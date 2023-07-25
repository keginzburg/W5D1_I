class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if self.include?(key)
    hashed_key = key.hash
    self[hashed_key] << key
    @count += 1

    self.resize! if self.num_buckets < self.count
  end

  def include?(key)
    hashed_key = key.hash
    self[hashed_key].include?(key)
  end
  
  def remove(key)
    return unless self.include?(key)
    hashed_key = key.hash
    self[hashed_key].delete(key)
    @count -= 1
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store

    @store = Array.new(num_buckets*2) { Array.new }
    @count = 0

    old_store.flatten.each { |key| self.insert(key) }
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num%self.num_buckets]
  end
end