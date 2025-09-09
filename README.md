# <ins> Sample Program </ins>

### Purpose: 
This is just to try out analyzing data using MATLAB.
This sort of operation has some interesting and useful functions that I would like
to remember how to use for later projects.

### Goal:
Literally none. But if this bore any fruit, that would be interesting too.

### About the game:
There are four sets of white balls, and 4 sets of red balls. One set of each is randomly selected before each drawing.
Within each set of white balls, you have ball numbers 1-69. Within each set of red balls, you have ball numbers 1-26.
You select an exclusive set of 5 white ball numbers (aka no repeating numbers) and a single red ball number.
The red ball number can be the same as a white ball number. The goal is to match what is drawn; ball order is not a factor.

Based on how many balls you match with the drawing, you win different prizes. There are also multipliers for certain tiers,
but if you can't match anything, it's a waste of money. Winnings follow these rules:

1. Match ONLY the red ball (powerball):             You get $4. Multipliers up to 10x take effect.
2. Match ONE white ball AND the red ball:           You get $4. Multipliers up to 10x take effect.
3. Match TWO white balls AND the red ball:          You get $7. Multipliers up to 10x take effect.
4. Match THREE white balls:                         You get $7. Multipliers up to 10x take effect.
5. Match THREE white balls AND the red ball:        You get $100. Multipliers up to 10x take effect.
6. Match FOUR white balls:                          You get $100. Multipliers up to 10x take effect.
7. Match FOUR white balls AND the red ball:         You get $50,000. Multipliers up to 10x take effect.
8. Match ALL FIVE white balls:                      You get $1,000,000. Multipliers up to 2x take effect, others default to 2x.
9. Match ALL FIVE white balls AND the red ball:     You get the Grand Prize (starts at $20 million).

### How to use this project:
1. Download all the files, obviously. Put them in a dedicated folder,
    as this will become your working folder.
2. Run App.m
3. Click the buttons in order from top to bottom, making sure they finish before you click the next one. Also make sure you have internet. The first
    step is to download some reference data, after all.
4. Last step, you can see what kind of pattern the previous numbers fell as the bar chart in the figure folder. There is one for 
    each year since 2020, as well as a total chart. This divides things by the schema, a categorization of how many numbers were
    drawn from the most likely third, from the mid third, and from the least likely third. So for white balls, you can have ones
    like 1-2-2, 3-1-1, etc. The schemas are as follows:

	The data sits nicely as a triangle, but in order to draw it as a bar chart, I had to make it a 5x11 instead.

	A. In the "All in One" category is 
		5-0-0 (Top Heavy), 0-5-0 (Perfectly Balanced), and 0-0-5 (Bottom Heavy).
	B. In the "Outer Pair" cetegory is 
		4-0-1 (Top Leaning), 3-0-2 (Mid Leaning Up), 2-0-3 (Mid Leaning Down), and 1-0-4 (Bottom Leaning)
	C. In the "Middle Exchange" category is 
		4-1-0 (Top Weighted), 3-2-0 (Top Leaning), 2-3-0 (Mid but Top Weighted), 1-4-0 (Mid Leaning Up), 0-4-1 (Mid Leaning Down), 0-3-2 (Mid but Bottom Weighted), 
			0-2-3 (Bottom Leaning), 0-1-4 (Bottom Weighted)
	D. In the "Triple, Outer Heavy" category is 
		3-1-1 (Mid but Top Weighted), 2-2-1 (Mid Leaning Up), 2-1-2 (Perfectly Balanced), 1-2-2 (Mid Leaning Down), and 1-1-3 (Mid but Bottom Weighted)
	E. In the "Triple, Inner HEavy" category is 
		1-3-1 (Perfectly Balanced)
   
### Future updates (if I care to keep going):
1. Merge with PB Parser so that top yearly and overall schemas are used in generating numbers.