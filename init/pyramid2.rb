height = ARGV[0]
height = height.to_i
space = height-1
output = ""
height.times do |i|
  output << " " * (space - i)
  output << "*" * ((i+1)*2)
  output << " " * (space - i)
  output << "\n"
end
puts output