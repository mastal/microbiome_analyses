########################################
########################################
# Maria Stalteri
# 03/07/2017
# biom_to_text.R
#
########################################
########################################
# Convert biom files to text files
# outside of the Qiime environment.
#
# Using code from
# Geoffrey Zahn's blog post,
# Getting Your OTU Table Into R
# http://geoffreyzahn.com/getting-your-otu-table-into-r/
#
#########################################
#########################################
# If devtools is not already installed.
install.packages("devtools")
library(devtools)

# Get R package from github repository.
install_github("joey711/biomformat")
library(biomformat)

# Path to biom format file.
file_path <- "RA_Test3.biom"

# Check file path.
file_path

dat <- read_biom(file_path)
class(dat)

# Convert sparse matrix to a data.frame.
otu_table <- as.data.frame(as.matrix(biom_data(dat)))

class(otu_table)
dim(otu_table)
head(otu_table)

# Our file did not have any taxonomy or metadata,
# but this is how to get the data if it exists.
# taxonomy and metadata should be data.frames.
taxonomy <- observation_metadata(dat)

metadata <- sample_metadata(dat)

##########################################
##########################################





