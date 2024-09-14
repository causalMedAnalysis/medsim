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
{cmd:medsim} {depvar} {ifin} [{it:{help weight:pweight}}] {cmd:,} 
{opt dvar(varname)} 
{opt mvar(varname)} 
{opt d(real)} 
{opt dstar(real)} 
{opt mreg(string)} 
{opt yreg(string)} 
{opt nsim(integer)} 
{opt cvars(varlist)} 
{opt nointer:action} 
{opt cxd} 
{opt cxm} 
{opt detail}
[{it:{help bootstrap##options:bootstrap_options}}]

{phang}{opt depvar} - this specifies the outcome variable.

{phang}{opt dvar(varname)} - this specifies the treatment (exposure) variable.

{phang}{opt mvar(varname)} - this specifies the mediator variable.

{phang}{opt d(real)} - this specifies the reference level of treatment.

{phang}{opt dstar(real)} - this specifies the alternative level of treatment. Together, (d - dstar) defines
the treatment contrast of interest.

{phang}{opt mreg}{cmd:(}{it:string}{cmd:)}}specify the form of regression model to be estimated for the mediator. 
Options are {opt regress}, {opt logit}, or {opt poisson}.

{phang}{opt yreg}{cmd:(}{it:string}{cmd:)}}specify the form of regression model to be estimated for the outcome. 
Options are {opt regress}, {opt logit}, or {opt poisson}.

{title:Options}

{phang}{opt nsim(integer)} - this option specifies the number of simulated values generated for the potential outcomes (the default is 200).

{phang}{opt cvars(varlist)} - this option specifies the list of baseline covariates to be included in the analysis. Categorical 
variables need to be coded as a series of dummy variables before being entered as covariates.

{phang}{opt nointer:action} - this option specifies whether a treatment-mediator interaction is not to be
included in the outcome model (the default assumes an interaction is present).

{phang}{opt cxd} - this option specifies that all two-way interactions between the treatment and baseline covariates are
included in the mediator and outcome models.

{phang}{opt cxm} - this option specifies that all two-way interactions between the mediator and baseline covariates are
included in the outcome model.

{phang}{opt detail} - this option prints the fitted models for the mediator and outcome in addition to the effect estimates.

{phang}{it:{help bootstrap##options:bootstrap_options}} - all {help bootstrap} options are available. {p_end}

{title:Description}

{pstd}{cmd:medsim} performs causal mediation analysis using simulation and general linear models for both the mediator and outcome. 
Two models are estimated: a model for the mediator conditional on the exposure and baseline covariates (if specified), 
and a model for the outcome conditional on the exposure, the mediator, and the baseline covariates. These models may be 
linear, logistic, or poisson regressions. After they are fit, the models are then used to simulate potential outcomes and construct
estimates of total, natural direct, and natural indirect effects. Inferential statistics are computed using the nonparametric bootstrap.

{pstd}If using {help pweights} from a complex sample design that require rescaling to produce valid boostrap estimates, be sure to appropriately 
specify the strata(), cluster(), and size() options from the {help bootstrap} command so that Nc-1 clusters are sampled from each stratum 
with replacement, where Nc denotes the number of clusters per stratum. Failing to properly adjust the bootstrap procedure to account
for a complex sample design and its associated sampling weights could lead to invalid inferential statistics. {p_end}

{title:Examples}

{pstd}Setup{p_end}
{phang2}{cmd:. use nlsy79.dta} {p_end}

{pstd} no interaction between treatment and mediator, percentile bootstrap CIs with default settings: {p_end}
 
{phang2}{cmd:. medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3)	d(1) dstar(0) mreg(logit) yreg(regress) nointer} {p_end}

{pstd} treatment-mediator interaction, percentile bootstrap CIs with 1000 replications: {p_end}
 
{phang2}{cmd:. medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3)	d(1) dstar(0) mreg(logit) yreg(regress) rep(1000)} {p_end}

{pstd} treatment-mediator interaction, all two-way interactions between baseline covariates and treatment, percentile bootstrap CIs with default settings, 2000 simulated values: {p_end}
 
{phang2}{cmd:. medsim std_cesd_age40, dvar(att22) mvar(ever_unemp_age3539) cvars(female black hispan paredu parprof parinc_prank famsize afqt3)	d(1) dstar(0) mreg(logit) yreg(regress) nsim(2000) cxd} {p_end}

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

{pstd}Wodtke, GT and X Zhou. Causal Mediation Analysis. In preparation. {p_end}

{title:Also see}

{psee}
Help: {manhelp regress R}, {manhelp logit R}, {manhelp poisson R}, {manhelp bootstrap R}
{p_end}
