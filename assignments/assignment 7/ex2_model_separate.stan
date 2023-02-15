data {
  int<lower=0> N; // number of measurements per machine
  int<lower=0> K; // number of machines
  array[N] vector[K] y; // An array of vectors containing the table data
}

parameters {
  vector[K] mu;
  vector<lower=0>[K] sigma;
}

model {
  for (k in 1:K) {
    mu[k] ~ normal(0, 50);
    sigma[k] ~ normal(0, 20);
  }
  for (k in 1:K) {
    y[, k] ~ normal(mu[k], sigma[k]);
  }
}

generated quantities {
  array[K] real ypred;
  for (k in 1:K) {
    ypred[k] = normal_rng(mu[k], sigma[k]);
  }
}
