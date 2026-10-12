# Data from: Differences in parasite infection status and behavior between a clonal fish and her sexually reproducing heterospecifics

Dataset DOI: [10.5061/dryad.jsxksn0r9](https://doi.org/10.5061/dryad.jsxksn0r9)

## Description of the data and file structure

This README describes the columns and format of the data used in our analysis. This observational experiment was designed to test whether fish behavior was affected by parasite load and whether those patterns differed between species. Fish were collected by Kirsten Sheehy and Jon Aguiñaga.  They also conducted the behavioral trials. Behavioral data and fish lengths were extracted from videos and photos by Nishika Raghavan and Kirsten Sheehy. Parasite data were collected by Dr. Jessica Stephenson, Dr. Mary Janecka, Charlie Walsh, and Kareen Wali.

Authors listed on the manuscript have made major contributions to at least two out of the following categories: ideation, funding, data collection, analysis, writeup of manuscript, and editing manuscript. Authors on this manuscript include Kirsten Sheehy, Dr. Jon Aguiñaga, Dr. Jessica Stephenson, and Dr. Mary Janecka.

All authors (Kirsten Sheehy, Dr. Jon Aguiñaga, Dr. Jessica Stephenson, and Dr. Mary Janecka) and contributors (Nishika Raghavan, Charlie Walsh, and Kareen Wali) to this dataset and manuscript have consented to the CC0 waiver.

NAs in the texas2022_parasite_20260421.csv reflect missing data (i.e., not available). There are 2 NAs for sex and 10 for standard.length. For sex, these are due to clerical errors--the specimen label either did not include sex or was illegible. For standard length, some of the fish that were dissected for the parasite counts were not assigned a unique ID, and were therefore unable to be linked with the photos used to measure standard length.

### Files and variables

#### File: Texas2022_analysis_submission_20260421.Rmd

**Description:** R Markdown used for analysis and the generation of figures.

#### File: texas2022_parasite_20260421.csv

**Description:** Data used for the parasite-only analysis.

##### Variables

* site.id: Fish were collected from one of two sites: Brownsville or Weslaco.
* species: This is the species name of the fish being observed. It is either "latipinna" or "formosa".
* sex: There are both male and female *P. latipinna* in this dataset. There are only females of the *P. formosa*. Sex was determined by the presence/absence of a gonopodium. Sex was recorded as either M or F in the data.
* standard.length: Standard length is from the mouth of the fish to the caudal peduncle (in centimeters).
* totalpara: Sum of total parasites on that fish (trematodes and unknown).

#### File: texas2022_all_20260421.csv

**Description:** Data used for the behavioral analysis. Includes parasite data.

##### Variables

* fish.id: Each fish that went through behavioral trials got a unique ID based on the species and the order in which the fish were processed (e.g., PF-05 is the 5th *Poecilia formosa* measured). For the parasite data, some fish did not get a unique ID, or their labels were no longer legible. These fish were then just named after their species (e.g., *P. formosa*).
* trial.id: The first or second trial that a fish went through.
* site.id: Fish were collected from one of two sites: Brownsville or Weslaco.
* species: This is the species name of the fish being observed ("P. latipinna" or "P. formosa").
* sex: There are both male and female *P. latipinna* in this dataset. There are only females of the *P. formosa*. Sex was determined by the presence/absence of a gonopodium. Sex was recorded as either M or F in the data.
* totalpara: Sum of total parasites on that fish (trematodes and unknown).
* standard.length: Standard length is from the mouth of the fish to the caudal peduncle (in centimeters).
* total.time.open.after: Total amount of time in seconds that a fish spends in the open half of the arena after the startle stimulus.
* prop.open: Proportion of time a fish spends in the open half of the arena over the whole trial.
* prop.open.b4: Proportion of time that a fish spends in the open half of the arena prior to the startle stimulus.
* prop.open.after: Proportion of time that a fish spends in the open half of the arena after the startle stimulus.