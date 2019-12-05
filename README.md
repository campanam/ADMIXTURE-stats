# ADMIXTURE-stats  

Michael G. Campana, 2019  
Smithsonian Conservation Biology Institute  
Contact: campanam@si.edu  

*CorrSieve* helper scripts to calculate Δ*K* and perform *Q*-matrix correlations from [ADMIXTURE](http://software.genetics.ucla.edu/admixture/) output  

## License  
The software is made available under the Smithsonian Institution [terms of use](https://www.si.edu/termsofuse).  

## Installation  
Ruby scripts do not need to be compiled in advance. Simply clone the scripts, make them executable, and move them to a desired execution location.  
`git clone https://github.com/campanam/ADMIXTURE-stats`  
`chmod +x ADMIXTURE-stats/*.rb`  
`mv *.rb <destination>`  

## Usage
The scripts (.rb) files can be executed locally using the `ruby` command or moved to a location within your $PATH. If in your path, simply invoke the script omitting the `ruby` command.    

### admixture_dK.rb  
This script calculates Evanno et al.'s Δ*K* statistic for ADMIXTURE results. Input is a directory of ADMIXTURE log files and output are the Δ*K* results calculated as in *CorrSieve* (versions <= 1.7-0) in tab-separated values (TSV) format. Execution is:  
`ruby admixture_dK.rb <ADMIXTURE logs directory> > <deltaK results.tsv>`  

### convert_qmatrix.rb
This script converts a directory of ADMIXTURE population assignment files (.Q) into Ruby *CorrSieve*-readable (versions <= 1.7-0) input for *Q*-matrix correlations. *WARNING: Converted files are not compatible with the* CorrSieve *R version*. Execution is:  
`ruby convert_qmatrix.rb <ADMIXTURE .Q directory> <Output directory>`  
Output files can then be used by *CorrSieve* for *Q*-matrix correlations, but will fail for other analyses.  

## ADMIXTURE-stats Citations  
Campana, M.G. 2019. ADMIXTURE-stats. https://github.com/campanam/ADMIXTURE-stats.  

Campana, M.G. et al. 2011. *CorrSieve*: software for summarizing and evaluating Structure output. Mol. Ecol. Resour. 11:349-352. https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1755-0998.2010.02917.x  

## References
Evanno et al. 2005. Detecting the number of clusters of individuals using the software STRUCTURE: a simulation study. Mol. Ecol. 14: 2611-2620. https://onlinelibrary.wiley.com/doi/abs/10.1111/j.1365-294X.2005.02553.x.  

Alexandre et al. 2009. Fast model-based estimation of ancestry in unrelated individuals. Genome Res. 19: 1655-1664. https://genome.cshlp.org/content/19/9/1655
