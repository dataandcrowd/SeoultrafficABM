#Sys.setenv(JAVA_HOME='/usr/local/software/spack/spack-0.11.2/opt/spack/linux-rhel7-x86_64/gcc-5.4.0/jdk-8u141-b15-p4aaoptkqukgdix6dh5ey236kllhluvr/jre') #Ubuntu cluster
#Sys.setenv(JAVA_HOME= "/usr/lib/jvm/java-11-openjdk-amd64")
Sys.setenv(JAVA_HOME= "/usr/bin/java")
#Sys.setenv(JAVA_HOME= "C:/Program Files/Java/jre1.8.0_311/bin")

#.libPaths("/home/hs621/renv/lib/R/library")

## Load packages
library(nlrx) 
library(dplyr)
library(feather)
library(landscapemetrics)

############
# Software #
############
#netlogopath <- file.path("/usr/local/Cluster-Apps/netlogo/6.0.4")
#outpath <- file.path("/home/hs621/github/chapter5")

netlogopath <- file.path("/Applications/NetLogo 6.2.0")
outpath <- file.path("/Users/hyesop/github/SeoultrafficABM")

#netlogopath <- file.path("C:/Program Files/NetLogo 6.2.0")
#outpath <- file.path("D:/github/SeoultrafficABM")


## Step1: Create a nl obejct:
nl <- nl(nlversion = "6.0.4",
         nlpath = netlogopath,
         modelpath = file.path(outpath, "TRAPSim.nlogo"),
         jvmmem = 1024)

## Step2: Add Experiment
nl@experiment <- experiment(expname = "nlrx_spatial",
                            outpath = outpath,
                            repetition = 1,      
                            tickmetrics = "true",
                            idsetup = "setup",   
                            idgo = "go",
                            runtime = 1440,
                            evalticks=seq(1,1440, by = 1),
                            metrics.patches = c("pxcor", "pycor", "pm10"),
                            constants = list("health_loss" = 0.03,
                                             'emission-factor' = 5,
                                             "no-of-employees" = 1932,
                                             'car_ratio' = .05)
)

# Evaluate if variables and constants are valid:
eval_variables_constants(nl)

#nl@simdesign <- simdesign_ff(nl = nl, nseeds = 1)
nl@simdesign <- simdesign_simple(nl = nl, nseeds = 1)
#nl@simdesign <- simdesign_lhs(nl=nl,
#                              samples=100,
#                              nseeds=3,
#                              precision=3)


# Step4: Run simulations:
init <- Sys.time()
results <- run_nl_all(nl)
Sys.time() - init


# Attach results to nl object:
setsim(nl, "simoutput") <- results

# Report spatial data:
#results_unnest <- unnest_simoutput(nl)


gc()


## Create raster and point objects from patches and turtles data:
library(raster)
nlraster <- nl_to_raster(nl)

nlraster$spatial.raster %>% 
  raster_to_points() %>% 
  as.data.frame() %>% 
  mutate(z = na_if(z, 0)) %>% 
  na.omit() -> raster_df


#rm(nl)
#write_csv(results_unnest_patches, paste("patch_", results$`random-seed`[1], ".csv", sep = ""))
write_feather(raster_df, paste("CBD_raster_", results$`random-seed`[1], ".feather", sep = ""))



