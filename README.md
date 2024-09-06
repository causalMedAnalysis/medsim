# medsim: A Stata Module for Performing Causal Mediation Analysis using Simulation and General Linear Models

`medsim` is a Stata module designed to perform causal mediation analysis using simulation along with linear, logistic, or Poisson models for the mediator and the outcome.

## Syntax

```stata
medsim depvar, dvar(varname) mvar(varname) d(real) dstar(real) mreg(string) yreg(string) [options]
```

### Required Arguments

- `depvar`: Specifies the outcome variable.
- `dvar(varname)`: Specifies the treatment variable.
- `mvar(varname)`: Specifies the mediator variable.
- `d(real)`: Specifies the reference level of treatment.
- `dstar(real)`: Specifies the alternative level of treatment, defining the treatment contrast of interest (d - dstar).
- `mreg(string)`: Model type for the mediator (options: `regress`, `logit`, `poisson`).
- `yreg(string)`: Model type for the outcome (options: `regress`, `logit`, `poisson`).

### Options

- `nsim(integer)`: Number of simulated values generated for the potential outcomes (default is 200).
- `cvars(varlist)`: List of baseline covariates to include in the analysis. Categorical variables must be coded as dummy variables.
- `nointeraction`: Specifies that a treatment-mediator interaction is not included in the outcome model (default assumes interaction is present).
- `cxd`: Includes all two-way interactions between the treatment and baseline covariates in the mediator and outcome models.
- `cxm`: Includes all two-way interactions between the mediator and baseline covariates in the outcome model.
- `reps(integer)`: Number of replications for bootstrap resampling (default is 200).
- `strata(varname)`: Identifies resampling strata for bootstrap samples.
- `cluster(varname)`: Identifies resampling clusters for bootstrap sampling.
- `level(cilevel)`: Confidence level for constructing bootstrap confidence intervals (default is 95%).
- `seed(passthru)`: Seed for bootstrap resampling to enable replicable results.
- `detail`: Prints the fitted models for the mediator and outcome in addition to the effect estimates.

## Description

`medsim` estimates a model for the mediator conditional on treatment and the baseline covariates, and then it estimates another model for the outcome conditional on treatment, the mediator, and baseline covariates. These models are then used to simulate potential outcomes and construct estimates of:

- **Average Total Effect**: The total effect of treatment on the outcome.
- **Natural Direct Effect**: The effect of treatment on the outcome not mediated by the mediator.
- **Natural Indirect Effect**: The effect of treatment on the outcome that operates through the mediator.

## Examples

```stata
// Load data
use nlsy79.dta

// No interaction between treatment and mediator, percentile bootstrap CIs with default settings
medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) mreg(logit) yreg(regress) nsim(200) nointer reps(200)

// Treatment-mediator interaction, percentile bootstrap CIs with default settings
medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) mreg(logit) yreg(regress) nsim(200) reps(200)

// Treatment-mediator interaction, all two-way interactions between baseline covariates and treatment, percentile bootstrap CIs with default settings
medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) mreg(logit) yreg(regress) cxd nsim(200) reps(200)

// Treatment-mediator interaction, all two-way interactions between baseline covariates and treatment, 1000 simulations, percentile bootstrap CIs with 1000 replications
medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3) d(1) dstar(0) mreg(logit) yreg(regress) cxd nsim(1000) reps(1000)
```

## Saved Results

`medsim` saves the following results in `e()`:

- **Matrices**:
  - `e(b)`: Matrix containing the effect estimates.

## Author

Geoffrey T. Wodtke  
Department of Sociology  
University of Chicago

Email: [wodtke@uchicago.edu](mailto:wodtke@uchicago.edu)

## References

- Wodtke, GT and X Zhou. Causal Mediation Analysis. In preparation.

## Also See

- Help: [regress R](#), [logit R](#), [poisson R](#), [bootstrap R](#)
```
