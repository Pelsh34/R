### ������� �1 - ������ ������������ ������� ����� ###

#�������� � ���������� ���������� ggplot ��� ������������ ������:
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

# ������� � �������� �������� ������:
download.file("https://raw.githubusercontent.com/dashapopova/CorpusMethods/main/HWs/hw2.csv", "hw2.csv")
df<-read.csv("hw2.csv")

# �������� �������� ������ �� ��� ����������:
df <- separate(df, col=khanty.komi, into=c('khanti', 'komi'), sep=';')

# ��������� ��� ������ � ��������:
str(df)

# ����������� ��� character � ��������:
df$khanti <- as.numeric(df$khanti)
df$komi <- as.numeric(df$komi)

# ���������� ������� � ������� ��� ������ ����������:
khanti_mean <- mean(df$khanti)
komi_mean <- mean(df$komi)
khanti_median <- median(df$khanti)
komi_median <- median(df$komi)

# �������� � ��������:
first_col <- c("������� ��������", "�������")
second_col <- c(khanti_mean, khanti_median)
third_col <- c(komi_mean, komi_median)
df.table <- data.frame(first_col, second_col, third_col)
colnames(df.table) <- c('', '�����', '����')
  
# �������� ����������� ������������� ������ ��� ������ ������ ��������:
ggplot() + 
  geom_bar(data = df,mapping = aes(y = khanti, fill = "�����"), alpha = 0.3) +
  geom_bar(data = df,mapping = aes(x= (..count..)*(-1), y = komi, fill = "����"), alpha = 0.3) +
  labs(x = "����������", y = "������", fill = "����") +
  theme(axis.text.x=element_blank())

norm_t_khanti <- shapiro.test(df$khanti)$p.value
norm_t_komi <- shapiro.test(df$komi)$p.value

mann_test <- wilcox.test(x = df$khanti, y = df$komi)$p.value


### ������� �2 - �������� ���������: ���� � ��� ����������� ###


# ������� � �������� �������� ������:
download.file("https://raw.githubusercontent.com/dashapopova/Intro-to-R/main/HWs/heroes_information.csv", "heroes_information.csv")
df2 <- read.csv("heroes_information.csv")

# ������ ������������� �������� � ������ �� ��������� "-":
df2 <- subset(df2, df2$Height > 0)
df2 <- subset(df2, df2$Weight > 0)
df2 <- subset(df2, df2$Gender != '-')

# �������� �������� ������ ������� ���� �� ���� �����������:
fit <- lm(df2$Height ~ df2$Weight, df2)

fit
summary(fit)

ggplot(df2, aes(Weight, Height)) +
  geom_point(size = 3) +
  geom_smooth(method = "lm", se = F)

# ��������� �� �������� ������ ���� (��� ��� 60 ��):
intercept <- fit$coefficients[1]
b_1 <- fit$coefficients[2]
My_height <- intercept + b_1*60

# ��� ���� ������ ���������� 182 ��

# �������� �� ������������ ���� ����������:
norm_t_weight <- shapiro.test(df2$Weight)$p.value
norm_t_height <- shapiro.test(df2$Height)$p.value
# p-�������� ����������� ���� 0.05 - ��������� ������� �������� - 

# ��������� �������� � ������������ ������������� ���� ���������, 
# ������� �������� ����������� ���������� ��������:
spear_cor <- cor.test(df2$Weight, y = df2$Height, method = "spearman")
summary(spear_cor)


std.error(df2$Height)

