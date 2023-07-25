class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash    
    output = 0
    (0...self.length).each do |i|
      curr = self[i]
      curr *= i
      output += curr.hash
    end
    output
  end
end

class String
  def hash
    alphas = ("a".."z").to_a + ("A".."Z").to_a
    output = 0
    (0...self.length).each do |i|
      curr = alphas.index(self[i]) * i
      output += curr.hash
    end
    output
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    alphas = ("a".."z").to_a + ("A".."Z").to_a
    output = 0
    self.each do |k, v|
      curr_k = k.to_s
      first = alphas.index(curr_k)

      curr_v = v
      if curr_v.is_a?(String)
        curr_v = alphas.index(curr_v)
      end

      output += (curr_k * curr_v).hash
    end
    output
  end
end