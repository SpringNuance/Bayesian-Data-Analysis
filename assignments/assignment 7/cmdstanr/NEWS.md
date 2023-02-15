# cmdstanr 0.5.3

### New features

* On Windows, users can now install and use CmdStan with WSL (Windows
Subsystem for Linux). Set `wsl=TRUE` in `install_cmdstan()` to install CmdStan
for use with WSL. This can offer significant speedups compared to native
Windows execution. (#677, @andrjohns)

### Bug fixes

* In `cmdstan_default_path()` we now ignore directories inside `.cmdstan` that don't start
with `"cmdstan-"`. (#651)

* Fixed Windows issue related to not locating `grep.exe` or when it is located in a path
with spaces. (@weshinsley, #661, #663)

* Fixed a bug with diagnostic checks when ebfmi is NaN.

* Fixed a bug that caused issues when using `~` or `.` in paths supplied to the
`cmdstanr_write_stan_file_dir` global option.

* Fixed a bug that caused the `time()` method fail when some of the chains failed to finish
succesfully.

# cmdstanr 0.5.2

* Refactored toolchain installation and checks for R 4.x on Windows and added support
for Rtools42. (#645)

* Expanded the use of `CMDSTAN` environment variable to point to CmdStan installation
_or_ directory containing CmdStan installations. (#643)

* New vignette on how to handle deprecations using the `$format()` method. (#644)


# cmdstanr 0.5.1

* Temporarily disable `format="draws_rvars"` in the `$draws()` method due to a
bug. Until this is fixed users can make use of `posterior::as_draws_rvars()` to
convert draws from CmdStanR to the `draws_rvars` format. (#640)

# cmdstanr 0.5.0

### Bug fixes

* Fixed bug that caused stdour/stderr not being read at the end of
optimization. (#522)

* Fixed issue with handling `NA` as the reported external process
status. (#544, @myshkin)

* Fixed issue with handling models with no parameters and CmdStan
2.27+.

### New features

* Default directory changed to `.cmdstan` instead of `.cmdstanr` so that
CmdStanPy and CmdStanR can use the same CmdStan installations. Using `.cmdstanr`
will continue to be supported until version 1.0 but `install_cmdstan()` will now
default to `.cmdstan` and CmdStanR will first look for `.cmdstan` before falling
back on `.cmdstanr`. (#454)

* New method `diagnose()` for CmdstanModel objects exposes CmdStan's `diagnose`
method for comparing Stan's gradient computations to gradients computed via
finite differences. (#485)

* New method `$variables()` for CmdstanModel objects that returns a list of
variables in the Stan model, their types and number of dimensions. Does
not require the model to be compiled. (#519)

* New method `$format()` for auto-formatting and canonicalizing the Stan models. (#625)

* Added the option to create `CmdStanModel` from the executable only with the
`exe_file` argument. (#564)

* Added a convenience argument `user_header` to `$compile()` and `cmdstan_model()`
that simplifies the use of an external .hpp file to compile with the model.

* Added the `cmdstanr_force_recompile` global option that is used for forcing
recompilation of Stan models. (#580)

* New method `$code()` for all fitted model objects that returns the Stan code
associated with the fitted model. (#575)

* New method `$diagnostic_summary()` for CmdStanMCMC objects that summarizes the
sampler diagnostics (divergences, treedepth, ebfmi) and can regenerate the
related warning messages. (#205)

* New `diagnostics` argument for the `$sample()` method to specify which
diagnostics are checked after sampling. Replaces `validate_csv` argument. (#205)

* Added E-BFMI checks that run automatically post sampling. (#500, @jsocolar)

* New methods for `posterior::as_draws()` for CmdStanR fitted model objects.
These are just wrappers around the `$draws()` method provided for convenience. (#532)

* `write_stan_file()` now choose file names deterministically based on the code
so that models do not get unnecessarily recompiled when calling the function
multiple times with the same code. (#495, @martinmodrak)

* The `dir` argument for `write_stan_file()` can now be set with a global
option. (#537)

* `write_stan_json()` now handles data of class `"table"`. Tables are converted
to vector, matrix, or array depending on the dimensions of the table. (#528)

* Improved processing of named lists supplied to the `data` argument to JSON
data files: checking whether the list includes all required elements/Stan
variables; improved differentiating arrays/vectors of length 1 and scalars
when generating JSON data files; generating floating point numbers with
decimal points to fix issue with parsing large numbers. (#538)

* `install_cmdstan()` now automatically installs the Linux ARM CmdStan when
Linux distributions running on ARM CPUs are detected. (#531)

* New function `as_mcmc.list()` for converting CmdStanMCMC objects to mcmc.list
objects from the coda package. (#584, @MatsuuraKentaro)


# cmdstanr 0.4.0

### Bug fixes

* Fixed issue with retrieving draws with models with spaces in their names. (#453)

* Fixed bug with spaces in path to the temporary folder on Windows. (#460)

* Fixed issue with not reporting model executable name clashing with folder name. (#461)

### New features

* New function `as_cmdstan_fit()` that creates CmdStanMCMC/MLE/VB objects
directly from CmdStan CSV files. (#412)

* `read_cmdstan_csv()` now also returns chain run times for MCMC sampling CSV
files. (#414)

* Faster CSV reading for multiple chains. (#419)

* New `$profiles()` method for fitted model objects accesses profiling
information from R if profiling used in the Stan program. Support for profiling
Stan programs requires CmdStan >= 2.26. (#434)

* New vignette on profiling Stan programs. (#435)

* New vignette on running Stan on the GPU with OpenCL. OpenCL device ids can
now also be specified at runtime. (#439)

* New check for invalid parameter names when supplying init values. (#452, @mike-lawrence)

* Suppressing compilation messages when not in interactive mode. (#462, @wlandau)

* New `error_on_NA` argument for `cmdstan_version()` to optionally return `NULL`
(instead of erroring) if the CmdStan path is not found (#467, @wlandau).

* Global option `cmdstanr_max_rows` can be set as an alternative to specifying
`max_rows` argument to the `$print()` method. (#470)

* New `output_basename` argument for the model fitting methods. Can be used in
conjunction with `output_dir` to get completely predictable output CSV file
paths. (#471)

* New `format` argument for `$draws()`, `$sampler_diagnostics()`,
`read_cmdstan_csv()`, and `as_cmdstan_fit`(). This controls the format of the
draws returned or stored in the object. Changing the format can improve speed
and memory usage for large models. (#482)

# cmdstanr 0.3.0

### Bug fixes

* Fixed reading inverse mass matrix with values written in scientific format in
the CSV. (#394)

* Fixed error caused by an empty data list. Previously if a model didn't require
data then `data` had to either be NULL or be a non-empty list, but now `list()`
is allowed. (#403)

### New features

* Added `$sample_mpi()` for MCMC sampling with MPI. (#350)

* Added informative messages on compile errors caused by precompiled headers (PCH). (#384)

* Added the `cmdstanr_verbose` option for verbose mode. Intended for
troubleshooting, debugging and development. See end of *How does CmdStanR work?*
vignette for details. (#392)

* New `$loo()` method for CmdStanMCMC objects. Requires computing pointwise
log-likelihood in Stan program. (#366)

* The `fitted_params` argument to the `$generate_quantities()` method now also
accepts CmdStanVB, `posterior::draws_array`, and `posterior::draws_matrix`
objects. (#390)

* The `$optimize()` method now supports all of CmdStan's tolerance-related
arguments for (L)BFGS. (#398)

* The documentation for the R6 methods now uses `@param`, which allows package
developers to import the CmdStanR documentation using roxygen2's
`@inheritParams`. (#408)

# cmdstanr 0.2.2

### Bug fixes

* Fixed bug with reading Stan CSV when grep used coloring by default (#364,#371)

* Depend on posterior v0.1.3 to avoid a potential error in `$summary()`. (#383)

### New features

* Added support for native execution on the macOS with the M1 ARM-based CPU. (#375)

* Added threading support via `threads` argument for `$optimize()` and `$variational()`
  (was already available via `threads_per_chain` for `$sample()`). (#369)

# cmdstanr 0.2.1

### Bug fixes

* Fixed bug with processing stanc_options in `check_syntax()`. (#345)

* Fixed bug on access to one variable via `draws()`. (#348)

### New features

* `compile()` and `check_syntax()` methods gain argument `pedantic` for turning
on pedantic mode, which warns about issues with the model beyond syntax errors.
(#361)

# cmdstanr 0.2.0

### Bug fixes

* Fix potential indexing error if using `read_cmdstan_csv()` with CSV files
created by CmdStan without CmdStanR. (#291, #292, @johnlees)

* Fix error when returning draws or sampler diagnostics for a fit with only warmup
and no samples. (#288, #293)

* Fix trailing slashes issue for `dir` in `cmdstan_model()` and `output_dir`
in fitting methods. (#281, #294)

* Fix dimensions error when processing a list of matrices passed in as `data`. (#296, #302)

* Fix reporting of time after using `fixed_param` method. (#303, #307)

* With `refresh = 0`, no output other than error messages is printed with
`$optimize()` and `$variational()`. (#324)

* Fix issue where names of generated files could clash. (#326, #328)

* Fix missing `include_paths` in `$syntax_check()`. (#335, @mike-lawrence)

### New features

* CSV reading is now faster by using `data.table::fread()`. (#318)

* `install_cmdstan()` gains argument `version` for specifying which version of
CmdStan to install. (#300, #308)

* New function `check_cmdstan_toolchain()` that checks if the appropriate
toolchains are available. (#289)

* `$sample()` method for CmdStanModel objects gains argument `chain_ids` for
specifying custom chain IDs. (#319)

* Added support for the `sig_figs` argument in CmdStan versions 2.25 and above. (#327)

* Added checks if the user has the necessary permissions in the RTools and temporary folders. (#343)

# cmdstanr 0.1.3

* New `$check_syntax()` method for CmdStanModel objects. (#276, #277)

# cmdstanr 0.1.2

* User is notified by message at load time if a new release of CmdStan is
available. (#265, #273)

* `write_stan_file()` replaces `write_stan_tempfile()`, which is now deprecated.
With the addition of the `dir` argument, the file written is not necessarily
temporary. (#267, #272)


# cmdstanr 0.1.1

* New knitr engine `eng_cmdstan()` and function `register_knitr_engine()` that
allow Stan chunks in R markdown documents to be processed using CmdStanR
instead of RStan. The new vignette _R Markdown CmdStan Engine_ provides a
demonstration. (#261, #264, @bearloga)

# cmdstanr 0.1.0

* Beta release
