# Title of Dataset
Increased water temperature and turbidity act independently to alter social behaviour in guppies (Poecilia reticulata)
---

Changes in environmental conditions can shift the costs and benefits of aggregation or interfere with the sensory perception of near neighbours. 
This affects group cohesion with potential impacts on the benefits of collective behaviour such as reduced predation risk. 
Organisms are rarely exposed to one stressor in isolation, yet there are only a few studies exploring the interactions between multiple stressors and their effects on social behaviour. 
Here we tested the effects of increased water temperature and turbidity on refuge use and three measures of aggregation in guppies (Poecilia reticulata), 
increasing temperature and turbidity in isolation or in combination. When stressors were elevated in isolation, the distribution of fish within the arena as measured by 
the index of dispersion became more aggregated at higher temperatures, but less aggregated when turbidity was increased. Another measure of cohesion at the global scale, 
the mean inter-individual distance, also indicated that fish were less aggregated in turbid water. This is likely due to turbidity acting as a visual constraint, 
as there was no evidence of a change in risk perception as refuge use was not affected by turbidity. Fish decreased refuge use and were closer to their nearest neighbour at higher temperatures.
However, nearest neighbour distance was not affected by turbidity, suggesting that local-scale interactions can be robust to the moderate increase in turbidity used here (5 NTU) 
compared to other studies which show a decline in shoal cohesion at higher turbidity (>100 NTU). We did not observe any significant interaction terms between the two stressors, 
indicating no synergistic or antagonistic effects. Our study suggests that the effects of environmental stressors on social behaviour may be unpredictable and dependent on the metric 
used to measure cohesion, highlighting the need for mechanistic studies to link behaviour to the physiology and sensory effects of environmental stressors.


## Description of the data and file structure

1) "Data for models.csv" -> 14 columns x 95 rows. The first column "n" represents the unique event number, File refers to the original raw data csv file the averaged (mean) measure is taken from, 
here the code structure represents: DayX_Y.csv meaning DayX (day if testing) and _Y (trial number in test day).
N_of_fish_in_arena is the total number of fish tested in each trial.
Diff_N_fish_in_arena is the difference in number of fish from a target of 30 (fish).
number_of_vis_fish is the mean number of fish seen in the arena during each trial (not under refuge). 
mean_NND_min_dist is the mean near-neighbour distance among fish during each trial, measured in pixels.
mean_interindiv_dist is the mean inter-individual distance among fish during each trial, measured in pixels.
aggregation_var_over_mean is the index of dispersion measured as the ratio between variance and mean of fish occupancy of a grid overlayed to the experimental arena.
Treatment refers to the experimental conditions: Control, Temperature, Turbidity and Interaction
Turbidity categorical variable either Control or Turbid
Temperature categorical variable either Control or Hot
Tub represents the original holding tank number
minutes_since_midnight is the minutes elapsed from midnight to the start of trial
Start_trial_time time of day at which trial started
day_of_testing 1-4 repeated testing measure

2) "models script.R" -> R script for models, this includes the library used, and 2 models for each behavioural response variable.




## Sharing/Access information

Data also available directly from corresponding author cos.zanghi@bristol.ac.uk

## Code/Software

Each behavioural parameter (i.e. the number of visible fish, mean NND, mean IID and index of dispersion) 
was analysed as a response variable in a separate linear mixed model (LMM) using the lme4 package version 1.1-21 (Bates et al., 2015) in R Studio version 1.3.1093. 