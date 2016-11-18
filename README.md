## R系列筆記

這是我的R學習筆記，主要是用R-Markdown 所撰寫，使用Knit套件編譯，並且發表到Rpubs上：   
http://rpubs.com/skydome20/Table_of_Content   



With the concern of degree of freedom, this function converts n 'category'('factor' and 'chr') variables to n-1 'dummy' variables of a data frame.   

Traditionally, there are three steps to convert 'category' variables to 'dummy' variables of a data.frame:   
1. a data.frame must be divided as a data.frame with all 'category' variables and a data.frame with all 'non-category' variables.   
2. Then, calling the function 'model,matrix()' to convert 'category' variables to 'dummy' variables.   
3. Finally, combining 'dummy' variables with 'non-facotry' variables as a new data.frame for analyzing.   

However, it's really annoying to do such thing below, thus this function pops up!   
 
This function will handle an original data frame by automatically identifying 'category' variables for 'dummy' variables converting, and remaining 'non-cateogry' variables.  
