data {
  int<lower=0> N; // number of data points
  vector[N] x; // observation year
  vector[N] y; // observation number of drowned
  real xpred; // prediction year
}

parameters {
  real alpha;
  real beta;
  real<upper=0> sigma; // <- MISTAKE 1: Should have been real<lower=0> sigma
}

transformed parameters {
  vector[N] mu = alpha + beta*x;
}

model {
  y ~ normal(mu, sigma) // <- MISTAKE 2: No semicolon at the end
}

generated quantities {
  real ypred = normal_rng(mu, sigma); // <- MISTAKE 3: should have been 
  // ypred = normal_rng(mu_pred, sigma), where mu_pred = alpha + beta * xpred. 
  // The derivation of mu_pred can be added to the transformed parameters.  
}