#R Basics from data type to inital plots

library(ggplot2)

# creating vectors

jan_price=c(10,20,30)
increace=c(1,2,3)
mar_price=jan_price+increace
june_price=c(20,25,30)

#matrix formation
all_prices=matrix(c(jan_price,mar_price, june_price),nrow = 3)
all_prices

#arrays:-like matrixes but has more than 2 dimention.  fror example we need 2 3x3 matrix
#with different years

#create six vectors
jan_2018=c(10,11,20)
mar_2018=c(20,22,25)
june_2018=c(30,33,33)
jan_2017=c(10,10,17)
mar_2017=c(18,23,21)
june_2017=c(25,31,35)

#combine these vectors into array
combined=array(c(jan_2018,mar_2018,june_2018,jan_2017,mar_2017,june_2017),dim = c(3,3,2))
combined

#dataframes
#like matrixes but can have different data types
items=c("potato", "rice", "oil")
all_prices3=data.frame(items,jan_price,mar_price,june_price)
all_prices3

#accessing dataframe can be done using [[]] or $

#select all the values of march price
all_prices3$mar_price
#or
all_prices3[["mar_price"]]


# by using [] we can acess the an element in the dataframe(give the row number and coloumn number)
all_prices3[2,3]

#using negative sign
# remove column 'item' and assign the new df to a new variable all_prices4
all_prices4=all_prices3[-1]
all_prices4


#using rbind() row wise binding an vector to data frame
# add a new vector pen to all_prices$
pen=c(3,4,3.5)
all_prices4=(rbind(all_prices3,pen))
all_prices4

#using cbind() coloumn wise binding of an vector to data frame
#add a prices of potato, rice ,oil, pen for august to add to the all_prices4

aug_price=c(22,24,31,5)
all_prices4=cbind(all_prices4, aug_price)

all_prices4


# considering a scenario were jan price and march price have four elements and
# june price have only 3 elements we cannot use the dataframe. In such a scenario we use lists
# using list we get all advantages of df in addition to its capacity for 
#storing different sets of elements ( column in case of df)with diff lengths

all_prices_list2=list(items, jan_price, mar_price,june_price)
all_prices_list2


#accessing list element can be done by using [],, or [[]] 
#here [ ] gives back the list
# and [[]] gives back the element in its orginal data type

all_prices_list2[1]

# using [ ] give us back another list and we cant use different mathematical operations on it directily
class(all_prices_list2[[2]])

# therefore we use [[]] to get the data in its orginal data type:
all_prices_list2[[2]]


#categorical and continuos variables
#n a dataset, we can distinguish two types of variables: categorical and continuous.

#In descriptive statistics for categorical variables in R, the value is limited and usually based on a particular finite group. 
#For example, a categorical variable in R can be countries, year, gender, occupation.
#A continuous variable, however, can take any values, from integer to decimal. 
#For example, we can have the revenue, price of a share, etc..


#factors

#we can convert the numeric vector to factors using factor()

#Factor in R is a variable used to categorize and store the data, having a limited number of different values.
#It stores the data as a vector of integer values. Factor in R is also known as a categorical variable that stores both string and integer data values as levels. Factor is mostly used in Statistical Modeling and exploratory data analysis with R.



x=c(4,6,2)
x=factor(x)
class(x)

str(x)
#It is important to transform a string into factor variable in R when we perform Machine Learning task.

#looping

#loop throug all the value of jan_price column in all_prices4 and square them and return

class(all_prices4)
aug=all_prices4$aug_price
for (price in aug) {
  print(price^2)
  
}

#functions in R
#the above power calculation can be done using a power fn named square:
square=function(data){
  for(price in data){
    print(price^2)
  }
}

#call the function
class(all_prices4$aug_price)
square(all_prices4$aug_price)


#modify the function for taking any element to a power

power_function=function(data, power){
  for(price in data){
    print(price^power)
    
    
  }
}
power_function(all_prices4$aug_price,4) #column of the all_prices4
power_function(all_prices4[1,2],4) #single element


#apply family

#apply: easier way to compute something rowise or columnwise
#syntax form: apply(data,margin, function)
#data:  has to be a matrix or an array!!! not dataframe
#margin:either 1-row-wise operation and 2-column operation
#function:inbuild or any defined fn
class(all_prices)

#compute the fluctuation of prices of the items over these 3 months

# for this we need to compute the std dev row-wise for each row
apply(all_prices, 1, sd)

#compute the month -wise total cost of all 3 items
#each month corresponds to columns we use margin =2
apply(all_prices,2,sum)


#lapply

#allows us to define a function (or existing function) 
#over all the elements of a list or vector and returns a list

#consider the old power fn using lapply we acn loop through each
#element of a list or vector and take the power of each of these elemnts
#on every iterationof the loop

#syntax:lapply(data, function, arguments_of_the_function) !data is a list or vector or dataframe

all_prices4$june_price #which is a vector
powerfunction2=function(data,power){
  data^power
}
lapply(all_prices4$june_price,powerfunction2,4)

#lapply returns a list if we use unlist we get a simple vector
unlist(lapply(all_prices4$june_price,powerfunction2,4))


# using the combined array for lapply we can convert the array
# to a list of matrices
combined2=list(matrix(c(jan_2018,mar_2018,june_2018),nrow = 3),
               matrix(c(jan_2017,mar_2017,june_2017),nrow=3))
combined2

class(combined2)
#using lapply to get the prices for march 2017 and 2018

lapply(combined2,"[",2,)

#"["-selects the element
#2-selects the second row
#space after comma selects all column
#totally means for all lists, select the second row and all columns

lapply(combined2,"[",2,2)#for all list it selects the second row and second column


#sapply

#sapply will return the output as vector when we used unlist in 
#lapply, sapply returns the vector 

#syntax:sapply(data,function, arguments_of_the_function)

sapply(all_prices4$june_price,powerfunction2,4)


#tapply
#tapply() computes a measure (mean, median, min, max, etc..) 
#or a function for each factor variable in a vector. 
#It is a very useful function that lets you create a subset of a vector and then apply some functions to each of the subset.

all_prices=data.frame(items=rep(c("potato","rice","oil"),4),
                      jan_price=c(10,12,30,10,18,25,9,17,24,9,19,27),
                      mar_price=c(11,22,33,13,25,32,12,21,33,15,27,39),
                      june_price=c(20,25,33,21,24,40,17,22,27,13,18,23)
)
all_prices
#take mean price of different items for very march in all years
#we can do this using tapply
#syntax:tapply(numerical_variable,categorical_variable,function)

#we need to convert the items column of all_prices data frame to 
#a categorical variable to take mean prices
tapply(all_prices$mar_price,factor(all_prices$items),mean)


#PLOTTING IN R
x=rnorm(50)
y=rnorm(50)
#pch =19stands for filled dot  pch=1 is unfilled dot pch=6 triangle

plot(x,y,pch=1,col='red')
str(all_prices)

#ggplot2
#ggplot works only on dataframe
#then we need aes()command which stands for the aesthetic 
#inside aes we define x axis variable and yaxis variable


#plot a point graph the different items in January against items

ggplot(all_prices,aes(x=items,y=jan_price))+geom_point()

# compute and mark the mean price in Jan of these items over all the years under consideration
#use stat="summary", fun.y="mean" and use this inside geom_point()agrument


ggplot(all_prices,aes(x=items,y=jan_price))+geom_point()+geom_point(stat="summary",fun.y="mean",colour="red",size=3)

#plot price of january against price of june and make separate plots for each items
#use facet_grid(.~items)

ggplot(all_prices,aes(x=jan_price,y=june_price))+geom_point()+facet_grid(.~items)

#linear model fit using stat_smooth() layer
ggplot(all_prices,aes(x=jan_price,y=june_price))+geom_point()+facet_grid(.~items)+
  stat_smooth(method="lm",se=TRUE,col="red")
#here se= true inside stat_smooth() shows confidence interval
