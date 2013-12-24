# buildInnerBreakdownsRecursively
# buildInnerBreakdownsRecursively is used by trended and ranked reports
# loops over the report structure until it gets to the bottom level and
# returns a flat breakdown

buildInnerBreakdownsRecursively <- function(parent_element,elements,metrics,
                                            current_recursion_level,context,accumulator=data.frame(),
                                            date_range='') {
  
  # loop through all elements and work our way to innermost elements

  for(i in 1:nrow(parent_element)){
    
    working_element <- parent_element[i,"breakdown"][[1]]
    context <- context[0:current_recursion_level-1]
    context <- append(context,parent_element[i,"name"])
    
    # check if we are at the lowest level, or if we need to continue deeper
    
    if(current_recursion_level<length(elements)-1) {
      
      # we need to go deeper, so we add this level to the context 
      # and call buildInnerBreakdownsRecursively again
      accumulator <- buildInnerBreakdownsRecursively(working_element,elements,metrics,current_recursion_level+1,context,accumulator,date_range=date_range)
      
    } else {
      
      # we are at the lowest level
      # build our list of metrics
      
      working_metrics <- ldply(working_element$counts)
      names(working_metrics) <- metrics
      
      # build our list of elements
      outer_elements <- working_element$name
      names(outer_elements) <- "name"
      
      # if we have a valid date range, apply it to all rows
      if(length(date_range)==2){
        working_elements_breakdown <- data.frame(matrix(ncol=length(elements)+2, nrow=length(outer_elements)))
        names(working_elements_breakdown) <- append(c("date_start","date_end"),elements)
        working_elements_breakdown$date_start <- date_range[1]
        working_elements_breakdown$date_end <- date_range[2]   
      } else {
        working_elements_breakdown <- data.frame(matrix(ncol=length(elements), nrow=length(outer_elements)))
        names(working_elements_breakdown) <- elements
      }
      
      # apply context to all rows
      for(j in 1:(length(elements)-1)) {
        working_elements_breakdown[elements[j]] <- context[j]
      }
      
      # apply outer element to all rows
      working_elements_breakdown[elements[j+1]] <- outer_elements
      
      # bind to the accumulator
      temp <- cbind(working_elements_breakdown,working_metrics)
      accumulator <- rbind(accumulator,temp)
      
    }
  }
  return(accumulator)
}
