require 'pry'

class FileOpen
	def initialize
		puts "Enter the .txt file name "
		file = gets.chomp
		file_open(file)
	end

	def file_open(file)
		text = File.open(file, "r")
		FileParser.new.word_parse(text)
	end
end

class FileParser
	def word_parse(text)
		word_hash = Hash.new
		text.each_line do |line|
		words = line.split
			words.each do |word|
				if word.length >= 4
					word = word.gsub(/\W+/, '').downcase
					if word_hash.has_key?(word)
						word_hash[word] += 1
					else
						word_hash[word] = 1
					end
				end
			end
		end
		WordRanker.new(word_hash)
	end
end

class WordRanker
	def initialize(word_hash)
		puts "Please enter the number ranking you wish to see"
		rank = gets.chomp.to_i - 1
		word_ranker(word_hash, rank)
	end

	def word_ranker(word_hash, rank)
		result = word_hash.sort{|a,b| a[1]<=>b[1]}.reverse[rank]
		puts "The word is '#{result[0]}' and occurres #{result[1]} times"
	end
end
FileOpen.new





















