# medsim
medsim performs causal mediation analysis using simulation and general linear models for both the mediator and outcome. Two models are estimated: a model for the mediator conditional on treatment and baseline covariates (if specified), and a model for the outcome conditional on treatment, the mediator, and the baseline covariates. These models may be linear, logistic, or poisson regressions. These modules are then used to simulate potential outcomes and construct estimates of total, natural direct, and natural indirect effects.
