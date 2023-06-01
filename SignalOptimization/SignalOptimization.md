# Description of signal optimization method
Three signal fluctuation profiles were tested.
1. Gaussian
2. Uniform
3. Bimodal

**Gaussian**

Gaussian distribution with a mean of 0 and a std of 21.01. Tails are cut off at the max amplitude which is 60 in this case. Gaussian(0,30) in Arduino. Units are of PWM out of 255.

**Uniform**

Uniform random amplitude distribution across the entire amplitude range. In this case -60,60 about an average of 110. Units are of PWM out of 255.

**Bimodal**

Two Gaussian distributions offset by the desired average amplitude. Two Gaussians of a mean of 0 and a std of 6.8. Programmed in Arduino as Gaussian (0, 10) with the tails cut off at +/- 15. Units are of PWM out of 255.
