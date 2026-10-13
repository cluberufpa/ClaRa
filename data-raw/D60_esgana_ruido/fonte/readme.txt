Dynamic visual noise promotes social attraction in a shoaling fish, May 2020

final_statistics.txt readme

trial		trial number (1-72) 
playback.order	specific order in which noise playback was played (4 levels: a - d)
noise		noise playback (4 levels, 0-6: 0 - static, 1 - slow, 4 - medium, 6 - fast)
lrgshoal	number of fish in the larger shoal
smlshoal	number of fish in the smaller shoal
lrg.100		number of frames spent closer to larger shoal
sml.100		number of frames spent closer to smaller shoal
mich		michelson contrast for the relative shoal sizes
ppn		proportion of trial spent within 100 pixels of the larger shoal relative to the smaller shoal (i.e. lrg.100 / sml.100 + lrg.100) 
bin.lrg.100	binary response: does a focal fish spend more frames with the larger shoal (than the smaller)? (0 - no, 1 - yes)
ppn.lrg.100	proportion of trial spent within 100 pixels of the larger shoal
ppn.sml.100	proportion of trial spent within 100 pixels of the smaller shoal
pref.score	preference score: relative proportion of trial spent within 100 pixels of one shoal vs another (i.e. ppn.lrg.100 - ppn.sml.100). (+) values denote preference for large shoal, (-) values denote preference for small shoal
fishID		fish id (1-144)
time.int	number of frames that a focal fish spends within 100 pixels of either shoal
dist		median distance (px) to the nearest shoal overall
mm.speed	median speed (mm/s) of focal fish overall
ppn.stat	proportion of trial that a focal fish spent stationary (i.e. with a speed of <1)
totalfr		total number of frames of the trial
Ncrossings	number of mid-line crossings made by a focal fish throughout the trial
size		estimated fish size (mm)
pxpermm		number of pixels per mm (for converting)