require "pry"

# this should, you know, be secret
KEY = 8.freeze

# intentionally mutable so they can be rotated
OUTER = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]
INNER = %w[A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]

NUMBERS = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25].freeze

def rotate_to!(pos)
  OUTER.rotate!((OUTER.length-pos))
end

def encode(string, key, rotate: true)
  rotate_to! key

  upper = string.length-1
  (0..upper).each_with_object("") do |index, encoded|
    letter = string[index]
    lookup_pos = OUTER.index(letter.upcase)

    if  lookup_pos == nil
      encoded << letter
      next
    end

    encoded << INNER[lookup_pos]
  end
end

def decode(string, key, rotate: true)
  rotate_to! key if rotate
  upper = string.length-1

  (0..upper).each_with_object("") do |index, encoded|
    letter = string[index]
    lookup_pos = INNER.index(letter.upcase)

    if  lookup_pos == nil
      encoded << letter
      next
    end

    encoded << OUTER[lookup_pos]
  end
end

encoded = encode("Hello world", KEY)
puts "encoded: #{encoded}"
puts "decoded: #{decode(encoded, KEY, rotate: false)}"