{smcl}
{* *! version 0.1, 1 July 2024}{...}
{cmd:help for medsim}{right:Geoffrey T. Wodtke}
{hline}

{title:Title}

{p2colset 5 18 18 2}{...}
{p2col : {cmd:medsim} {hline 2}}causal mediation analysis using simulation and general linear models{p_end}
{p2colreset}{...}


{title:Syntax}

{p 8 18 2}
{cmd:medsim} {varname} {ifin} [{it:{help weight:pweight}}] {cmd:,} dvar({varname}) mvar({varname}) 
d({it:real}) dstar({it:real}) mreg(string) yreg(string) nsim({it:integer}) 
[cvars({varlist})) {opt nointer:action} {opt cxd} {opt cxm} 
{reps({it:integer}) strata({varname}) cluster({varname}) level(cilevel) seed({it:passthru})]

{phang}{opt varname} - this specifies the outcome variable.

{phang}{opt dvar(varname)} - this specifies the treatment (exposure) variable.

{phang}{opt mvar(varname)} - this specifies the mediator variable.

{phang}{opt d(real)} - this specifies the reference level of treatment.

{phang}{opt dstar(real)} - this specifies the alternative level of treatment. Together, (d - dstar) defines
the treatment contrast of interest.

{phang}{opt mreg}{cmd:(}{it:string}{cmd:)}}specify the form of regression model to be estimated for the mediator. 
Options are {opt reg:ress}, {opt log:it}, or {opt poi:sson}.

{phang}{opt yreg}{cmd:(}{it:string}{cmd:)}}specify the form of regression model to be estimated for the outcome. 
Options are {opt reg:ress}, {opt log:it}, or {opt poi:sson}.

{title:Options}

{phang}{opt nsim(integer 200)} - this option specifies the number of simulated values generated for the potential outcomes (the default is 200).

{phang}{opt cvars(varlist)} - this option specifies the list of baseline covariates to be included in the analysis. Categorical 
variables need to be coded as a series of dummy variables before being entered as covariates.

{phang}{opt nointer:action} - this option specifies whether a treatment-mediator interaction is not to be
included in the outcome model (the default assumes an interaction is present).

{phang}{opt cxd} - this option specifies that all two-way interactions between the treatment and baseline covariates are
included in the mediator and outcome models.

{phang}{opt cxm} - this option specifies that all two-way interactions between the mediator and baseline covariates are
included in the outcome model.

{phang}{opt reps(integer 200)} - this option specifies the number of replications for bootstrap resampling (the default is 200).

{phang}{opt strata(varname)} - this option specifies a variable that identifies resampling strata. If this option is specified, 
then bootstrap samples are taken independently within each stratum.

{phang}{opt cluster(varname)} - this option specifies a variable that identifies resampling clusters. If this option is specified,
then the sample drawn during each replication is a bootstrap sample of clusters.

{phang}{opt level(cilevel)} - this option specifies the confidence level for constructing bootstrap confidence intervals. If this 
option is omitted, then the default level of 95% is used.

{phang}{opt seed(passthru)} - this option specifies the seed for bootstrap resampling. If this option is omitted, then a random 
seed is used and the results cannot be replicated. {p_end}

{phang}{opt detail} - this option prints the fitted models for the mediator and outcome in addition to the effect estimates.

{title:Description}

{pstd}{cmd:medsim} performs causal mediation analysis using simulation and general linear models for both the mediator and outcome. 
Two models are estimated: a model for the mediator conditional on treatment and baseline covariates (if specified), 
and a model for the outcome conditional on treatment, the mediator, and the baseline covariates. These models may be 
linear, logistic, or poisson regressions. These modules are then used to simulate potential outcomes and construct
estimates of total, natural direct, and natural indirect effects.

{pstd}{cmd:medsim} provides estimates of the average total, natural direct, and natural indirect effects.{p_end}

{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. use nlsy79.dta} {p_end}

{pstd} no interaction between treatment and mediator, percentile bootstrap CIs with default settings: {p_end}
 
{phang2}{cmd:. medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3)	d(1) dstar(0) mreg(logit) yreg(regress) nsim(200) nointer reps(200)} {p_end}

{pstd} treatment-mediator interaction, percentile bootstrap CIs with default settings: {p_end}
 
{phang2}{cmd:. medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3)	d(1) dstar(0) mreg(logit) yreg(regress) nsim(200) reps(200)} {p_end}

{pstd} treatment-mediator interaction, all two-way interactions between baseline covariates and treatment, percentile bootstrap CIs with default settings: {p_end}
 
{phang2}{cmd:. medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3)	d(1) dstar(0) mreg(logit) yreg(regress) nsim(200) cxd reps(200)} {p_end}

{title:Saved results}

{pstd}{cmd:medsim} saves the following results in {cmd:e()}:

{synoptset 15 tabbed}{...}
{p2col 5 15 19 2: Matrices}{p_end}
{synopt:{cmd:e(b)}}matrix containing the effect estimates{p_end}


{title:Author}

{pstd}Geoffrey T. Wodtke {break}
Department of Sociology{break}
University of Chicago{p_end}

{phang}Email: wodtke@uchicago.edu


{title:References}

{pstd}Wodtke GT, Zhou X, and Elwert F. Causal Mediation Analysis. In preparation. {p_end}

{title:Also see}

{psee}
Help: {manhelp regress R}, {manhelp logit R}, {manhelp poisson R}, {manhelp bootstrap R}
{p_end}
