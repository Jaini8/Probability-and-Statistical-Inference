monte.hall <-function(N,n=3){ #Declaration of function.
  winswitch<-NULL #Initializing value of winswitch to NULL. Variable to store count of wins after switching the door.
  winstay<-NULL #Initializing value of winstay to NULL. Variable to store count of wins after choosing the same door.
  for(i in 1:N){ #Starting “for” loop for N number of decisions.
    true.door<-sample(n,n) #Selecting n random numbers (from 1 to n) using sample function and assigning generated random array to true.door. 
    choice.door<-sample(n,1) #Selecting 1 random number from list of n numbers using sample function and assigning that value as chosen door.
    #Mdoor<-sample(true.door,1) #This variable is not used anywhere in the code. Hence, useless line.
    if(choice.door==true.door[1]) # Comparing value of chosen door with the first value in array of true door. (The values of true.door[1] and choice.door are generated randomly, so for each “for” loop, this condition will defer.)
    { #if chosen door is true door,
      winswitch<-c(winswitch,0) # switch will not be done and winswtich will be counted 0.
      winstay<-c(winstay,1) # stay will be done and winstay will be counted 1.
    }
    else{ #if chosen door is not true door,
      winswitch<-c(winswitch,1/(n-2)) # switch will be done and winswitch will be counted.
      winstay<-c(winstay,0) #winstay will be counted 0.
    }
  }
  m1<-cbind(winswitch,winstay) #Binding values of winswitch and winstay as columns and storing it as m1. m1 will be data frame containing values of winswitch and winstay.
  apply(m1,2,sum)/N #Adding the values of winswitch and winstay (column wise) and then returning the total value.
}
