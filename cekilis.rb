require 'json'

def find_winners(data, winners)
  wnrs = rand(0..data.size - 1)
  return find_winners(data, winners) if winners.include?(data[wnrs])

  data[wnrs]
end

print 'Kullanıcı Adı: '
username = gets.chomp
puts '------------'
print 'Post Kısa Kod: '
shortcode = gets.chomp
puts '------------'
print 'Kazanacak Kişi Sayısı: '
winner_size = gets.chomp.to_i
puts '------------'
print 'Yedek Talihli Sayısı: '
reserve_winner_size = gets.chomp.to_i

file = File.read("./#{username}/#{username}.json")
insta = JSON.parse(file)
data = insta['GraphImages'].select{ |i| i['shortcode'] == shortcode }.first

if data
  data = data['comments']['data'].map { |i| i['owner']['username'] }

  winners = []
  1.upto(winner_size + reserve_winner_size).each do |_i|
    winners << find_winners(data, winners)
  end

  puts 'Kazananlar: '
  puts winners.first(winner_size)
  puts '------------'
  puts 'Yedek Talihliler: '
  puts winners.last(reserve_winner_size)

else
  puts 'Post kısa kodu bulunamadı'
end
