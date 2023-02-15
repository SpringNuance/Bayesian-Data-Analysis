transformed data {
  int<lower=0> N = 10;
  real<lower=0, upper=1> theta = 0.35;
}
generated quantities {
  array[N] int y_sim;
  for (n in 1 : N) {
    y_sim[n] = bernoulli_rng(theta);
  }
}
