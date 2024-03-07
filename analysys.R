# Install and load necessary packages
install.packages("tidyverse")  # Install the tidyverse package (includes ggplot2)
library(tidyverse)  # Load the tidyverse package

# Load the dataset (replace 'sample_data.csv' with your actual file path)
data <- read.csv("E:/R programming approaches/c2p2.csv")

# Explore the structure of the dataset
str(data)

# View the first few rows of the dataset
head(data)

# Summary statistics
summary(data)

# Visualize the distribution of Age using a histogram
ggplot(data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black", alpha = 0.7) +
  labs(title = "Distribution of Age", x = "Age", y = "Frequency")

# Visualize the relationship between Salary and Experience using a scatter plot
ggplot(data, aes(x = Experience, y = Salary)) +
  geom_point(color = "green", size = 3) +
  labs(title = "Scatter Plot of Salary vs. Experience", x = "Experience", y = "Salary")
