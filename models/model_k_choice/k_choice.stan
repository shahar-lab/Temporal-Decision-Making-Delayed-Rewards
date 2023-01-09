data {

  //General fixed parameters for the experiment/models
  int<lower = 1> Nsubjects;                                         
  int<lower = 1> Ntrials;                                           
  int<lower = 1> Ntrials_per_subject[Nsubjects];                    
  int<lower = 2> Narms;                                             


  //Behavioral data:
  int<lower = 0> individual_k[Nsubjects,Ntrials];              
  int<lower = 0> offerI[Nsubjects,Ntrials];              
  int<lower = 0> offerD[Nsubjects,Ntrials];              
  int<lower = 0> choice[Nsubjects,Ntrials]; 
  int<lower = 0> delay [Nsubjects,Ntrials];
}


transformed data{
  int<lower = 1> Nparameters=1; 
}




parameters {
  //population level parameters 
  vector         [Nparameters] population_locations;      
  vector<lower=0>[Nparameters] population_scales;         
  
  //individuals level
  vector[Nsubjects] beta_random_effect;
}


transformed parameters {
  vector                  [Nsubjects] beta;

  for (subject in 1:Nsubjects) {
    //set indvidual parameters
    beta[subject]    =          (population_locations[2]  + population_scales[2] * beta_random_effect [subject]) ;
 
  }

}


model {
  
  // population level  
  population_locations  ~ normal(0, 2);            
  population_scales     ~ cauchy(0,2);        

  // indvidual level  
  beta_random_effect  ~ std_normal();
 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Likelihood function per subject per trial

  for (subject in 1:Nsubjects){

    vector [Narms]Qnet;
    real v_d;
    real v_i;
      for (trial in 1:Ntrials_per_subject[subject]){
        v_d = offerD[subject,trial]/(1+individual_k[subject,trial]*delay[subject,trial]);
        v_i = offerI[subject,trial];
        
        Qnet[0] = v_d;
        Qnet[1] = v_i;

        choice[subject,trial] ~ categorical_logit(beta[subject] * Qnet);
    
      }
  }
}
