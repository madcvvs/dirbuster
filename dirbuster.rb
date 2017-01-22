# DirBuster (Ruby)

require "net/https"
require "uri"

def browse(website)
	File.readlines('list.txt').each do |line|
		file = "results.txt"
		url = "#{website}/#{line}".chomp
		res = Net::HTTP.get_response(URI(url))
		code = res.code
		
		if code == "200"
			print "\033[0;32m#{code} - #{website}#{line}\033[0m"
			open('results.txt', 'a') { |f|
				f.puts "#{code} - #{website}#{line}"
			}
		elsif code == "404"
			print "\033[0;31m#{code} - #{website}#{line}\033[0m"
		else
			print "\033[0;33m#{code} - #{website}#{line}\033[0m"
			open('results.txt', 'a') { |f|
				f.puts "#{code} - #{website}#{line}"
			}
		end
	end
	puts "Results are saved in \033[0;32m#{file}!\033[0m"
end

print "Website: "
website = gets.chomp

# If website starts with http://
if website.start_with? "http://"

	if website.end_with? "/"
		browse(website)
	else
		website = website.concat("/")
		browse(website)
	end

elsif website.start_with? "https://"

	if website.end_with? "/"
		browse(website)
	else
		website = website.concat("/")
		browse(website)
	end
	
else
	print "URL needs to start with http:// or https://"

end
