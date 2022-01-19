emission <- read_feather("CBD_Emission.feather") %>% 
  clean_names() %>% 
  select(-c(mean_pm10, jongno_p, jung_p), Jongno = jongno_kerb_p, 
         Sejong = sejong_p, Yulgok = yulgok_p, Samil = samil_p, Pirun = pirum_p)

dt_road <- fread("../GIS/jongno_pm10.csv") %>% 
  mutate(date = as.Date(date),
         month = month(date)) %>% 
  filter(type == "Road") %>% 
  select(1,3:5, pm10_rd = pm10_mean)


emission %>% 
  left_join(dt_road, by = c("step" = "counter")) -> emission


##

emission %>% 
  filter(emission_factor == 5) %>% 
  select(date, Samil, Jongno) %>% 
  group_by(date) %>% 
  summarise_all(list(max)) -> emission_date


emission_date %>% 
  reshape2::melt(id = "date", 
       variable.name = "Station", 
       value.name = "PM10") -> emission_long


emission_long %>%
  filter(Station == "Samil") %>% 
  ggplot(aes(date, PM10)) +
  geom_hline(yintercept=100, linetype="dashed", alpha = .5) +
  geom_hline(yintercept=200, linetype="dashed", alpha = .5) +
  geom_line(aes(colour = Station), size = 1, alpha = .7) +
  ylim(80,240)+
  labs(title = "Samil Road",
       x = "",
       y = "µg/m3",
       caption = "") +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(size=11)) -> plot_emission_samil


emission_long %>%
  filter(Station == "Jongno") %>% 
  ggplot(aes(date, PM10)) +
  geom_hline(yintercept=100, linetype="dashed", alpha = .5) +
  geom_hline(yintercept=200, linetype="dashed", alpha = .5) +
  geom_line(colour = "blue", size = 1, alpha = .7) +
  ylim(80,240)+
  labs(title = "Jongno",
       x = "",
       y = "µg/m3",
       caption = "") +
  theme_bw() +
  theme(legend.position = "none",
        text = element_text(size=11)) -> plot_emission_jongno
