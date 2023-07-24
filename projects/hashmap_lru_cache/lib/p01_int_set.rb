class MaxIntSet
  attr_reader :store

  def initialize(max)
    @store = Array.new(max) { false }
  end

  def insert(num)
    self.validate!(num)
    @store[num] = true
  end

  def remove(num)
    self.validate!(num)
    @store[num] = false
  end

  def include?(num)
    self.validate!(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num.between?(0, @store.length)
  end

  def validate!(num)
    raise 'Out of bounds' unless self.is_valid?(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return if self.include?(num)
    self[num] << num
  end

  def remove(num)
    return unless self.include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful
    # return the bucket corresponding to `num`
    @store[num%self.num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    return if self.include?(num)
    self[num] << num
    @count += 1
    self.resize! if @store.length < self.count
  end

  def remove(num)
    return unless self.include?(num)
    self[num].delete(num)
    @count -= 1
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = self.store

    @count = 0
    @store = Array.new(num_buckets * 2) { Array.new }

    old_store.flatten.each { |el| self.insert(el) }
  end

  def [](num)
    # optional but useful
    # return the bucket corresponding to `num`
    @store[num%self.num_buckets]
  end
end