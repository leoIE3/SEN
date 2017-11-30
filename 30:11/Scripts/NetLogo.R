
####################################################################
# Read in the Data
####################################################################

# experiment with dropping off the header
mydata=read.csv("Data/pop.csv",skip=18)

# $ is an accessor -- find the named column "x"in mydata
t <- mydata$x

###################################################################
# Creating a New Data Frame
###################################################################
sheep <- mydata$y
wolves <- mydata$y.1
df <- data.frame(t,sheep,wolves)

##################################################################
# Descriptive Statistics of the Data
##################################################################
summary(df)
indexWithMaxNumSheep = which.max(df$sheep) #line that gives max
df$sheep[indexWithMaxNumSheep] #what is the value of the max line

##################################################################
# Line Plots and Histograms
##################################################################
hist(sheep,breaks=40,col='blue')

plot(t,sheep)
plot(t,sheep,type='l',col='red')
lines(t,wolves,col='green')

#################################################################
# Iterators and Phase Plots 
#################################################################
i = length(sheep) #rows in variable
last_wolf = '' #initialize 
new_wolf = ''
last_sheep =''
new_sheep=''
#for every time step iterate j
#if time step >1 create index k

for (j in 1:length(t)) {
  
  if (j > 1) { 
    k = j-1
    last_sheep[k] <- sheep[k]
    new_sheep[k] <- sheep[j]
    last_wolf[k] <- wolves[k]
    new_wolf[k] <- wolves[j]
    new_t <- k
  } 
} 
phase <- data.frame(last_sheep,new_sheep,last_wolf,new_wolf)

######################################################################
# Labels and Colors 
######################################################################
plot(last_sheep, new_sheep,type='l',col='green')
lines(last_wolf,new_wolf,col='red')
plot(new_wolf,last_sheep,type='l',col='red')
plot(new_wolf,last_sheep,type='l',col='red', main="Phase Plot",xlab="Wolves at (t+1)",ylab="Wolves at (t)")

######################################################################
# Saving Your Images
######################################################################
png(filename="phase.png")
plot(new_wolf,last_sheep,type='l',col='red', main="Phase Plot",xlab="Wolves at (t+1)",ylab="Wolves at (t)")
dev.off()

#####################################################################
# Saving Your Data Frames
#####################################################################
write.csv(df, file = "WolfSheep.csv")
