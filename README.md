#ECE 612 Final Project

The goal of this project is to compare various iir filters using MATLAB

filter_compare.m generates a signal and noise which are both composed of sinusoids then uses various lowpass iir filters to remove the noise frequencies.

The file handel_filt.m compares the available iir filters in MATLAB: Butterworth, Chebyshev Types I and II, and Ellipse.  Each of these filters is used from the built in function, which generates an analog filter then uses the bilinear transform to convert to a digital filter.  Separately, an analog filter of each type is generated then converted to digital using impulse invariance.

The signal being used for comparison is in the file handel.mat, which is available as an example in MATLAB.  White noise is generated then added to this signal.  The various filters are compared in their ability to remove this noise.

