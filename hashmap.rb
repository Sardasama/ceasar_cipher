class HashMap
  LOAD_FACTOR = 0.75

  def initialize(size = 8)
    @buckets = Array.new(size, [])
    @size = size
    @load = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 19
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    @load += 1 unless has?(key)
    if  @load / @size > LOAD_FACTOR
      puts "!!!!! LOAD EXCEEDED !!!!!"
      @buckets.concat(Array.new(@size, []))
      @size = @size * 2
    end
    @buckets[get_bkt(key)] = [key, value]
  end

  def get(key)
    return unless key == @buckets[get_bkt(key)][0]
    @buckets[get_bkt(key)][1]
  end

  def has?(key)
    @buckets[get_bkt(key)][0] == key
  end

  def remove(key)
    data = get(key)
    if data.nil?
      nil
    else
      puts "TOTO"
      @buckets[get_bkt(key)] = []
      data
      @load -= 1
    end
  end

  def length
    @buckets.count { |k, v| k != nil}
  end

  def clear
    @buckets.each { |_entry| entry = nil }
  end

  def keys
    keys_arr = []
    @buckets.each { |entry| keys_arr << entry[0] unless entry[0].nil? }
    keys_arr
  end

  def values
    values_arr = []
    @buckets.each { |entry| values_arr << entry[1] unless entry[1].nil? }
    values_arr
  end

  def entries
    entries_arr = []
    @buckets.each { |entry| entries_arr << entry unless entry.nil? }
    entries_arr
  end

  def get_bkt(key)
    hash(key) % @size
  end
end

myHM = HashMap.new
myHM.set('domino', 24)
myHM.set('hardcore', 'Hemingway')
myHM.set('nostra', 'DAMUS')
myHM.set('e.coli', ['Escherichia coli', 'noxious'])
myHM.set('Tenancious', 'D')
myHM.set('AC', 'DC')
myHM.set('Cosa', 'Nostra')
myHM.set('american', 'idiot')
myHM.set('passing', 'SHOT')
myHM.set('everything', 'she said')

puts "== ALL ENTRIES =="
puts myHM.entries
puts "== ALL KEYS =="
puts myHM.keys
puts "== ALL VALUES =="
puts myHM.values

puts "== TESTS =="
puts myHM.get("nostra")
puts myHM.has?("nuestra")
puts myHM.length
myHM.remove("passing")
print myHM.entries
puts myHM.length
