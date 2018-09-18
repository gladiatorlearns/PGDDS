##### Module Name - Programming in R

## Session Name - Introduction to R


#Introduction to R

#1.3.1 Basic Arithmatic Operations in R
8 + 5      #Addition
8 - 5      #Subtraction
9 * 2      #Multiplication
9/2        #Division

(2+3)/(5+5)     #Parenthesis

9 %% 2     #Calculating Remainder
3^5        #Calculating exponent


#Relational Operators 
8 > 7
8 >= 8
8 < 7
8 == 8 
8 <=7


#Built in Functions
sqrt(2)    #Calculating square root of 2
exp(3)     #Exponential of 3 

sin(10)  #Sine of 10 in radians
cos(1.572)  #Cosine of 1.572



help(log) 
?log

log10(10)


#Operators & Functions can work within a function (Composite functions)
sin(log10(sqrt(9-8)))             #Take care of parenthesis


#1.3.2 Variable

x <- 5     #Assign the value to the variable
x          #Print x

y = 6      
y

x == y     # Checking if x is equal to y

9 == 9    

cars <- 3 
scooters <- 4

cars + scooters       #Addition of two variables

Karan007 <- 23        #Correct Variable Name
007Karan <-  24       #Wrong Variable Name

RAHUL <- 10          #R is case-sensitive
rahul <- 9
Rahul <- 8


# #True and false are logical or boolean values.  R reads True as 1 and False as 0.

TRUE == FALSE
TRUE > FALSE

##Can mathematical operators be applied on strings?

"my" + "apples"

##How will you check type of variables?
##function class(x) to see which type x belongs to.

class ("my")
class(5.325)

#Difference between class & type of
typeof("apple")
typeof(5.325)

x = 4.65
class(x)

class(8 == 6)



#Creating Vectors
# c is a shorthand of combine
age <- c(23, 43, 53, 24, 61, 35, 36, 42, 20, 54)  

age

my_number <- c(3, 8, 9, 10)
my_number
class(my_number)


y <- c(1.4, "ten")        #R converts y into a Character vector
y
class(y)

# This type of conversion is called Coercion.

class(c(FALSE, 3, "twelve"))
class(c(FALSE, 3))
class(c(FALSE))


##1.4.2 Vector Operations

#Accessing Vector elements
my_vector <- c(3, 8, 9, 10)
my_vector[3]                           #Accessing 3rd element of my_vector
my_vector[2:4]                         #Accessing last 3 elements of my_vector


##Index in R starts from 1

#Stripping

my_vector[-3]   #Returns all elements other than 3rd elements 

##Stripping means just not printing some elements. Original Vector remains the same



#Performing different Operations on vectors
my_vector1 <- c(1,3,5,7)
my_vector2 <- c(2,4,6,8)
added_vector <- my_vector1 + my_vector2
added_vector


#Applying functions on Vectors
my_vector1 <- c(1,3,5,7)
min(my_vector1)
sort(my_vector1)        



# Used when data set contains unknown variables!

my_vector2 <- c(1, 3, 5, NA, 7, NA)
is.na(my_vector2)

hieghts <- c("medium", "short", "short", "tall", "medium", "medium")
hieghts
hieghts[1] <- "Ultra-short"
hieghts

#Converting this into factors

hieghts <- c("medium", "short", "short", "tall", "medium", "medium")
factor_hieghts <- factor(hieghts)
factor_hieghts
levels(factor_hieghts)
factor_hieghts[1] <- "Ultra-short"     #This will not work
factor_hieghts
summary(factor_hieghts)



# say we create a numeric vector to store values of a die roll:
dice <- c(1, 2, 4, 5, 5, 3, 2, 6, 3, 5, 6, 2, 1, 4, 3, 6, 5, 3, 2, 2, 5) 
#We can convert the vector into 6 factor levels. 
dice_levels  <-  factor(dice)
dice_levels

summary(dice_levels)

# OMR responses of Objective examination
logical_levels <- factor(c(TRUE,FALSE, TRUE, FALSE,TRUE,TRUE,FALSE,TRUE,TRUE,TRUE))
logical_levels
summary(logical_levels)


# Matrices

matrix(1:9, byrow = TRUE, nrow = 3)      

matrix(1:9, byrow = FALSE, nrow = 3)


#Making matrix by combining vectors
karan_dice <- c(3,1,5,7,6,1)
raj_dice <- c(6,1,3,4,6,1)
ajay_dice <- c(2,1,4,2,2,5)

dice_vector <- c(karan_dice, raj_dice, ajay_dice)

dice_matrix <- matrix(dice_vector, nrow = 3, byrow = TRUE)
dice_matrix



#Data Frames

iris           #Built-in data frame in R

head(iris)      #First few obeservations - top part of dataframe
tail(iris)      #Last few observations - bottom part of dataframe

str(iris)      

?iris

#Creating a data frame

Player_name <- c("Rohit","Kohli","dhoni")
Total_runs <- c(5000,7200,8900)
Strike_rate <- c("84.22","89.12","87")

team1 <- data.frame(Player_name,Total_runs,Strike_rate)
team1

str(team1)


#stringsAsFactors
#stringsAsFactors is set by default as TRUE

team_char <- data.frame(Player_name,Total_runs,Strike_rate, stringsAsFactors = FALSE)
str(team_char)


#Accessing different elements from Data frame 

team1


team1[2,1]                    #Accessing one element
team1["2","Player_name"]     


team1[2, ]                    #Accessing second row  


team1[ ,2]                    #Accessing first column 
team1$Total_runs              #This can also used. More popular


team1[2:3, 1:2]        #Accessing selective rows & columns

team1[1:3,"Total_runs"]



#Data Frame Operations

Player_name <- c("Jadeja","Ashwin","Raina")
Total_runs <- c(1200,1500,5000)
Strike_rate <- c("34","45","80")

team2 <- data.frame(Player_name,Total_runs,Strike_rate)

Complete_team <- rbind(team1,team2)     #Combining two data frames
Complete_team

Player_age <- c(26,25,37)
hit_six <- c(230,123,133)
team3 <- data.frame(Player_age,hit_six)       #Making new data frame
team1_info <<- cbind(team1,team3)             #Cbind another data frame
team1_info

#Alternative
team1_info <<- cbind(team1,Player_age,hit_six) #Cbind two vectors directly


#Applying functions on data frame

nrow(team1_info)                        #Returns number of rows
ncol(team1_info)                        #Returns number of columns

summary(team1_info)                     #Summary analysis of data



#Installing data from files

#Reading data from .txt file
team_from_text_file<- read.table("myfile.txt")     
team_from_text_file<

#Reading data from .csv file
team_from_csv <- read.csv("myfile.csv")        
team_from_csv




#Lists

team1 <- read.csv("myfile.csv")
team1

Stadiums <- c("Wankhede", "Eden Gardens", "Firozshah Kotla")

Perf_Matrix <- matrix(1:6,nrow=2)

mylist <- list(team1, Stadiums, Perf_Matrix)
mylist

#Creating a named list

mylist <- list(Teaminfo = team1, St = Stadiums, Perf = Perf_Matrix )
mylist

#1.8.2 Accessing elements from list

mylist[[2]]                  #Accessing second elements

mylist[["St"]]             #Alternate
