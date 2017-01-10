#!/bin/bash

g++ -std=c++11 -Wall -o fixed_threshold fixed_threshold_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options
g++ -std=c++11 -Wall -o background_average background_average_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options
g++ -std=c++11 -Wall -o background_max background_max_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options
g++ -std=c++11 -Wall -o background_variance background_variance_method.cpp `pkg-config --cflags --libs opencv` -lboost_program_options

./fixed_threshold R1L1_right01.png R1L1_left01.png R1L1_correct01.png R1L1_fixed_threshold01.csv R1L1_fixed_threshold01 58
./fixed_threshold R1L1_right02.png R1L1_left02.png R1L1_correct02.png R1L1_fixed_threshold02.csv R1L1_fixed_threshold02 58 
./fixed_threshold R1L1_right11.png R1L1_left11.png R1L1_correct11.png R1L1_fixed_threshold11.csv R1L1_fixed_threshold11 58
./fixed_threshold R1L1_right12.png R1L1_left12.png R1L1_correct12.png R1L1_fixed_threshold12.csv R1L1_fixed_threshold12 58
./fixed_threshold R1L1_right13.png R1L1_left13.png R1L1_correct13.png R1L1_fixed_threshold13.csv R1L1_fixed_threshold13 58
./fixed_threshold R1L1_right14.png R1L1_left14.png R1L1_correct14.png R1L1_fixed_threshold14.csv R1L1_fixed_threshold14 58
./fixed_threshold R1L1_right15.png R1L1_left15.png R1L1_correct15.png R1L1_fixed_threshold15.csv R1L1_fixed_threshold15 58
./fixed_threshold R1L1_right16.png R1L1_left16.png R1L1_correct16.png R1L1_fixed_threshold16.csv R1L1_fixed_threshold16 58
./fixed_threshold R1L1_right17.png R1L1_left17.png R1L1_correct17.png R1L1_fixed_threshold17.csv R1L1_fixed_threshold17 58
./fixed_threshold R1L1_right18.png R1L1_left18.png R1L1_correct18.png R1L1_fixed_threshold18.csv R1L1_fixed_threshold18 58

./background_average R1L1_right01.png R1L1_left01.png R1L1_correct01.png R1L1_background_average01.csv R1L1_background_average01 R1L1
./background_average R1L1_right02.png R1L1_left02.png R1L1_correct02.png R1L1_background_average02.csv R1L1_background_average02 R1L1
./background_average R1L1_right11.png R1L1_left11.png R1L1_correct11.png R1L1_background_average11.csv R1L1_background_average11 R1L1
./background_average R1L1_right12.png R1L1_left12.png R1L1_correct12.png R1L1_background_average12.csv R1L1_background_average12 R1L1
./background_average R1L1_right13.png R1L1_left13.png R1L1_correct13.png R1L1_background_average13.csv R1L1_background_average13 R1L1
./background_average R1L1_right14.png R1L1_left14.png R1L1_correct14.png R1L1_background_average14.csv R1L1_background_average14 R1L1
./background_average R1L1_right15.png R1L1_left15.png R1L1_correct15.png R1L1_background_average15.csv R1L1_background_average15 R1L1
./background_average R1L1_right16.png R1L1_left16.png R1L1_correct16.png R1L1_background_average16.csv R1L1_background_average16 R1L1
./background_average R1L1_right17.png R1L1_left17.png R1L1_correct17.png R1L1_background_average17.csv R1L1_background_average17 R1L1
./background_average R1L1_right18.png R1L1_left18.png R1L1_correct18.png R1L1_background_average18.csv R1L1_background_average18 R1L1

./background_max R1L1_right01.png R1L1_left01.png R1L1_correct01.png R1L1_background_max01.csv R1L1_background_max01 R1L1
./background_max R1L1_right02.png R1L1_left02.png R1L1_correct02.png R1L1_background_max02.csv R1L1_background_max02 R1L1
./background_max R1L1_right11.png R1L1_left11.png R1L1_correct11.png R1L1_background_max11.csv R1L1_background_max11 R1L1
./background_max R1L1_right12.png R1L1_left12.png R1L1_correct12.png R1L1_background_max12.csv R1L1_background_max12 R1L1
./background_max R1L1_right13.png R1L1_left13.png R1L1_correct13.png R1L1_background_max13.csv R1L1_background_max13 R1L1
./background_max R1L1_right14.png R1L1_left14.png R1L1_correct14.png R1L1_background_max14.csv R1L1_background_max14 R1L1
./background_max R1L1_right15.png R1L1_left15.png R1L1_correct15.png R1L1_background_max15.csv R1L1_background_max15 R1L1
./background_max R1L1_right16.png R1L1_left16.png R1L1_correct16.png R1L1_background_max16.csv R1L1_background_max16 R1L1
./background_max R1L1_right17.png R1L1_left17.png R1L1_correct17.png R1L1_background_max17.csv R1L1_background_max17 R1L1
./background_max R1L1_right18.png R1L1_left18.png R1L1_correct18.png R1L1_background_max18.csv R1L1_background_max18 R1L1

./background_variance R1L1_right01.png R1L1_left01.png R1L1_correct01.png R1L1_background_variance01.csv R1L1_background_variance01 R1L1
./background_variance R1L1_right02.png R1L1_left02.png R1L1_correct02.png R1L1_background_variance02.csv R1L1_background_variance02 R1L1
./background_variance R1L1_right11.png R1L1_left11.png R1L1_correct11.png R1L1_background_variance11.csv R1L1_background_variance11 R1L1
./background_variance R1L1_right12.png R1L1_left12.png R1L1_correct12.png R1L1_background_variance12.csv R1L1_background_variance12 R1L1
./background_variance R1L1_right13.png R1L1_left13.png R1L1_correct13.png R1L1_background_variance13.csv R1L1_background_variance13 R1L1
./background_variance R1L1_right14.png R1L1_left14.png R1L1_correct14.png R1L1_background_variance14.csv R1L1_background_variance14 R1L1
./background_variance R1L1_right15.png R1L1_left15.png R1L1_correct15.png R1L1_background_variance15.csv R1L1_background_variance15 R1L1
./background_variance R1L1_right16.png R1L1_left16.png R1L1_correct16.png R1L1_background_variance16.csv R1L1_background_variance16 R1L1
./background_variance R1L1_right17.png R1L1_left17.png R1L1_correct17.png R1L1_background_variance17.csv R1L1_background_variance17 R1L1
./background_variance R1L1_right18.png R1L1_left18.png R1L1_correct18.png R1L1_background_variance18.csv R1L1_background_variance18 R1L1

mv R1L1_fixed_threshold*.png result_image/
mv R1L1_background*.png result_image/
