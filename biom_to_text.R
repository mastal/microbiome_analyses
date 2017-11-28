###############################################
###############################################
# Maria Stalteri
# 27/11/2017
# biom_to_text.R
#
###############################################
###############################################
# Convert biom files to text files
# outside of the Qiime environment.
#
# Using code from
# Geoffrey Zahn's blog post,
# Getting Your OTU Table Into R.
# http://geoffreyzahn.com/getting-your-otu-table-into-r/
#
################################################
################################################
# 1A. This part may no longer be necessary,
#    if the biomformat package is available 
#    in Bioconductor.
#
# If devtools is not already installed.
install.packages("devtools")
library(devtools)

# Get R package from github repository.
install_github("joey711/biomformat")

# 1B. Alternatively, get the biomformat
#     package from Bioconductor.
#
https://www.bioconductor.org/packages/release/bioc/html/biomformat.html

## try http:// if https:// URLs are not supported
source("https://bioconductor.org/biocLite.R")
biocLite("biomformat") 

#################################################
#################################################
# 2. Load the biomformat package. 
library(biomformat)

#################################################
#################################################
# 3. Read the biom file into R.

# Path to biom format file.
file_path <- "RA_Test3.biom"

# Check file path.
file_path

dat <- read_biom(file_path)
class(dat)

#################################################
#################################################
# 4. Convert the R object to a data.frame

# Convert sparse matrix to a data.frame.
otu_table <- as.data.frame(as.matrix(biom_data(dat)))

class(otu_table)
dim(otu_table)
head(otu_table)

##################################################
##################################################
# 5. Taxonomy and metadata.

# Our file did not have any taxonomy or metadata,
# but this is how to get the data if it exists.
# taxonomy and metadata should be data.frames.

taxonomy <- observation_metadata(dat)

metadata <- sample_metadata(dat)

#################################################
#################################################
# 6. Write the table to a text file

write.table(otu_table, \
   file="otu_table_from_biom.txt", \
   sep="\t", \
   col.names=NA, \
   quote=FALSE)

#################################################
#################################################
# 7. Supplementary Notes For Large OTU Tables:
#
# 7A. Computer memory.
#     The steps described above can be very
#     memory intensive for otu tables with
#     millions of rows (otus) and thousands of 
#     columns (samples). I have recently worked 
#     with a 100 Mb biom (HDF5) file, which used
#     some 90 Gb of computer memory, on Linux,
#     while converting the biom file to a 2 Gb
#     text file.
#
#     It is definitely a good idea to filter the
#     otu table as much as possible before attempting
#     to convert the file to a tsv table.
#
#     Attempting to do the biom to text conversion
#     on computers without enough memory resulted in 
#     segmentation faults.
#
# 7B. Cstack memory errors.
#     R also gave  Cstack memory errors.
#     The solution to that is to increase the Cstack
#     memory with ulimit.
#
#     You can do this just for one session if you 
#     don't have root or sudo priveleges on the computer.
#
# This will give the current limit for the Cstack
# memory and the maximum available.

$ ulimit -s

# This was set to 8192 on the machine I was using.

# Increase the Cstack limit before starting the R session.
# I tried ulimit 24000 and 32000, and the conversion
# ran without any problems, in less than 1 hr.

$ ulimit -s 24000
   
###################################################
###################################################
