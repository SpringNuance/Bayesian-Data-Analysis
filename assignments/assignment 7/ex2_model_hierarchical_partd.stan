data {
  int<lower=0> N; // number of measurements per machine
  int<lower=0> K; // number of machines
  array[N] vector[K] y; // An array of vectors containing the table data
}

parameters {
  vector[K] mu;
  real sigma;
  real mu_tau;
  real sigma_tau;
  real mu_ypred7;
}

model {
  mu_tau ~ normal(0, 10);
  sigma_tau ~ gamma(1, 1);
  sigma ~ gamma(1, 1);
  mu_ypred7 ~ normal(mu_tau, sigma_tau);
  for (k in 1:K) {
    mu[k] ~ normal(mu_tau, sigma_tau);
  }
  for (k in 1:K) {
    y[, k] ~ normal(mu[k], sigma);
  }
}

generated quantities {
  array[K] real ypred;
  for (k in 1:K) {
    ypred[k] = normal_rng(mu[k] , sigma);
  }
  real ypred7 = normal_rng(mu_ypred7, sigma);
}
