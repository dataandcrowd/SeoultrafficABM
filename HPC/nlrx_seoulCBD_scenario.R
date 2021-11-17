Sys.setenv(JAVA_HOME='/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/jdk-8u141-b15-p4aaoptkqukgdix6dh5ey236kllhluvr/jre') #Ubuntu cluster
#Sys.setenv(JAVA_HOME= "/usr/lib/jvm/java-11-openjdk-amd64")

.libPaths("/home/hs621/renv/lib/R/library")

## Load packages
library(nlrx)
library(dplyr)
#library(rcartocolor)
#library(ggthemes) 
library(feather)

# Office
netlogopath <- file.path("/usr/local/Cluster-Apps/netlogo/6.0.4")
outpath <- file.path("/home/hs621/github/chapter5")



## Step1: Create a nl obejct:
nl <- nl(nlversion = "6.0.4",
         nlpath = netlogopath,
         modelpath = file.path(outpath, "CBD_Cars_July01.nlogo"),
         jvmmem = 1024)

## Step2: Add Experiment
nl@experiment <- experiment(expname = "nlrx_spatial",
                            outpath = outpath,
                            repetition = 1,      
                            tickmetrics = "true",
                            idsetup = "setup",   
                            idgo = "go",
                            runtime = 127740,
                            evalticks=seq(1,127740, by = 1),
                            metrics = c("mean-pm10",
                                        "JongnoKerb_p",
                                        "Samil_p",
                                        "Sejong_p",
                                        "Pirum_p",
                                        "Yulgok_p",
                                        "[health] of one-of employees",
                                        "[health] of one-of cars with [not random-car]",
                                        "Drivers_p",
                                        "Walkers_p"
                                        ),
                            variables = list("car_ratio" = list(values = c(0.005,0.025, .05)),
                                             "awareness" = list(values = c("\"no\"", "\"yes\""))),
                            constants = list("emission-factor" = 5,
                                             "no-of-employees" = 1932,
                                             "medication" = 10,
                                             "health_loss" = 0.1)  
)

# Evaluate if variables and constants are valid:
eval_variables_constants(nl)

nl@simdesign <- simdesign_ff(nl = nl, nseeds = 1)
#nl@simdesign <- simdesign_simple(nl = nl, nseeds = 1)
#nl@simdesign <- simdesign_distinct(nl=nl, nseeds=1)


# Step4: Run simulations:
init <- Sys.time()
results <- run_nl_all(nl = nl)
Sys.time() - init

gc()

results$`random-seed`[1]

write_feather(results, paste("Scenario_", results$`random-seed`[1], ".feather", sep = ""))



