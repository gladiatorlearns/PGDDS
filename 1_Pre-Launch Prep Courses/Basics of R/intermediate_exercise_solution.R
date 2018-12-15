# Look at structure of mtcars
str(mtcars)
cars <- mtcars

# Calculate each car's score in a new column named score 
# score = mpg.hp / wt
cars$score <- cars$mpg*cars$hp/cars$wt
str(cars)

# Store the scores in a vector s
s <- cars$score
mean(s)

# Create a new vector named performance equal to the length of the vector s
# http://stackoverflow.com/questions/22104774/how-to-initialize-a-vector-with-fixed-length-in-r
performance <- vector(mode="character", length=length(cars$score))
performance

# If score < mean(score), performance is 'average', else performance is 'good'
for (index in 1:length(performance)){
  if (s[index] >= mean(s)){
    performance[index] = "good"
  }else{
    performance[index] = "average"
  }
}

performance

# Add the performance vector as a column to cars
cars$performance <- performance
str(cars)

# Convert the performance variable to factor type
cars$performance <- as.factor(cars$performance)
str(cars)

# Summarise the cars df
summary(cars$performance)




