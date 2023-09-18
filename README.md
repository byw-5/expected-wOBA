# Expected-wOBA
This is a simple but accurate random forest model to create xwOBA values for batted balls.

#### Introduction
First we will look at actual wOBA vs the 2019 MLB xwOBA model.

<br/>
<p align="center">
<img width="500" alt="image" src="https://github.com/byw-5/expected-wOBA/assets/112497612/1c629488-f6d5-456a-b08a-933e397d2ce5">
  <br/>
<p align="center">
<em></em>

#### Difference Between This Model and the MLB Model
Aside from exit velocity and launch angle, MLB also considers sprint speed as one of the variables. However, this model is trained with CPBL batted ball data (From 2018~2021), and CPBL trackman data don't include sprint speed data. Therefore only exit velocity and launch angle are considered. 

#### Result

<p align="center">
<img width="500" alt="image" src="https://github.com/byw-5/expected-wOBA/assets/112497612/adde0d4d-d45c-483d-8f02-0a684409b583">

The model effectively captures the specific pattern of how exit velocity and launch angle combine to result in a hit, even when not accounting for sprint speed. One can clearly identify the white nike-shaped single zone and the red extra-bases zone.
