#This code generate artificial data based on simulated parameters

rm(list=ls())
source('./functions/my_packages.R')
source('./functions/my_starter.R')
source('./functions/make_mystandata.R')


###convert to a standata format ###----------------------------------------------------------------------------------

#load artificial data
load(paste0(path$data,'/df.Rdata'))


#convert
data_for_stan<-make_mystandata(data=df, 
                               subject_column     =df$subject,
                               block_column       =df$block,
                               var_toinclude      =c(
                                 'trial',
                                 'individual_k',
                                 'offerI',
                                 'offerD',
                                 'choice',
                                 'delay'),
                               additional_arguments=list(Narms=2))

#save
save(data_for_stan,file=paste0(path$data,'/artificial_standata.Rdata'))


