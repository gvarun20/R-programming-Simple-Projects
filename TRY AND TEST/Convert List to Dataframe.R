# create a list 
list1 <- list(A = c("Sabby", "Cathy", "Dormy"),
              B = c(18, 24, 22),
              C = c("Computer Science", "Engineering", "Business")
)

# convert list to dataframe
result <- as.data.frame(list1)

print(result)


