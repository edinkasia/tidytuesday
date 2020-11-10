# installing packages
#install.packages("gganimate")
#install.packages("gifski")
library(tidyverse)
library(gifski)
library(gganimate)

# Loading in the data
mobile <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-10/mobile.csv')
landline <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-11-10/landline.csv')

#basic graph
p <- landline %>% 
  group_by(continent) %>% 
  filter(continent == "Europe") %>% 
  ggplot(aes(x = year, y = landline_subs)) +
  geom_point()

plot(p)

# learning about gganimate
# using this tutorial: https://gganimate.com/articles/gganimate.html
anim <- p +
  transition_states(entity,
                    transition_length = 2,
                    state_length = 1)

anim
