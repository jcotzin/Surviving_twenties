beatles = [
  {
    name: nil,
    nickname: "The Smart One"
  },
  {
    name: nil,
    nickname: "The Shy One"
  },
  {
    name: nil,
    nickname: "The Cute One"
    },
  {
    name: nil,
    nickname: "The Quiet One"
  }
]

i = 0
while i < beatles.length
  
  case i
  when 0
    beatles[i][:name] = "John"
  when 1
    beatles[i][:name] = "George"
  when 2
    beatles[i][:name] = "Paul"
  when 3
    beatles[i][:name] = "Ringo"
  else
  end
  i += 1
end

i = 0
while i < beatles.length
  puts "Hi, I'm #{beatles[i][:name]}.  I'm #{beatles[i][:nickname]}!"
  i += 1
end