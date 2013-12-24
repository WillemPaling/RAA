# BuildInnerBreakdownsRecursively
# BuildInnerBreakdownsRecursively is used by trended and ranked reports
# loops over the report structure until it gets to the bottom level and
# returns a flat breakdown

BuildInnerBreakdownsRecursively <- function(parent.element,elements,metrics,
                                            current.recursion.level,context,accumulator=data.frame(),
                                            date.range='') {
  
  # loop through all elements and work our way to innermost elements

  for(i in 1:nrow(parent.element)){
    
    working.element <- parent.element[i,"breakdown"][[1]]
    context <- context[0:current.recursion.level-1]
    context <- append(context,parent.element[i,"name"])
    
    # check if we are at the lowest level, or if we need to continue deeper
    
    if(current.recursion.level<length(elements)-1) {
      
      # we need to go deeper, so we add this level to the context 
      # and call BuildInnerBreakdownsRecursively again
      accumulator <- BuildInnerBreakdownsRecursively(working.element,elements,metrics,current.recursion.level+1,context,accumulator,date.range=date.range)
      
    } else {
      
      # we are at the lowest level
      # build our list of metrics
      
      working.metrics <- ldply(working.element$counts)
      names(working.metrics) <- metrics
      
      # build our list of elements
      outer.elements <- working.element$name
      names(outer.elements) <- "name"
      
      # if we have a valid date range, apply it to all rows
      if(length(date.range)==2){
        working.elements.breakdown <- data.frame(matrix(ncol=length(elements)+2, nrow=length(outer.elements)))
        names(working.elements.breakdown) <- append(c("date.start","date.end"),elements)
        working.elements.breakdown$date.start <- date.range[1]
        working.elements.breakdown$date.end <- date.range[2]   
      } else {
        working.elements.breakdown <- data.frame(matrix(ncol=length(elements), nrow=length(outer.elements)))
        names(working.elements.breakdown) <- elements
      }
      
      # apply context to all rows
      for(j in 1:(length(elements)-1)) {
        working.elements.breakdown[elements[j]] <- context[j]
      }
      
      # apply outer element to all rows
      working.elements.breakdown[elements[j+1]] <- outer.elements
      
      # bind to the accumulator
      temp <- cbind(working.elements.breakdown,working.metrics)
      accumulator <- rbind(accumulator,temp)
      
    }
  }
  return(accumulator)
}
