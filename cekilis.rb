require 'json'

file = File.read('./path/json_file.json')
insta = JSON.parse(file)
data = insta['GraphImages'][0]['comments']['data'].map{ |i| i['owner']['username'] }

winners = []
1.upto(35).each do |i|
  winners << find_winners(data, winners)
end

puts 'Kazananlar: '
puts winners

def find_winners(data, winners)
  wnrs = rand(0..data.size - 1)
  return find_winners(data, winners) if winners.include?(data[wnrs])

  data[wnrs]
end
