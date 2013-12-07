#!/usr/bin/env ruby
require 'open-uri'
require 'nokogiri'

puts "The dreams of the 2000's are alive in Seattle??"
puts "Ok, bad joke.. portlandia? .. this is so 2000.. "
sleep 2
puts "Hey there, you like MUSIC ?"
puts "KEXP from Seattle ? " 
puts "Cool..... ok, So they have this podcast called 'song of the day'"
puts "http://kexp.org/podcasts "
puts "Where every day, they feature a new artist and a song"
print "Wanna catch up on the last year or so of songs ? (y/n) : "
answer = STDIN.gets.chomp()

  if (answer == 'y')
	print "Ok, is it ok I write  /tmp/kexp_songs_of_the_day_archive/ ? (y/n) : "
	dir_answer = STDIN.gets.chomp()
	if (dir_answer == 'y')
		Dir::mkdir("/tmp/kexp_songs_of_the_day_archive")
	elsif
		puts "Ok, well think about it... "
	else 
		puts "Your speaking gibber .. #{dir_answer}"
	end
  elsif ( answer == 'n' )
	puts "Ok, not gonna do it. bye !... "
	exit 1
  else 
	puts "Hmm, I don't know #{answer} .. bye "
	exit 1
  end	


puts "Downloading... these songs are in the PUBLIC DOMAIN.. "
puts "Remember to support your local radio station / record store"

Dir.chdir("/tmp/kexp_songs_of_the_day_archive/")
page = Nokogiri::XML(open("http://feeds.kexp.org/kexp/songoftheday"))

title = page.xpath("//item/title | //item/link")
songtitles = []
links = []
  title.each do |sod|
    sod = sod.text
    if (sod =~ /^http/)
	links.push(sod)
    else 
      title1 = sod.gsub(' ', '_')
      title2 = title1.gsub('\'', '')
      title3 = title2.gsub('/', '')
      title4 = title3.gsub('_-_', '-')
	songtitles.push(title4)
    end
    
  end

stl = songtitles.length
stl = stl - 1
range = (0..stl).to_a

range.each do |n|
    song = songtitles[n]
    song << ".mp3"
    url = links[n]
    puts "Downloading #{song} from #{url}"
    open(url) do |io|
	File.open(song, 'w') {|out| out.print(io.read) }
    end
end

