#!/bin/bash

g++ -std=c++11 -Wall -o fixed_threshold fixed_threshold_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options
g++ -std=c++11 -Wall -o background_average background_average_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options
g++ -std=c++11 -Wall -o background_max background_max_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options
g++ -std=c++11 -Wall -o background_variance background_variance_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options

./fixed_threshold R1L2_right01.png R1L2_left01.png R1L2_correct01.png R1L2_fixed_threshold01.csv R1L2_fixed_threshold01 144
./fixed_threshold R1L2_right02.png R1L2_left02.png R1L2_correct02.png R1L2_fixed_threshold02.csv R1L2_fixed_threshold02 144 
./fixed_threshold R1L2_right11.png R1L2_left11.png R1L2_correct11.png R1L2_fixed_threshold11.csv R1L2_fixed_threshold11 144
./fixed_threshold R1L2_right12.png R1L2_left12.png R1L2_correct12.png R1L2_fixed_threshold12.csv R1L2_fixed_threshold12 144
./fixed_threshold R1L2_right13.png R1L2_left13.png R1L2_correct13.png R1L2_fixed_threshold13.csv R1L2_fixed_threshold13 144
./fixed_threshold R1L2_right14.png R1L2_left14.png R1L2_correct14.png R1L2_fixed_threshold14.csv R1L2_fixed_threshold14 144
./fixed_threshold R1L2_right15.png R1L2_left15.png R1L2_correct15.png R1L2_fixed_threshold15.csv R1L2_fixed_threshold15 144
./fixed_threshold R1L2_right16.png R1L2_left16.png R1L2_correct16.png R1L2_fixed_threshold16.csv R1L2_fixed_threshold16 144
./fixed_threshold R1L2_right17.png R1L2_left17.png R1L2_correct17.png R1L2_fixed_threshold17.csv R1L2_fixed_threshold17 144
./fixed_threshold R1L2_right18.png R1L2_left18.png R1L2_correct18.png R1L2_fixed_threshold18.csv R1L2_fixed_threshold18 144

./background_average R1L2_right01.png R1L2_left01.png R1L2_correct01.png R1L2_background_average01.csv R1L2_background_average01 R1L2
./background_average R1L2_right02.png R1L2_left02.png R1L2_correct02.png R1L2_background_average02.csv R1L2_background_average02 R1L2
./background_average R1L2_right11.png R1L2_left11.png R1L2_correct11.png R1L2_background_average11.csv R1L2_background_average11 R1L2
./background_average R1L2_right12.png R1L2_left12.png R1L2_correct12.png R1L2_background_average12.csv R1L2_background_average12 R1L2
./background_average R1L2_right13.png R1L2_left13.png R1L2_correct13.png R1L2_background_average13.csv R1L2_background_average13 R1L2
./background_average R1L2_right14.png R1L2_left14.png R1L2_correct14.png R1L2_background_average14.csv R1L2_background_average14 R1L2
./background_average R1L2_right15.png R1L2_left15.png R1L2_correct15.png R1L2_background_average15.csv R1L2_background_average15 R1L2
./background_average R1L2_right16.png R1L2_left16.png R1L2_correct16.png R1L2_background_average16.csv R1L2_background_average16 R1L2
./background_average R1L2_right17.png R1L2_left17.png R1L2_correct17.png R1L2_background_average17.csv R1L2_background_average17 R1L2
./background_average R1L2_right18.png R1L2_left18.png R1L2_correct18.png R1L2_background_average18.csv R1L2_background_average18 R1L2

./background_max R1L2_right01.png R1L2_left01.png R1L2_correct01.png R1L2_background_max01.csv R1L2_background_max01 R1L2
./background_max R1L2_right02.png R1L2_left02.png R1L2_correct02.png R1L2_background_max02.csv R1L2_background_max02 R1L2
./background_max R1L2_right11.png R1L2_left11.png R1L2_correct11.png R1L2_background_max11.csv R1L2_background_max11 R1L2
./background_max R1L2_right12.png R1L2_left12.png R1L2_correct12.png R1L2_background_max12.csv R1L2_background_max12 R1L2
./background_max R1L2_right13.png R1L2_left13.png R1L2_correct13.png R1L2_background_max13.csv R1L2_background_max13 R1L2
./background_max R1L2_right14.png R1L2_left14.png R1L2_correct14.png R1L2_background_max14.csv R1L2_background_max14 R1L2
./background_max R1L2_right15.png R1L2_left15.png R1L2_correct15.png R1L2_background_max15.csv R1L2_background_max15 R1L2
./background_max R1L2_right16.png R1L2_left16.png R1L2_correct16.png R1L2_background_max16.csv R1L2_background_max16 R1L2
./background_max R1L2_right17.png R1L2_left17.png R1L2_correct17.png R1L2_background_max17.csv R1L2_background_max17 R1L2
./background_max R1L2_right18.png R1L2_left18.png R1L2_correct18.png R1L2_background_max18.csv R1L2_background_max18 R1L2

./background_variance R1L2_right01.png R1L2_left01.png R1L2_correct01.png R1L2_background_variance01.csv R1L2_background_variance01 R1L2
./background_variance R1L2_right02.png R1L2_left02.png R1L2_correct02.png R1L2_background_variance02.csv R1L2_background_variance02 R1L2
./background_variance R1L2_right11.png R1L2_left11.png R1L2_correct11.png R1L2_background_variance11.csv R1L2_background_variance11 R1L2
./background_variance R1L2_right12.png R1L2_left12.png R1L2_correct12.png R1L2_background_variance12.csv R1L2_background_variance12 R1L2
./background_variance R1L2_right13.png R1L2_left13.png R1L2_correct13.png R1L2_background_variance13.csv R1L2_background_variance13 R1L2
./background_variance R1L2_right14.png R1L2_left14.png R1L2_correct14.png R1L2_background_variance14.csv R1L2_background_variance14 R1L2
./background_variance R1L2_right15.png R1L2_left15.png R1L2_correct15.png R1L2_background_variance15.csv R1L2_background_variance15 R1L2
./background_variance R1L2_right16.png R1L2_left16.png R1L2_correct16.png R1L2_background_variance16.csv R1L2_background_variance16 R1L2
./background_variance R1L2_right17.png R1L2_left17.png R1L2_correct17.png R1L2_background_variance17.csv R1L2_background_variance17 R1L2
./background_variance R1L2_right18.png R1L2_left18.png R1L2_correct18.png R1L2_background_variance18.csv R1L2_background_variance18 R1L2

mv R1L2_fixed_threshold*.png result_image/
mv R1L2_background*.png result_image/
