data {
  int<lower=0> N; // number of measurements per machine
  int<lower=0> K; // number of machines
  array[N] vector[K] y; // An array of vectors containing the table data
}

parameters {
  real mu; // There is only a single mu for all machines
  real<lower=0> sigma; // There is only a single sigma for all machines
}

model {
  // priors
  mu ~ normal(0, 50);
  sigma ~ normal(0, 20);

  // likelihood
  for (k in 1:K){
    y[,k] ~ normal(mu, sigma);
  }
}

generated quantities {
  real ypred = normal_rng(mu, sigma);
}
