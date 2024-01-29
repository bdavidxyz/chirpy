require 'benchmark'

array = (1..100000).map { rand }

time = Benchmark.realtime do
  a = 1
  while true
    puts a
    a += 1
    break if a > 10
  end
end

puts "while took #{time} seconds."

time = Benchmark.realtime do
  a = 1
  loop do
    puts a
    a += 1
    break if a > 10
  end
end

puts "loop took #{time} seconds."
