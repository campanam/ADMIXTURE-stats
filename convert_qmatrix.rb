#!/usr/bin/env ruby

#-----------------------------------------------------------------------------------------------
# convert_qmatrix 0.1.0
# Michael G. Campana, 2019
# Smithsonian Conservation Biology Institute
#-----------------------------------------------------------------------------------------------

def convert_qmatrix(file)
	if file[-1] == "Q"
		# Get K value from file name
		kindex = -3
		kchr = file[kindex].chr
		while kchr != "."
			kindex -= 1
			kchr = file[kindex].chr
		end
		kval = file[kindex+1..-3]
		# Generate dummy header
		@outline = kval + " populations assumed\nLabel (%Miss) Pop:  Inferred clusters\n"
		File.open(ARGV[0] + "/" + file, 'r') do |f1|
			while line = f1.gets
				if line.length == 0
					@outline << "\n"
					break
				end
				vals = line.split(" ")
				@outline << ":"
				for val in vals
					val = val.to_f.round(3).to_s
					while val.length < 5
						val << "0"
					end
					@outline << val + " "
				end
				@outline << "\n"
			end
		end
		File.open(ARGV[1] + "/" + file + "_f", 'w') do |f2|
			f2.puts @outline
		end
	end
end
if ARGV[0].nil? or ARGV[1].nil?
	puts "Usage: ruby convert_qmatrix.rb <Q_matrix_directory> <output_directory>"
else
	Dir.mkdir(ARGV[1]) if !File.directory?(ARGV[1])
	Dir.foreach(ARGV[0]) {|file| convert_qmatrix(file)}
end