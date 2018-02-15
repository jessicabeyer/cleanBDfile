#' cleanBDfile
#' 
#' This function reorganizes an output file from BD Accuri C6 Plus software.
#' @param path Specify the path to the xls file containing the Batch Analysis results
#' @return Returns a data frame with columns describing sample information and data
#' @examples 
#' batchAnalysisResults <- system.file("extdata","exampleFC.xls", package="cleanBDfile")
#' cleanBDfile(batchAnalysisResults)
#' @export
cleanBDfile <- function(path){
  require(readxl)
  require(purrr)
  require(tidyverse)

  # first, count up the rows in the excel file to figure out how many chunks of data there are
  # each chunk takes up five rows, except for the last one which takes up four
  nsample <- (nrow(read_excel(path, sheet=1, col_names=FALSE))+1)/5
  
  # now generate a vector of cell limits to use in read_excel called cellLimits
  1:nsample %>%
    map(function(x){
      rowMin <- 1+(5*(x-1))
      rowMax <- 4+((x-1)*5)
      result <- cell_limits(c(rowMin,1), c(rowMax, 9))
      return(result)
    }) -> cellLimits
  
  # read in the data using our vector of cellLimits
  cellLimits %>%
    map(~read_excel(path, sheet=1, range=.x)) %>%
    map(~add_column(.x, sampleInfo=rep(names(.x)[1],3))) -> test
  
  # rename the first column in each tibble to 'group' to make full_join possible
  for(i in 1:nsample){
    names(test[[i]])[1] <- "group"
  }
  
  # then combine all the tibbles together and clean up the sampleInfo column
  test %>% 
    Reduce(full_join, .) %>% 
    separate(sampleInfo, c("Plot", "CellSample", "Gate"), sep=":", fill="right") %>%
    separate(CellSample, c("empty","Cell", "Sample"), sep=" ", fill="right") %>%
    subset(select=-empty) -> tidyFCdata
  
  return(tidyFCdata)
}

