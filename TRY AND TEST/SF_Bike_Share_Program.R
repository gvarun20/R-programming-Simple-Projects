#SF BIKE SHARE DATA 
#loading csv data into R
trips = read.csv("trip.csv",header=TRUE)

print(names(trips))

print(length(trips$id))

print(summary(trips$duration/60))

print(mean(trips$duration/60, trim = 0.01))

#Checking how many start station are there using station name
start_stn = unique(trips$start_station_name)
print(sort(start_stn))
print(length(start_stn))

#Checking how many end station are there using station id.
end_stn = unique(trips$end_station_id)
print(sort(end_stn))
print(length(end_stn))


