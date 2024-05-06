class HashMap
  LOAD_FACTOR = 0.75
  OVERLOAD_LIMIT = 2
  
  def initialize(size = 8)
    @buckets = []
    size.times {@buckets.push([])}
    @size = size
    @load = 0.0
    puts @buckets
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
    hash_code
  end

  def set(key, value)
    @load += 1 unless has?(key)
    check_load(key)
    #puts "Buckets : #{@buckets}"
    @buckets[get_bkt(key)] << [key, value]
    puts "Bucket #{get_bkt(key)} : #{@buckets[get_bkt(key)]}"
  end

  def get(key)
    @buckets[get_bkt(key)].each { |k, v| return v if k == key }
    nil
  end

  def has?(key)
    @buckets[get_bkt(key)].each  { |k, v| return true if k == key }
    false
  end

  def length
    @load
  end

  def clear
    @buckets.each { |entry| entry = [] }
  end

  def remove(key)
    return nil unless has?(key)
    @buckets[get_bkt(key)].map! do |k, v|
      if k == key 
        k = nil
        v = nil
      end
    end
    @load -= 1
  end

  def keys
    keys_arr = []
    @buckets.each { |bucket| bucket.each { |entry| keys_arr << entry[0] }}
    keys_arr.compact
  end

  def values
    values_arr = []
    @buckets.each { |bucket| bucket.each { |entry| values_arr << entry[1] }}
    values_arr.compact
  end

  def entries
    entries_arr = []
    @buckets.each { |bucket| bucket.each { |entry| entries_arr << entry }}
    entries_arr.compact
  end

  def get_bkt(key)
    bucket_num = hash(key) % @size
    #puts "#{bucket_num} from #{hash(key)} and #{@size}"
    bucket_num
  end

  def check_load (key)
    load_level = @load / @size
    local_load = @buckets[get_bkt(key)].count
    if  load_level > LOAD_FACTOR || local_load >= OVERLOAD_LIMIT 
      puts "LOAD EXCEEDED (#{load_level}, #{local_load}) => EXPANDING"
      @size.times {@buckets.push([])}
      @size = @size * 2
    end
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
