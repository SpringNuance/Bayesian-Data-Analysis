# Bioassay model
data {
    int<lower=0> N;       // The number of groups
    int<lower=0> n;    // The number of animals used in each group. Should be constant
    real x[N];            // The amount of doses used in each group 
    int<lower=0,upper=n> y[N];    // Number of deaths in each group
}
parameters {
    vector[2] alphaNbeta;  // Vector of 2 values alpha and beta
}
model {
    row_vector[2] mu = [0,10];             
    matrix[2,2] sigma =[[4, 12],[12, 100]]; 
    vector[N] loglikelihood;  // log-likelihood from each group

    // The log prior distribution
    target += multi_normal_lpdf(alphaNbeta | mu, sigma);
   
    for(i in 1:N) {
        real alpha = alphaNbeta[1];
        real beta = alphaNbeta[2];
        loglikelihood[i] = binomial_logit_lpmf(y[i] | n, alpha + beta * x[i]);
    }
    target += sum(loglikelihood);
}
