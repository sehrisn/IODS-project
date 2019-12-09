#sehrish Naveed
#date 25.11.2019

#Link for Human development data
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
dim(hd)
str(hd)
summary(hd)

#dimensions of HD data
+ 195 observations of 8 variables, the variables are as follows:
$  HDI.Rank                              : int  1 2 3 4 5 6 6 8 9 9 ...
$ Country                               : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
$ Human.Development.Index..HDI.         : num  0.944 0.935 0.93 0.923 0.922 0.916 0.916 0.915 0.913 0.913 ...
$ Life.Expectancy.at.Birth              : num  81.6 82.4 83 80.2 81.6 80.9 80.9 79.1 82 81.8 ...
$ Expected.Years.of.Education           : num  17.5 20.2 15.8 18.7 17.9 16.5 18.6 16.5 15.9 19.2 ...
$ Mean.Years.of.Education               : num  12.6 13 12.8 12.7 11.9 13.1 12.2 12.9 13 12.5 ...
$ Gross.National.Income..GNI..per.Capita: chr  "64,992" "42,261" "56,431" "44,025" ...
$ GNI.per.Capita.Rank.Minus.HDI.Rank    : int  5 17 6 11 9 11 16 3 11 23 ...
> summary(hd)
HDI.Rank        Country          Human.Development.Index..HDI. Life.Expectancy.at.Birth
Min.   :  1.00   Length:195         Min.   :0.3480                Min.   :49.00           
1st Qu.: 47.75   Class :character   1st Qu.:0.5770                1st Qu.:65.75           
Median : 94.00   Mode  :character   Median :0.7210                Median :73.10           
Mean   : 94.31                      Mean   :0.6918                Mean   :71.07           
3rd Qu.:141.25                      3rd Qu.:0.8000                3rd Qu.:76.80           
Max.   :188.00                      Max.   :0.9440                Max.   :84.00           
NA's   :7                                                                                 
Expected.Years.of.Education Mean.Years.of.Education Gross.National.Income..GNI..per.Capita
Min.   : 4.10               Min.   : 1.400          Length:195                            
1st Qu.:11.10               1st Qu.: 5.550          Class :character                      
Median :13.10               Median : 8.400          Mode  :character                      
Mean   :12.86               Mean   : 8.079                                                
3rd Qu.:14.90               3rd Qu.:10.600                                                
Max.   :20.20               Max.   :13.100                                                

GNI.per.Capita.Rank.Minus.HDI.Rank
Min.   :-84.0000                  
1st Qu.: -9.0000                  
Median :  1.5000                  
Mean   :  0.1862                  
3rd Qu.: 11.0000                  
Max.   : 47.0000                  
NA's   :7  

#changing variables names

library(dplyr)
colnames(hd)[1] <- "rank.hd"
colnames(hd)[2] <- "country"
colnames(hd)[3] <- "HDI"
colnames(hd)[4] <- "lifexp"
colnames(hd)[5] <- "expecteduc"
colnames(hd)[6] <- "meaneduc"
colnames(hd)[7] <- "GNIcapita"
colnames(hd)[8] <- "GNIrank"

#Link for gender inequality data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")
dim(gii)
str(gii)
summary(gii)

#summary of gender inequality data is as follows:
+ 'data.frame':	195 obs. of  10 variables:
$ GII.Rank                                    : int  1 2 3 4 5 6 6 8 9 9 ...
$ Country                                     : chr  "Norway" "Australia" "Switzerland" "Denmark" ...
$ Gender.Inequality.Index..GII.               : num  0.067 0.11 0.028 0.048 0.062 0.041 0.113 0.28 0.129 0.157 ...
$ Maternal.Mortality.Ratio                    : int  4 6 6 5 6 7 9 28 11 8 ...
$ Adolescent.Birth.Rate                       : num  7.8 12.1 1.9 5.1 6.2 3.8 8.2 31 14.5 25.3 ...
$ Percent.Representation.in.Parliament        : num  39.6 30.5 28.5 38 36.9 36.9 19.9 19.4 28.2 31.4 ...
$ Population.with.Secondary.Education..Female.: num  97.4 94.3 95 95.5 87.7 96.3 80.5 95.1 100 95 ...
$ Population.with.Secondary.Education..Male.  : num  96.7 94.6 96.6 96.6 90.5 97 78.6 94.8 100 95.3 ...
$ Labour.Force.Participation.Rate..Female.    : num  61.2 58.8 61.8 58.7 58.5 53.6 53.1 56.3 61.6 62 ...
$ Labour.Force.Participation.Rate..Male.      : num  68.7 71.8 74.9 66.4 70.6 66.4 68.1 68.9 71 73.8 ...
> summary(gii)
GII.Rank        Country          Gender.Inequality.Index..GII. Maternal.Mortality.Ratio
Min.   :  1.00   Length:195         Min.   :0.0160                Min.   :   1.0          
1st Qu.: 47.75   Class :character   1st Qu.:0.2030                1st Qu.:  16.0          
Median : 94.00   Mode  :character   Median :0.3935                Median :  69.0          
Mean   : 94.31                      Mean   :0.3695                Mean   : 163.2          
3rd Qu.:141.25                      3rd Qu.:0.5272                3rd Qu.: 230.0          
Max.   :188.00                      Max.   :0.7440                Max.   :1100.0          
NA's   :7                           NA's   :33                    NA's   :10              
Adolescent.Birth.Rate Percent.Representation.in.Parliament
Min.   :  0.60        Min.   : 0.00                       
1st Qu.: 15.45        1st Qu.:12.47                       
Median : 40.95        Median :19.50                       
Mean   : 49.55        Mean   :20.60                       
3rd Qu.: 71.78        3rd Qu.:27.02                       
Max.   :204.80        Max.   :57.50                       
NA's   :5             NA's   :3                           
Population.with.Secondary.Education..Female. Population.with.Secondary.Education..Male.
Min.   :  0.9                                Min.   :  3.20                            
1st Qu.: 27.8                                1st Qu.: 38.30                            
Median : 55.7                                Median : 60.00                            
Mean   : 54.8                                Mean   : 60.29                            
3rd Qu.: 81.8                                3rd Qu.: 85.80                            
Max.   :100.0                                Max.   :100.00                            
NA's   :26                                   NA's   :26                                
Labour.Force.Participation.Rate..Female. Labour.Force.Participation.Rate..Male.
Min.   :13.50                            Min.   :44.20                         
1st Qu.:44.50                            1st Qu.:68.88                         
Median :53.30                            Median :75.55                         
Mean   :52.61                            Mean   :74.74                         
3rd Qu.:62.62                            3rd Qu.:80.15                         
Max.   :88.10                            Max.   :95.50                         
NA's   :11                               NA's   :11 

##chaging variable names

# gii is available

# print out the column names of the data
colnames(gii)

# change the name of the columns

library(dplyr)
colnames(gii)[1] <- "rank.gii"
colnames(gii)[2] <- "country"
colnames(gii)[3] <- "GII"
colnames(gii)[4] <- "MMR"
colnames(gii)[5] <- "ABR"
colnames(gii)[6] <- "PRP"
colnames(gii)[7] <- "PSE.F"
colnames(gii)[8] <- "PSE.M"
colnames(gii)[9] <- "LFPR.F"
colnames(gii)[10] <- "LFPR.M" 

# print out the new column names of the data
colnames(gii)

##Results
*Variable names are as follows:
[1]"GII.Rank"                                    
[2] "Country"                                     
[3] "Gender.Inequality.Index..GII."               
[4] "Maternal.Mortality.Ratio"                    
[5] "Adolescent.Birth.Rate"                       
[6] "Percent.Representation.in.Parliament"        
[7] "Population.with.Secondary.Education..Female."
[8] "Population.with.Secondary.Education..Male."  
[9] "Labour.Force.Participation.Rate..Female."    
[10] "Labour.Force.Participation.Rate..Male."


##Mutate the Gender inequality data

gii <- mutate(gii, PSE.R = (PSE.F/PSE.M))
gii <- mutate(gii, LFPR.R = (LFPR.F/LFPR.M))

##6. Joining HDI dataset with GII dataset and saving it
human <- inner_join(hd, gii)

###head(human)
write.csv(human,"data/human.csv")

# read the human data
human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", sep  =",", header = T)

# look at the (column) names of human
names(human)

# look at the structure of human
str(human)

# print out summaries of the variables
summary(human)

## data frame has	195 obs. of  19 variables. There are 4 integer variables,2 factor variables and all others are numericals. the details are as follows:    
 $ HDI.Rank      : int  1 2 3 4 5 6 6 8 9 9 ...
 $ Country       : Factor w/ 195 levels "Afghanistan",..: 129 10 169 48 124 67 84 186 33 125 ...
 $ HDI           : num  0.944 0.935 0.93 0.923 0.922 0.916 0.916 0.915 0.913 0.913 ...
 $ Life.Exp      : num  81.6 82.4 83 80.2 81.6 80.9 80.9 79.1 82 81.8 ...
 $ Edu.Exp       : num  17.5 20.2 15.8 18.7 17.9 16.5 18.6 16.5 15.9 19.2 ...
 $ Edu.Mean      : num  12.6 13 12.8 12.7 11.9 13.1 12.2 12.9 13 12.5 ...
 $ GNI           : Factor w/ 194 levels "1,096","1,123",..: 166 135 156 139 140 137 127 154 134 117 ...
 $ GNI.Minus.Rank: int  5 17 6 11 9 11 16 3 11 23 ...
 $ GII.Rank      : int  1 2 3 4 5 6 6 8 9 9 ...
 $ GII           : num  0.067 0.11 0.028 0.048 0.062 0.041 0.113 0.28 0.129 0.157 ...
 $ Mat.Mor       : int  4 6 6 5 6 7 9 28 11 8 ...
 $ Ado.Birth     : num  7.8 12.1 1.9 5.1 6.2 3.8 8.2 31 14.5 25.3 ...
 $ Parli.F       : num  39.6 30.5 28.5 38 36.9 36.9 19.9 19.4 28.2 31.4 ...
 $ Edu2.F        : num  97.4 94.3 95 95.5 87.7 96.3 80.5 95.1 100 95 ...
 $ Edu2.M        : num  96.7 94.6 96.6 96.6 90.5 97 78.6 94.8 100 95.3 ...
 $ Labo.F        : num  61.2 58.8 61.8 58.7 58.5 53.6 53.1 56.3 61.6 62 ...
 $ Labo.M        : num  68.7 71.8 74.9 66.4 70.6 66.4 68.1 68.9 71 73.8 ...
 $ Edu2.FM       : num  1.007 0.997 0.983 0.989 0.969 ...
 $ Labo.FM       : num  0.891 0.819 0.825 0.884 0.829 ...

# tidyr package and human are available

# access the stringr package
library(stringr)

# look at the structure of the GNI column in 'human'
str(human$GNI)

# remove the commas from GNI and print out a numeric version of it
str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric
> 
> # print out summaries of the variables
> summary(human)
HDI.Rank                     Country         HDI            Life.Exp    
Min.   :  1.00   Afghanistan        :  1   Min.   :0.3480   Min.   :49.00  
1st Qu.: 47.75   Albania            :  1   1st Qu.:0.5770   1st Qu.:65.75  
Median : 94.00   Algeria            :  1   Median :0.7210   Median :73.10  
Mean   : 94.31   Andorra            :  1   Mean   :0.6918   Mean   :71.07  
3rd Qu.:141.25   Angola             :  1   3rd Qu.:0.8000   3rd Qu.:76.80  
Max.   :188.00   Antigua and Barbuda:  1   Max.   :0.9440   Max.   :84.00  
NA's   :7        (Other)            :189                                   
Edu.Exp         Edu.Mean           GNI      GNI.Minus.Rank    
Min.   : 4.10   Min.   : 1.400   2,803  :  2   Min.   :-84.0000  
1st Qu.:11.10   1st Qu.: 5.550   1,096  :  1   1st Qu.: -9.0000  
Median :13.10   Median : 8.400   1,123  :  1   Median :  1.5000  
Mean   :12.86   Mean   : 8.079   1,130  :  1   Mean   :  0.1862  
3rd Qu.:14.90   3rd Qu.:10.600   1,228  :  1   3rd Qu.: 11.0000  
Max.   :20.20   Max.   :13.100   1,328  :  1   Max.   : 47.0000  
(Other):188   NA's   :7         
GII.Rank           GII            Mat.Mor         Ado.Birth     
Min.   :  1.00   Min.   :0.0160   Min.   :   1.0   Min.   :  0.60  
1st Qu.: 47.75   1st Qu.:0.2030   1st Qu.:  16.0   1st Qu.: 15.45  
Median : 94.00   Median :0.3935   Median :  69.0   Median : 40.95  
Mean   : 94.31   Mean   :0.3695   Mean   : 163.2   Mean   : 49.55  
3rd Qu.:141.25   3rd Qu.:0.5272   3rd Qu.: 230.0   3rd Qu.: 71.78  
Max.   :188.00   Max.   :0.7440   Max.   :1100.0   Max.   :204.80  
NA's   :7        NA's   :33       NA's   :10       NA's   :5       
Parli.F          Edu2.F          Edu2.M           Labo.F     
Min.   : 0.00   Min.   :  0.9   Min.   :  3.20   Min.   :13.50  
1st Qu.:12.47   1st Qu.: 27.8   1st Qu.: 38.30   1st Qu.:44.50  
Median :19.50   Median : 55.7   Median : 60.00   Median :53.30  
Mean   :20.60   Mean   : 54.8   Mean   : 60.29   Mean   :52.61  
3rd Qu.:27.02   3rd Qu.: 81.8   3rd Qu.: 85.80   3rd Qu.:62.62  
Max.   :57.50   Max.   :100.0   Max.   :100.00   Max.   :88.10  
NA's   :3       NA's   :26      NA's   :26       NA's   :11     
Labo.M         Edu2.FM          Labo.FM      
Min.   :44.20   Min.   :0.1717   Min.   :0.1857  
1st Qu.:68.88   1st Qu.:0.7284   1st Qu.:0.5987  
Median :75.55   Median :0.9349   Median :0.7514  
Mean   :74.74   Mean   :0.8541   Mean   :0.7038  
3rd Qu.:80.15   3rd Qu.:0.9968   3rd Qu.:0.8513  
Max.   :95.50   Max.   :1.4967   Max.   :1.0380  
NA's   :11      NA's   :26       NA's   :11
> 

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# removing the rows with missing values
complete.cases(human)
data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, complete.cases(human))
dim(human_)

#Excluding the observations from non country
tail(human_, 10)
last <- nrow(human_) - 7
human_ <- human[1:last, ]
dim(human_)

#defining the row names of the data by the country names
rownames(human_) <- human_$Country
human_ <- human_[-1]
dim(human_)
colnames(human_)

#saving file
write.csv(human_, file = "humandata.csv", row.names = TRUE)


# Overview and blotting the data

human <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human2.txt", header = TRUE, sep = ",")
head(human)
summary(human)
ggpairs(human)
cor(human) %>% corrplot

