require 'benchmark'

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
