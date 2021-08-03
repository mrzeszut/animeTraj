openair::trajPlot()


lond <- importTraj("london", 2010)
# well, HYSPLIT seems to think there certainly were conditions where trajectories
# orginated from Iceland...
trajPlot(selectByDate(lond, start = "15/4/2010", end = "21/4/2010"))
## End(Not run)

# plot by day, need a column that makes a date
## Not run: 
lond$day <- as.Date(lond$date)

trajPlot(test %>% mutate(receptor = as.character(receptor)),
         group = "receptor")

## End(Not run)

# or show each day grouped by colour, with some other options set
## Not run: 
trajPlot(selectByDate(lond, start = "15/4/2010", end = "16/4/2010"),
         group = "day", col = "jet", lwd = 2, key.pos = "right", key.col = 1)

## End(Not run)
# more examples to follow linking with concentration measurements...

if(!require("devtools")) install.packages("devtools")
if(!require("ggmap")) devtools::install_github("dkahle/ggmap")
if(!require("gganimate")) install.packages("gganimate")
if(!require("gapminder")) install.packages("gapminder")
if(!require("gganimate")) install.packages("gganimate")
if(!require("gapminder")) install.packages("gapminder")
if(!require("gifski")) install.packages("gifski")
if(!require("tidyverse")) install.packages("tidyverse")



setwd("D:/read_hy2R")

met_air <- read.csv(file = "data_import.csv", sep = ";") %>% as_tibble()

# standaryzacja danych w celu wyswietlenia na wykresie z sprawdzneim parmaetrów
# odejmujemy mean z populacji i dzielimy przez sd z populacji
# srenia 

met_air %>% 
  mutate(date = as.POSIXct(time, tz = "GMT")) %>% 
  select(-time, -rain) %>% 
  mutate_if(is.numeric, list(scale)) %>% 
  select(-date) %>% 
  summarise_all(list(mean, sd)) %>% 
  summarise_all(round, digits = 1)


met_air_w <- met_air %>% 
  mutate(date = as.POSIXct(time, tz = "GMT")) %>% 
  select(-time, -rain) %>% 
  mutate_if(is.numeric, list(scale)) %>% 
  gather(key = param, value = value, temp:pm10) 



met_air_w %>%
  filter(param %in% c("pm10", "ws")) %>% 
  ggplot(aes(date, value)) +
  geom_line(aes(color = param), size = 1) + theme_bw()

met_air_w %>%
  filter(param %in% c("pm10", "wd")) %>% 
  ggplot(aes(date, value)) +
  geom_line(aes(color = param), size = 1) + theme_bw()

met_air %>%
  mutate(date = as.POSIXct(time, tz = "GMT")) %>% 
  select(-time, -rain) %>% 
  ggplot() +
  geom_line(aes(date, wd), size = 1, color = "blue") +
#  geom_line(aes(date, pm10), size = 1) + 
  theme_bw()



met_air %>% 
  mutate(date = as.POSIXct(time, tz = "GMT")) %>% 
  select(-time, -rain) %>% 
#  mutate_if(is.numeric, list(scale)) %>%
  ggplot(aes(ws, pm10)) +
  geom_point() + geom_smooth(method = "gam")




# mój klucz ggmap

api_key <- "AIzaSyAkddmHrqtFu8Sffv8crfzct3Xu6vIayMo"
register_google(key = api_key)

hy_map <- get_map(location = c(lon = 20, lat = 54.0), 
                  source = "stamen", 
                  zoom = 4, 
                  maptype = "terrain-background")

hy_map %>% ggmap()


test <- dane %>% 
  filter(date %in% c(as.POSIXct("2020-03-16 20:00:00", tz = "GMT") + (0:8 *3600))) %>% 
  mutate(receptor = as.character(receptor))

test <- test %>% 
  mutate(receptor = case_when(receptor == 1 ~ "Krak",
                              receptor == 2 ~ "NoSacz",
                              receptor == 3 ~ "Skaw",
                              receptor == 4 ~ "Tar",
                              receptor == 5 ~ "Trzeb",
                              receptor == 6 ~ "Zakopa"))

test <- test %>% 
  filter(receptor == "Krak") %>% 
  mutate(date3 = paste0(lubridate::day(date) %>% as.character(), "-" , 
                        lubridate::hour(date) %>% as.character()))  
  
ggmap(hy_map) + 
  geom_point(data = test, 
             mapping = aes(x = lon, y = lat, 
                           color = as.character(date3), 
                           size = mixdepth*0.01)) +
#  geom_path(aes(group = date)) +
  # borders('world', 
  #         xlim   = c(0,30), 
  #         ylim   = c(46,51), 
  #         colour = 'black', 
  #         size   = .1) +
  
  # coord_quickmap(xlim=c(min(test$lon), max(test$lon)),  # lat 
  #                ylim=c(min(test$lat), max(test$lat))) +
  
   # coord_quickmap(xlim=c(-20, 23),  # lat 
   #                ylim=c(35, 64.5)) +
  theme_light() + 
  scale_color_grey() +
  labs(size = "Stężenie", 
       color = "Godzina zamknięcia", 
       x = "długość", y = "szerokość") +
  theme(panel.ontop=TRUE, 
        panel.background=element_blank(),
        plot.title = element_text(hjust = 0.5),
        plot.subtitle = element_text(hjust = 0.5)) -> tr1 ; tr1
  

tr1 + 
  transition_time(date2) + 
  ggtitle("Wykres trajektori wstecznych napływu zanieczyszczeń do Krakowa", 
          subtitle = "Data steps: {frame_time} :: End date 2020-01-01") + 
  shadow_mark(alpha = 0.3, size = 0.5) -> tr1_ani

  
animate(tr1_ani, fps = 10, nframes = 150, height = 800*0.8, width = 1000*0.8)

anim_save("traj_test1.gif")



