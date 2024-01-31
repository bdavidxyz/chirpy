require 'benchmark'

def max
  10
end

def loop_array
  array = (1..100000).map { rand }
  x = 1
  loop do
    p x
    x += 1
    break if x > max
  end
end

def while_array
  array = (1..100000).map { rand }
  x = 1
  while true
    p x
    x += 1
    break if x > max
  end
end

time = Benchmark.realtime do
  x = 1
  loop do
    x += 1
    break if x > 100
  end
end
puts "loop took #{time} seconds."

time = Benchmark.realtime do
  x = 1
  while true
    x += 1
    break if x > 100
  end
end
puts "while took #{time} seconds."


Benchmark.bm do |benchmark|
  benchmark.report("loop.") do
    x = 1
    loop do
      x += 1
      break if x > 100
    end
  end
 
  benchmark.report("while") do
    x = 1
    while true
      x += 1
      break if x > 100
    end
  end
end

puts Benchmark.measure {
  50_000.times do
    x = 1
    loop do
      x += 1
      break if x > 100
    end
  end
}

puts Benchmark.measure {
  50_000.times do
    x = 1
    while true
      x += 1
      break if x > 100
    end
  end
}