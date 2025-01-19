#defs
library(ggplot2)

# ielasam datus
data <- read.csv("SystemAdministrators.csv")

# Veicam nelielas manipulācijas ar DF, lai iekš plot viss ir latviski
data$Completed.task <- ifelse(data$Completed.task == "Yes", "Jā", "Nē")

# Izkliedes diagrammas izveide
ggplot(data, aes(x = Experience, y = Training, color = Completed.task)) +
  geom_point(size = 3, alpha = 0.7) +
  labs(
    #Parametriem plot piešķiram nosaukumus
    title = "Pieredze vs. Apmācības (krāsas pēc uzdevuma paveikšanas)",
    x = "Pieredze (gadi)",
    y = "Apmācību kredīti",
    color = "Paveikts uzdevums"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14),
    axis.title = element_text(size = 12),
    legend.title = element_text(size = 12),
    legend.text = element_text(size = 10)
  )

##šo izdzēst - neveiksmīgs piemērs
ggplot(data, aes(x = Completed.task, y = Training, fill = Completed.task)) +
  geom_violin(alpha = 0.7) +
  labs(
    title = "Violin",
    x = "Taski",
    y = "Kredīti"
  ) +
  theme_minimal()

#veicam datu vizualizāciju savādāk
install.packages("GGally")
library(GGally)

ggpairs(data, aes(color = Completed.task), title = "Pāru izkliedes diagrammas")


# Izmantojot rpart bibliotēku, veicam lēmumu koka izveidi
install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)


tree_model <- rpart(Completed.task ~ Experience + Training, data = data, method = "class")

# Plot
rpart.plot(tree_model, main = "Lēmumu koks pēc paveiktā uzdevuma")
