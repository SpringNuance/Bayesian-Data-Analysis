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
    mu[k] ~ normal(0, 10);
    sigma[k] ~ gamma(1, 1);
  }
  for (k in 1:K) {
    y[, k] ~ normal(mu[k], sigma[k]);
  }
}

generated quantities {
  array[K] real ypred;
  array[N] vector[K] log_likelihood; // An array of vectors of the log likelihood
  for (k in 1:K) {
    ypred[k] = normal_rng(mu[k], sigma[k]);
  }
  for (i in 1:N) {
    for (k in 1:K) {
      log_likelihood[i][k] = normal_lpdf(y[i][k] | mu[k], sigma[k]);
    }
  }

}
