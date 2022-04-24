# Analysis and modeling of football data set

This repository contains scripts developed in ~~GNU Octave (scripts should be
compatible with Matlab)~~ for the purpose of analyzing empirical football data
set. All analysis and modeling is split into two obvious parts: analysis and
modeling (two separate folders in this repository). Analysis part is further
subdivided into two parts: cleaning and analysis (two separate scripts).

~~Note that along with the scripts we make available cleaned up data in Matlab's
workspace file (\*.mat) format. Raw data was obtained from
[this repository on GitHub](https://github.com/jalapic/engsoccerdata).~~

Note that the modeling ideas strongly overlaps with ideas discussed by prof.
Tony Padilla in
[this Numberphile video](https://www.youtube.com/watch?v=Vv9wpQIGZDw).

**Update 2020-04-08:** These scripts were updated in 2020, as Matlab wasn't
able to deal with code written in Octave as well as with \*.mat file generated
by Octave. The code was updated and mat files were regenerated.

Note that after the update we have decided to include raw data file (originally
downloaded from [engsoccerdata repository on GitHub](https://github.com/jalapic/engsoccerdata)).
As it seems that data format has changed in the upstream repository.

**Update 2022-04-24:** Another update in 2022. Various updates to match new
practices. Also `main.m` scripts are include for clarity.

## How to run

Both folders include `main.m` scripts, which gather everything inside the
folders into a single "interpret-able" file. Note that you should run
`data-analysis/main.m` first to generate `*.mat` file used by the
`model/main.m` script.
