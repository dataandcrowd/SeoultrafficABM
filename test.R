#Sys.setenv(JAVA_HOME= "/Library/Java/JavaVirtualMachines/jdk1.8.0_311.jdk/Contents/Home")
Sys.setenv(JAVA_HOME= "C:/Program Files/Java/jre1.8.0_311/bin")

library(nlrx)
# Windows default NetLogo installation path (adjust to your needs!):
netlogopath <- file.path("C:/Program Files/NetLogo 6.0.4")
modelpath <- file.path(netlogopath, "app/models/Sample Models/Biology/Wolf Sheep Predation.nlogo")
outpath <- file.path("C:/out")
# Unix default NetLogo installation path (adjust to your needs!):
netlogopath <- file.path("/home/NetLogo 6.0.3")
modelpath <- file.path(netlogopath, "app/models/Sample Models/Biology/Wolf Sheep Predation.nlogo")
outpath <- file.path("/home/out")
# Mac
netlogopath <- file.path("/Users/hyesop/NetLogo 6.0.4")
modelpath <- file.path(netlogopath, "models/Sample Models/Biology/Wolf Sheep Predation.nlogo")
outpath <- file.path("/Users/hyesop")



nl <- nl(nlversion = "6.0.4",
         nlpath = netlogopath,
         modelpath = modelpath,
         jvmmem = 1024)

nl@experiment <- experiment(expname="wolf-sheep",
                            outpath=outpath,
                            repetition=1,
                            tickmetrics="true",
                            idsetup="setup",
                            idgo="go",
                            runtime=50,
                            evalticks=seq(40,50),
                            metrics=c("count sheep", "count wolves", "count patches with [pcolor = green]"),
                            variables = list('initial-number-sheep' = list(min=50, max=150, qfun="qunif"),
                                             'initial-number-wolves' = list(min=50, max=150, qfun="qunif")),
                            constants = list("model-version" = "\"sheep-wolves-grass\"",
                                             "grass-regrowth-time" = 30,
                                             "sheep-gain-from-food" = 4,
                                             "wolf-gain-from-food" = 20,
                                             "sheep-reproduce" = 4,
                                             "wolf-reproduce" = 5,
                                             "show-energy?" = "false"))

# Evaluate nl object:
eval_variables_constants(nl)
print(nl)

nl@simdesign <- simdesign_lhs(nl=nl,
                              samples=100,
                              nseeds=3,
                              precision=3)

# Run all simulations (loop over all siminputrows and simseeds)
results <- run_nl_all(nl)
