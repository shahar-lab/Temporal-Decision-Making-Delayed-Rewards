rm(list=ls())
library(dplyr)
library(ggplot2)
library(brms)
library(rstan)
library(bayestestR)

df <- read.csv('./data/df_raw.csv')


simulate_choice <- function (immediate_reward, delayed_reward, individual_k, delay) {
  sim_choice <- immediate_reward
  
}


for(i in 1:nrow(df)) {  
  df$simulate_choice[i] <- simulate_choice(df$offerI[i],df$offerD[i],df$individual_k[i],df$Delay[i])
}
