grid = []
visible = 0

x = 0
y = 0

File.readlines('data.txt', chomp: true).each do |line|
  grid.push(line.split('').map(&:to_i))
end

