head(bbdata)
library(magrittr)
library(dplyr)
library(ggplot2)

str(bbdata)


#selecting only the columns that I want from the data
bbdata1 = bbdata %>%
  select(., -simple_title, -main_artist, -last_pos, 
         -weeks, -change, -spotify_link, -spotify_id, -video_link,
         -analysis_url, -lyrics, -liveness, -speechiness, -acousticness,
         -acousticness, -instrumentalness, -time_signature, -key, -duration_ms,
         -loudness, -mode)
head(bbdata1) 

#adding 2018 where the year is NA because its all missing

bbdata2 = bbdata1 %>%
  mutate(., year = ifelse(is.na(year), 2018, year)) %>%
  filter(., broad_genre != "NA", broad_genre != 'unknown')

#arrange based on descending date and renaming the columns that I care about

bbdata3 = bbdata2 %>%
  arrange(., desc(date)) %>%
  select(., Date = date, Title = title, Artist = artist,
         "Peak_Position" = peak_pos, "Broad_Genre" = broad_genre,
         Energy = energy, Tempo = tempo, Danceability = danceability, Year = year,
         Rank = rank, Valence = valence)
bbdata3
#creating the rank groups

bbdataclean1 = bbdata3 %>%
  mutate(., Rank_Group = ifelse(Peak_Position<=10,"1 - 10",
                                ifelse(Peak_Position <= 25 & Peak_Position > 10,"11 - 25",
                            ifelse(Peak_Position > 25 & Peak_Position <= 50, "26-50",
                                   ifelse(Peak_Position > 50 & Peak_Position <= 75, "51-75",
                                          ifelse(Peak_Position>75,"76-100","NA"))))))
bbdataclean1

#renaming the broad_genres so that they look nice
bbdataclean2 = bbdataclean1 %>%
  mutate(., Broad_Genre = ifelse(Broad_Genre == "country", "Country",
                                 ifelse(Broad_Genre == "edm", "EDM",
                                        ifelse(Broad_Genre == "pop", "Pop",
                                               ifelse(Broad_Genre == "r&b", "R&B",
                                                      ifelse(Broad_Genre == "rap", "Rap",
                                                             ifelse(Broad_Genre == "rock",
                                                                    "Rock", "NA"))))))) %>%
  arrange(., desc(Year))

bbdataclean = bbdataclean2[!duplicated(bbdataclean2$Title), ]

str(bbdataclean2)
str(bbdataclean3)
  

str(bbdataclean)
bbdataclean

bbdata00 = bbdataclean %>%
  filter(., year == "2000")


bbdata05 = bbdataclean %>%
  filter(., year == '2005')

bbdata10 = bbdataclean %>%
  filter(., year == '2010')

bbdata15 = bbdataclean %>%
  filter(., year == '2015')

bbdata17 = bbdataclean %>%
  filter(., Year == '2017')


write.csv(bbdataclean, file = "bill_board_data.csv",row.names = FALSE)

bbdata00

g <- ggplot(data = bbdata17, aes(x = ))
g + geom_bar(aes(color = Rank_Group))

bbdataclean

bbdatapop = bbdataclean %>%
  filter(., Broad_Genre == "Pop")

bbdatarap = bbdataclean %>%
  filter(., Broad_Genre == "Rap")


gg <- ggplot(data = bbdatapop, aes(x = Year, y = Rank_Group))
gg + geom_bar(aes( fill = Rank_Group), stat = 'identity')

gg <- ggplot(data = bbdatarap, aes(x = Year, y = Rank_Group))
gg + geom_bar(aes(fill = Rank_Group), stat = 'identity')

