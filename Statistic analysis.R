### ЗАДАНИЕ №1 - Оценка преподавания родного языка ###

#Загрузим и активируем библиотеку ggplot для визуализиции данные:
# install.packages("ggplot2")
# install.packages("dplyr")
# install.packages("readr")
#install.packages("colorspace")
install.packages("plotrix")

library(ggplot2)
library(dplyr)
library(readr)
library(tidyr)
library(colorspace)

# Скачаем и сохраним исходные данные:
download.file("https://raw.githubusercontent.com/dashapopova/CorpusMethods/main/HWs/hw2.csv", "hw2.csv")
df<-read.csv("hw2.csv")

# Разделим исходные данные на две переменные:
df <- separate(df, col=khanty.komi, into=c('khanti', 'komi'), sep=';')

# Определим тип данных в датасете:
str(df)

# Преобразуем тип character в числовой:
df$khanti <- as.numeric(df$khanti)
df$komi <- as.numeric(df$komi)

# Рассчитаем среднее и медиану для каждой переменной:
khanti_mean <- mean(df$khanti)
komi_mean <- mean(df$komi)
khanti_median <- median(df$khanti)
komi_median <- median(df$komi)

# Сохраним в табличку:
first_col <- c("Среднее значение", "Медиана")
second_col <- c(khanti_mean, khanti_median)
third_col <- c(komi_mean, komi_median)
df.table <- data.frame(first_col, second_col, third_col)
colnames(df.table) <- c('', 'Ханты', 'Коми')
  
# Построим гистограмму распределения оценок для каждой группы учеников:
ggplot() + 
  geom_bar(data = df,mapping = aes(y = khanti, fill = "Ханты"), alpha = 0.3) +
  geom_bar(data = df,mapping = aes(x= (..count..)*(-1), y = komi, fill = "Коми"), alpha = 0.3) +
  labs(x = "Количество", y = "Оценка", fill = "Язык") +
  theme(axis.text.x=element_blank())

norm_t_khanti <- shapiro.test(df$khanti)$p.value
norm_t_komi <- shapiro.test(df$komi)$p.value

mann_test <- wilcox.test(x = df$khanti, y = df$komi)$p.value


### ЗАДАНИЕ №2 - Линейная регрессия: рост и вес супергероев ###


# Скачаем и сохраним исходные данные:
download.file("https://raw.githubusercontent.com/dashapopova/Intro-to-R/main/HWs/heroes_information.csv", "heroes_information.csv")
df2 <- read.csv("heroes_information.csv")

# Удалим отрицательные значения и ячейки со значением "-":
df2 <- subset(df2, df2$Height > 0)
df2 <- subset(df2, df2$Weight > 0)
df2 <- subset(df2, df2$Gender != '-')

# Построим линейную модель влияния веса на рост супергероев:
fit <- lm(df2$Height ~ df2$Weight, df2)

fit
summary(fit)

ggplot(df2, aes(Weight, Height)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = F)

# Определим по линейной модели рост (мой вес 60 кг):
intercept <- fit$coefficients[1]
b_1 <- fit$coefficients[2]
My_height <- intercept + b_1*60

# Мой рост должен составлять 182 см

# Проверим на нормальность наши переменные:
norm_t_weight <- shapiro.test(df2$Weight)$p.value
norm_t_height <- shapiro.test(df2$Height)$p.value
# p-значение значительно ниже 0.05 - отвергаем нулевую гипотезу - 

# Поскольку гипотеза о нормальности распределения была отвержена, 
# считаем ранговый коэффициент корреляции Спирмана:
spear_cor <- cor.test(df2$Weight, y = df2$Height, method = "spearman")
summary(spear_cor)


std.error(df2$Height)

