*!TITLE: MEDSIM - causal mediation analysis using a simulation estimator
*!AUTHOR: Geoffrey T. Wodtke, Department of Sociology, University of Chicago
*!
*! version 0.1
*!

program define medsim, eclass

	version 15	

	syntax varlist(min=1 max=1 numeric) [if][in] [pweight], ///
		dvar(varname numeric) ///
		mvar(varname numeric) ///
		d(real) ///
		dstar(real) ///
		mreg(string) ///
		yreg(string) ///
		[nsim(integer 200)] ///
		[cvars(varlist numeric)] ///
		[NOINTERaction] ///
		[cxd] ///
		[cxm] ///
		[reps(integer 200)] ///
		[strata(varname numeric)] ///
		[cluster(varname numeric)] ///
		[level(cilevel)] ///
		[seed(passthru)] ///
		[saving(string)] ///
		[detail]
		
	qui {
		marksample touse
		count if `touse'
		if r(N) == 0 error 2000
		}
	
	if ("`detail'" != "") {		
		medsimbs `varlist' [`weight' `exp'] if `touse' , ///
			dvar(`dvar') mvar(`mvar') cvars(`cvars') ///
			d(`d') dstar(`dstar') mreg(`mreg') yreg(`yreg') nsim(1) /// 
			`nointeraction' `cxd' `cxm'
		}
		
	if ("`saving'" != "") {
		bootstrap ATE=r(ate) NDE=r(nde) NIE=r(nie), force ///
			reps(`reps') strata(`strata') cluster(`cluster') level(`level') `seed' ///
			saving(`saving', replace) noheader notable: ///
			medsimbs `varlist' if `touse' [`weight' `exp'], ///
			dvar(`dvar') mvar(`mvar') cvars(`cvars') ///
			d(`d') dstar(`dstar') mreg(`mreg') yreg(`yreg') nsim(`nsim') ///
			`nointeraction' `cxd' `cxm'
			}

	if ("`saving'" == "") {
		bootstrap ATE=r(ate) NDE=r(nde) NIE=r(nie), force ///
			reps(`reps') strata(`strata') cluster(`cluster') level(`level') `seed' ///
			noheader notable: ///
			medsimbs `varlist' if `touse' [`weight' `exp'], ///
			dvar(`dvar') mvar(`mvar') cvars(`cvars') ///
			d(`d') dstar(`dstar') mreg(`mreg') yreg(`yreg') nsim(`nsim') ///
			`nointeraction' `cxd' `cxm'
			}

	estat bootstrap, p noheader
	
end medsim
