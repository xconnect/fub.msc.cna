# load needed libraries
library(Hmisc)      # describtive statistics
library(dplyr)      # xtra functions
library(igraph)     # iGraph
library(networkD3)  # xtra graphs

# load data into data frames
df_pers <- read.csv("~/GitHub/CNA_2016/project/data/POperson.csv", encoding = "UTF8", sep = ";")
df_poke <- read.csv("~/GitHub/CNA_2016/project/data/POpokemon.csv", encoding = "UTF8", sep = ";")
df_pers2pers <- read.csv("~/GitHub/CNA_2016/project/data/POperson-person.csv", encoding = "UTF8", sep = ";")
df_poke2poke <- read.csv("~/GitHub/CNA_2016/project/data/POpokemon-pokemon.csv", encoding = "UTF8", sep = ";")

# create clean person-person data frame
y <- merge.data.frame(df_pers,df_pers2pers, by.x = "ID", by.y = "PID2", all=FALSE)
d_pers2pers <- merge.data.frame(df_pers,y,by.x = "ID", by.y = "PID1", all=FALSE)
d_pers2pers <- d_pers2pers[,!(names(d_pers2pers) == "ID")]       # remove columns
names(d_pers2pers)[names(d_pers2pers)=="Name.x"] <- "Winner"     # rename column
names(d_pers2pers)[names(d_pers2pers)=="Name.y"] <- "Looser"     # rename column

# create clean pokemon-pokemon data frame
head(df_poke)

y <- merge.data.frame(df_poke, df_poke2poke, by.x = "ID", by.y = "PokeID2", all=FALSE)
d_poke2poke <- merge.data.frame(df_poke, y, by.x = "ID", by.y = "PokeID1", all=FALSE)
d_poke2poke <- d_poke2poke[,!(names(d_poke2poke) == "ID")]
names(d_poke2poke)[names(d_poke2poke)=="PokemonDE.x"] <- "PokemonDE.Winner"
names(d_poke2poke)[names(d_poke2poke)=="PokemonEN.x"] <- "PokemonEN.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Type1.x"] <- "Type1.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Type2.x"] <- "Type2.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Total.x"] <- "Total.Winner"
names(d_poke2poke)[names(d_poke2poke)=="HP.x"] <- "HP.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Attack.x"] <- "Attack.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Defense.x"] <- "Defense.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Speed.Attack.x"] <- "Speed.Attack.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Speed.Defense.x"] <- "Speed.Defense.Winner"
names(d_poke2poke)[names(d_poke2poke)=="Speed.x"] <- "Speed.Winner"
names(d_poke2poke)[names(d_poke2poke)=="PokemonDE.y"] <- "PokemonDE.Looser"
names(d_poke2poke)[names(d_poke2poke)=="PokemonEN.y"] <- "PokemonEN.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Type1.y"] <- "Type1.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Type2.y"] <- "Type2.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Total.y"] <- "Total.Looser"
names(d_poke2poke)[names(d_poke2poke)=="HP.y"] <- "HP.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Attack.y"] <- "Attack.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Defense.y"] <- "Defense.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Speed.Attack.y"] <- "Speed.Attack.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Speed.Defense.y"] <- "Speed.Defense.Looser"
names(d_poke2poke)[names(d_poke2poke)=="Speed.y"] <- "Speed.Looser"

d_poke2poke <- d_poke2poke[c("PokemonDE.Winner", "PokemonDE.Looser", "Type1.Winner", "Type2.Winner", "Type1.Looser", "Type2.Looser")]
#d_poketype2poketype <- d_poke2poke[c()]
head(d_poke2poke)

G_pers2pers <- graph.data.frame(d_pers2pers, directed=TRUE, vertices=NULL)
G_poke2poke <- graph.data.frame(d_poke2poke, directed=TRUE, vertices=NULL)

E(G_poke2poke)$color = 'red'
E(G_poke2poke)$width = 1:length(G_poke2poke)

#V(G_poke2poke)$name %in% df_poke$PokemonDE
#match(V(G_poke2poke)$name, df_poke$PokemonDE)
#o = match(V(G_poke2poke)$name, df_poke$PokemonDE)
#df_poke_sorted = df_poke[o,]
# V(G_poke2poke)$type1 = df_poke_sorted$Type1
# summary(G_poke2poke)


plot.igraph(G_pers2pers,
            layout=layout.kamada.kawai,
            vertex.size=5,
            vertex.label.family='sans',
            vertex.label.font=2,
            vertex.label.cex=0.75,
            vertex.label.dist=-0.3,
            edge.width=1)

plot.igraph(G_poke2poke,
            layout=layout.reingold.tilford,
        
            vertex.size=5,
            vertex.label.family='sans',
            vertex.label.font=2,
            vertex.label.cex=0.75,
            vertex.label.dist=-0.3)

