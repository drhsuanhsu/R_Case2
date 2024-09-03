#Install and load the tidyverse
install.packages('tidyverse')
library(tidyverse)

getwd()

daily_activity <- read.csv("dailyActivity_merged.csv")
sleep_day <- read.csv("sleepDay_merged.csv")

# Take a look at the daily_activity data.
head(daily_activity)

# Identify all the columns in the daily_activity data.
colnames(daily_activity)

# Take a look at the sleep_day data.
head(sleep_day)

# Identify all the columns in the daily_activity data.
colnames(sleep_day)


library(dplyr)


# How many unique participants are there in each dataframe? 
# It looks like there may be more participants in the daily activity 
# dataset than the sleep dataset.

n_distinct(daily_activity$Id)
n_distinct(sleep_day$Id)


# How many observations are there in each dataframe?
nrow(daily_activity)
nrow(sleep_day)


# What are some quick summary statistics we'd want to know about each data frame?
# For the daily activity dataframe:
daily_activity %>%  
  select(TotalSteps,
         TotalDistance,
         SedentaryMinutes) %>%
  summary()


# For the sleep dataframe:
sleep_day %>%  
  select(TotalSleepRecords,
         TotalMinutesAsleep,
         TotalTimeInBed) %>%
  summary()


library(ggplot2)

# What's the relationship between steps taken in a day and sedentary minutes? 
# How could this help inform the customer segments that we can market to? 
# E.g. position this more as a way to get started in walking more? 
# Or to measure steps that you're already taking?

#Simple version
ggplot(data=daily_activity, aes(x=TotalSteps, y=SedentaryMinutes)) + geom_point()

#Beautiful version
ggplot(data = daily_activity, aes(x = TotalSteps, y = SedentaryMinutes)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's sleep minutes and steps as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between steps taken in a day and sedentary minute",
       x = "Total Steps",
       y = "Sedentary Minutes") +
  theme_minimal()  # Apply a minimal theme for a clean look


# What's the relationship between minutes asleep and time in bed? 
# You might expect it to be almost completely linear - are there any unexpected trends?
#Simple version
ggplot(data=sleep_day, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) + geom_point()

#Beautiful version
ggplot(data =sleep_day, aes(x=TotalMinutesAsleep, y=TotalTimeInBed)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's sleep minutes and steps as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Total Minutes Asleep and Total Time In Bed",
       x = "Total Minutes Asleep",
       y = "Total Time In Bed") +
  theme_minimal()  # Apply a minimal theme for a clean look



## Merging these two datasets together ##
combined_data <- merge(sleep_day, daily_activity, by="Id")

# Take a look at how many participants are in this data set.
n_distinct(combined_data$Id)


# Create a scatter plot to explore the relationship between Calories burned and Total Steps
ggplot(data = combined_data, aes(x = TotalSteps, y = Calories)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's steps and calories as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Total Steps and Calories Burned",
       x = "Total Steps",
       y = "Calories Burned") +
  theme_minimal()  # Apply a minimal theme for a clean look



# Create a scatter plot to explore the relationship between Total Minutes Asleep and Calories burned
ggplot(data = combined_data, aes(x = TotalMinutesAsleep, y = Calories)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's sleep minutes and calories as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Total Minutes Asleep and Calories Burned",
       x = "Total Minutes Asleep",
       y = "Calories Burned") +
  theme_minimal()  # Apply a minimal theme for a clean look



# Create a scatter plot to explore the relationship between Sedentary Minutes and Calories burned
ggplot(data = combined_data, aes(x = SedentaryMinutes, y = Calories)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's sedentary minutes and calories as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Sedentary Minutes and Calories Burned",
       x = "Sedentary Minutes",
       y = "Calories Burned") +
  theme_minimal()  # Apply a minimal theme for a clean look


# Create a scatter plot to explore the relationship between Total Steps and Total Distance
ggplot(data = combined_data, aes(x = TotalSteps, y = TotalDistance)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's steps and distance as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Total Steps and Total Distance",
       x = "Total Steps",
       y = "Total Distance (miles)") +
  theme_minimal()  # Apply a minimal theme for a clean look


# Create a scatter plot to explore the relationship between Total Distance and Calories burned
ggplot(data = combined_data, aes(x = TotalDistance, y = Calories)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's distance and calories as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Total Distance and Calories Burned",
       x = "Total Distance (miles)",
       y = "Calories Burned") +
  theme_minimal()  # Apply a minimal theme for a clean look


# Create a scatter plot to explore the relationship between Total Minutes Asleep and Total Steps
ggplot(data = combined_data, aes(x = TotalMinutesAsleep, y = TotalSteps)) +
  geom_point(color = "blue", alpha = 0.5) +  # Plot each participant's sleep minutes and steps as points
  geom_smooth(method = "lm", color = "red", se = TRUE) +  # Add a linear regression line with a confidence interval
  labs(title = "Relationship Between Total Minutes Asleep and Total Steps Taken",
       x = "Total Minutes Asleep",
       y = "Total Steps Taken") +
  theme_minimal()  # Apply a minimal theme for a clean look
