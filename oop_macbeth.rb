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
		puts "Please enter the number ranking you wish to see or press enter for word search"
		if gets == "\n"
			 word_search(word_hash)
		else
		rank = gets.chomp.to_i - 1
		word_ranker(word_hash, rank)
		end
	end

	def word_ranker(word_hash, rank)
		binding.pry
		result = word_hash.sort{|a,b| a[1]<=>b[1]}.reverse[rank]
		puts "The word is '#{result[0]}' and occurres #{result[1]} times"
	end

	def  word_search(word_hash)
		puts "Enter the word that you wish to see the rank of"
		word = gets.chomp
		result = word_hash["#{word}"]
		puts "The word '#{word}'' appears #{result} times in this file"
	end
end
FileOpen.new





















