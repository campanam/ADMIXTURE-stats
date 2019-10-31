# ADMIXTURE-stats
CorrSieve helper scripts to calculate deltaK and perform Q-matrix correlations from ADMIXTURE output

## Michael G. Campana, 2019  

## Installation  
Ruby scripts do not need to be compiled in advance.  
`git clone https://github.com/campanam/ADMIXTURE-stats`  
`chmod +x ADMIXTURE-stats/*.rb`  
`mv *.rb <destination>`  

## Usage
The scripts (.rb) files can be executed locally using the `ruby` command or moved to a location within your $PATH. If in your path, simply invoke the script omitting the `ruby`.    

### convert_qmatrix.rb
This script converts a directory of ADMIXTURE population assignment files (.Q) into CorrSieve-readable (v. <= 1.7.0) input for Q-matrix correlations. Execution is:  
`ruby convert_qmatrix.rb <ADMIXTURE directory> <Output directory>`  
Output files can then be used by CorrSieve for Q-matrix correlations, but will fail for other analyses.  

