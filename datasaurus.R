install.packages("ggstatsplot")
install.packages("remotes")

library(tidyverse)
library(psych)
library(ggstatsplot)
library(RColorBrewer)


remotes::install_github(
  repo = "IndrajeetPatil/ggstatsplot", # package path on GitHub
  dependencies = TRUE, # installs packages which ggstatsplot depends on
  upgrade_dependencies = TRUE # updates any out of date dependencies
)

datasaurus <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-10-13/datasaurus.csv')

# Starting code snippet provided by Tidy Tuesday

facet_plot <- ggplot(datasaurus, aes(x=x, y=y, colour=dataset))+
  geom_point()+
  theme_void()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol=3)

facet_plot

# The colours are ugly, can we change them?
# The Brewer palettes are usually better, but they only have 8-12 colours

display.brewer.all()

# The plot will be generated, but parts will be missing (only 8 plots here):

facet_brewer <- ggplot(datasaurus, aes(x=x, y=y, colour=dataset))+
  geom_point()+
  theme_void()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol=3) +
  scale_color_brewer(palette = "Set1")

facet_brewer

# Can we get more colours from Brewer?
# Yes: https://www.r-bloggers.com/2013/09/how-to-expand-color-palette-with-ggplot-and-rcolorbrewer/

colourCount = length(unique(datasaurus$dataset)) #this tells us how many colours we need
getPalette = colorRampPalette(brewer.pal(9, "Set1")) #this returns a function (that takes an integer argument)!

facet_brewer_12 <- ggplot(datasaurus, aes(x=x, y=y, colour=dataset))+
  geom_point()+
  theme_void()+
  theme(legend.position = "none")+
  facet_wrap(~dataset, ncol=3) +
  scale_colour_manual(values = getPalette(colourCount)) 

facet_brewer_12

# Challenge - try it with different palettes

# Challenge - could we get R to display the name of the colour together with the name of the dataset?

# Let's try something different - can we get two plots on top of one another?

datasaurus %>% 
  filter(dataset %in% c("circle", "slant_up")) %>% 
  ggplot(aes(x=x, y=y, colour=dataset)) + 
  geom_point()

datasaurus %>% 
  filter(dataset %in% c("circle", "slant_up")) %>% 
  ggplot(aes(x=x, y=y, colour=dataset)) + 
  geom_point() +
  theme(legend.position = "none")

datasaurus %>% 
  filter(dataset %in% c("circle", "slant_up")) %>% 
  ggplot(aes(x=x, y=y, colour=dataset)) + 
  geom_point() +
  theme(legend.position = "none") +
  scale_color_brewer(palette = "Paired")

# Challenge - how would we define the colours exactly?

# We can look at the data descriptive using the describeBy function from the psych package

describeBy(datasaurus, group = "dataset")

# Additional examples from Twitter:
# https://github.com/jack-davison/TidyTuesday
