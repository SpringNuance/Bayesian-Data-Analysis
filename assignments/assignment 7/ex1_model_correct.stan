data {
  int<lower=0> N; // number of data points
  vector[N] x; // observation year
  vector[N] y; // observation number of drowned
  real xpred; // prediction year
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma; // <- MISTAKE 1 fixed
}

transformed parameters {
  vector[N] mu = alpha + beta*x;
  real mu_pred = alpha + beta * xpred; // <- The derivation of mu_pred is added.  
}

model {
  alpha ~ normal(138, 53521.4);
  beta ~ normal(0, 26.787); 
  y ~ normal(mu, sigma); // <- MISTAKE 2 fixed
}

generated quantities {
  real ypred = normal_rng(mu_pred, sigma); // <- MISTAKE 3 fixed
}
