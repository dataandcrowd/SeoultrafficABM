#Sys.setenv(JAVA_HOME='/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/jdk-8u141-b15-p4aaoptkqukgdix6dh5ey236kllhluvr/jre') #Ubuntu cluster
#Sys.setenv(JAVA_HOME= "/home/hs621/jdk1.8.0_212-amd64/jre")
#Sys.setenv(JAVA_HOME= "C:/Program Files/Java/jre1.8.0_211")

Sys.setenv(JAVA_HOME= "/usr/lib/jvm/java-1.11.0-openjdk-amd64")

## Load packages
library(nlrx)
library(tidyverse) 
library(rcartocolor)
library(ggthemes) 

# office
netlogopath <- file.path("/home/hs621/NetLogo 6.0.4")
outpath <- file.path("~/out")

## Step1: Create a nl obejct:
nl <- nl(nlversion = "6.0.4",
         nlpath = netlogopath,
         modelpath = file.path("/data/github/seoulbigdata/fourdaemoon.nlogo"),
         jvmmem = 1024)


## Step2: Add Experiment
nl@experiment <- experiment(expname = "seoul",
                            outpath = outpath,
                            repetition = 1,   
                            tickmetrics = "true",
                            idsetup = "setup",  
                            idgo = "go",        
                            runtime = 21600,
                            evalticks=seq(1, 21600, by = 100),
                            constants = list("speed-variation" = .4,
                                             "no-of-cars" = 30,
                                             "scenario?" = "\"YES\""),
                            metrics.turtles =  list("turtles" = c("xcor", "ycor")),
                            metrics.patches = c("pxcor", "pycor", "dong-code", "no2_road")
)

# Evaluate if variables and constants are valid:
eval_variables_constants(nl)

#nl@simdesign <- simdesign_distinct(nl = nl, nseeds = 1)
nl@simdesign <- simdesign_simple(nl = nl, nseeds = 1)

# Step4: Run simulations:
init <- Sys.time()
results <- run_nl_all(nl = nl)
Sys.time() - init


# Attach results to nl object:
setsim(nl, "simoutput") <- results

# Report spatial data:
results_unnest <- unnest_simoutput(nl)

