#!/usr/bin/env ruby

#-----------------------------------------------------------------------------------------------
# admixture_dK 0.1.0
# Michael G. Campana, 2019
# Smithsonian Conservation Biology Institute
#-----------------------------------------------------------------------------------------------

def mean(val = [])
	mean = 0.0
	for i in 0.. val.size-1
		mean += val[i]
	end
	mean /= val.size
	return mean
end
#-------------------------------------------------
def stdev(val = [])
	me = mean(val)
	st = 0.0
	for stval in val
		add = (stval - me) * (stval - me)
		st += add
	end
	de = (val.size - 1).to_f
	st /= de
	st2 = Math.sqrt(st)
	return st2
end
#-------------------------------------------------
def calc_dK
	puts "K\tMean LogLikelihood\tL'(K)\tL''(K)\tdelta K"
	means = []
	stdevs = []
	first = []
	second = []
	dKs = []
	for i in 1 .. $likelihoods.size
		if $likelihoods[i-1].size > 1
			me = mean($likelihoods[i-1])
			means.push(me)
			stdevs.push(stdev($likelihoods[i-1]))
		else
			means.push("NA")
			stdevs.push("NA")
		end
	end
	for i in 0 .. $likelihoods.size - 1
		if (means[i] != "NA" and means[i-1] != "NA" and i != 0)
			val = means[i]-means[i-1]
			first.push(val)
		else
			first.push("NA")
		end
	end
	for i in 0 .. $likelihoods.size - 1
		if (first[i+1] != "NA" and first[i] != "NA" and stdevs[i] != "NA" and i != $likelihoods.size - 1)
			val = first[i+1] - first[i]
			second.push(val.abs)
			dKs.push(val.abs/stdevs[i])
		else
			second.push("NA")
			dKs.push("NA")
		end
	end
	for i in 1 .. $likelihoods.size
		puts i.to_s + "\t" + means[i-1].to_s + "\t" + first[i-1].to_s + "\t" + second[i-1].to_s + "\t" + dKs[i-1].to_s
	end
end
#-------------------------------------------------
def get_likelihood(file)
	if file[-3..-1] == "out"
		File.open(ARGV[0] + "/" + file, 'r') do |f1|
			converge = false
			while line = f1.gets
				if converge
					if line.include?("Loglikelihood:")
						likelihood = line.delete("Loglikelihood: ")[0..-2].to_f
						# Get K value from file name
						kindex = -4
						kchr = file[kindex].chr
						while kchr != "g"
							kindex -= 1
							kchr = file[kindex].chr
						end
						k = file[kindex+1..-4].to_i
						while $likelihoods.size < k
							$likelihoods.push([])
						end
						$likelihoods[k-1].push(likelihood)
					end
				elsif line.include?("Converged in")
					converge = true
				end
			end
		end
	end
end
#-------------------------------------------------
$likelihoods = []
if ARGV[0].nil?
	puts "Usage: ruby admixture_dK.rb <log_directory> > outfile"
else
	Dir.foreach(ARGV[0]) {|file| get_likelihood(file)}
	calc_dK
end