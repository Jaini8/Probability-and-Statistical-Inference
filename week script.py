import csv #import needed to read and write csv files
import datetime #import to handle date time objects

values = [] #initialize the values array

#open the csv file
with open("C:\\Users\\Josh\\Documents\\Grad School\\Statistics\\Final Project\\dji_d.csv") as csvfile:
    reader = csv.reader(csvfile, delimiter=',')#create the reader object
    next(reader)#skip the header
    for row in reader:#iterate over each row to create the values array 
        dateString = row[0]#get the string value of the date (i.e 6/20/1978)
        #Turn the date string into a date time object
        #We do this so we can extract week data from the data
        date = datetime.datetime.strptime(dateString, '%Y-%m-%d').date()
        #Add to the values list the year, the week of the year and the index
        values.append([date.year, date.isocalendar()[1], float(row[1])])
        
weeklyAverage = [] #initialize the weeklyAverage array

                    #Year           Week Number      Index (float)     Count
#Add the first row to weeklyAverages
weeklyAverage.append([values[0][0], values[0][1], float(values[0][2]), 1]) 
#Iterate over each row of the values array to add to the weeklyAverages array
for i in range(len(values)): 
    flag = True #flag if a row in the averages array has been created or not
    print(values[i][0]) #Just making sure the program is running
    for j in range(len(weeklyAverage)): #Iterate over the weeklyAverages array
#If a row in the weekly averages has been created for this year and week,
#add to that row/ If not create a new row for that week of that year
        if(values[i][0] == weeklyAverage[j][0] and values[i][1] == weeklyAverage[j][1]): 
            weeklyAverage[j][2] += float(values[i][2])#Add to the index total of that specific week
            weeklyAverage[j][3] += 1 #Add to the index of that week by 1
            flag = False #set the flag to false because a row is already created for this week
    if flag: #If the flag was never set to false, create a row for that week and set the count to 1
        #starting a row for that week of that year
        weeklyAverage.append([values[i][0], values[i][1], values[i][2], 1]) 

#Now the data has been combined in a weekly manner
#Next is to create the new csvfile for further analysis

#Open a new csv file
file = open("C:\\Users\\Josh\\Documents\\Grad School\\Statistics\\Final Project\\dji_WEEKLY.csv", 'w', newline ='') 
with file:   
    header = ['Year', 'Week Number', 'Average'] #Create the header for our new csv file
    writer = csv.DictWriter(file, fieldnames = header)#Create a writer object 
    writer.writeheader() #Writes the header
    
    for k in range(len(weeklyAverage)): #Iterate over the weekly averages to write to the csv
        #Writes the the three column values to the csv
        #Also calculates averege week by diving total index by count
        writer.writerow({'Year' : weeklyAverage[k][0],  
                         'Week Number': weeklyAverage[k][1],  
                         'Average': weeklyAverage[k][2]/weeklyAverage[k][3]})
        #Another check just to make sure everything is running
        print(weeklyAverage[k][2]/weeklyAverage[k][3])       
