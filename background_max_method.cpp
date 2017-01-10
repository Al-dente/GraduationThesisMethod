#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/calib3d/calib3d.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/contrib/contrib.hpp>
#include <opencv2/opencv.hpp>
#include <opencv/cvaux.h>
#include <iostream>
#include <fstream>
#include <chrono>

#define N_IMAGES 150
#define THRESHOLD 28

using namespace std;
using namespace cv;

bool writeTxt (const string file_name, const Mat & mat) {
	string line;
	ofstream ofs(file_name.c_str());
		
	for(int j = 0; j < mat.rows; j++) {
		for(int i = 0; i < mat.cols; i++) {
			ofs << mat.at<uchar>(j, i);
			if(i < mat.cols - 1) ofs << ",";
			if(i == mat.cols - 1) ofs << "\n";
		}
	}

	return true;
}

Mat createBGMap(string pair_name) {
	vector<Mat> src_img(N_IMAGES);
	for(int i = 0; i < N_IMAGES; i++) {
		src_img[i] = imread(pair_name + "_no_object" + to_string(i) + ".png", 0);
//		cout << "Read " << pair_name << "_no_object" << to_string(i) << ".png" << endl;
	}

	int row = src_img[0].rows;
	int col = src_img[0].cols;
	
	Mat bgmap(row, col, CV_8U);
	Mat temp(row, col, CV_8U);

	int max;
	for(int j = 0; j < row; j++) {
		for(int i = 0; i < col; i++) {
			max = 0;
			for(int h = 0; h < N_IMAGES; h++) {
				if((max < (int)src_img[h].at<uchar>(j, i)) && ((int)src_img[h].at<uchar>(j, i) != 255))
				max = (int)src_img[h].at<uchar>(j, i);
			}
			temp.at<uchar>(j, i) = (uchar)max;
		}
	}

	bgmap = temp.clone();
	
/*	namedWindow("correct", CV_WINDOW_AUTOSIZE);
	namedWindow("test", CV_WINDOW_AUTOSIZE);
	imshow("correct", temp2);
	imshow("test", temp1);
*/
//	cout << bgmap << endl;

	writeTxt("bgmap.csv", bgmap);

	return bgmap;
}

int main(int argc, const char* argv[]) {
	/* 左右画像を読み込む */
	Mat r_img = imread(argv[1], 1);
	Mat l_img = imread(argv[2], 1);

	const int ROW = l_img.rows;
	const int COL = l_img.cols;
	const int N_PIXCEL = ROW * COL;
	const string PAIR = argv[6];
	const string FILE = argv[5];
	
	Mat R1L1bg = createBGMap(PAIR);
//	Mat_<double> R1L2bg = createBGMap("R1L2");
//	Mat_<double> R1L3bg = createBGMap("R1L3");

	/* stereoSGBM */
	auto start = chrono::system_clock::now();
	
	Mat n_img;
	Mat dis, mask;
	Mat out;

	StereoSGBM sgbm;
	int cn = l_img.channels();
	/*----------パラメータ----------*/
	sgbm.minDisparity = 0;          // 取り得る最小の視差値
	sgbm.numberOfDisparities = 64; // 取り得る最大の視差値
	sgbm.SADWindowSize = 3;         // マッチングされるブロックのサイズ(3-11)
	sgbm.P1 = 8*cn*sgbm.SADWindowSize*sgbm.SADWindowSize;	// 視差のなめらかさを制御するパラメータ、この値が大きくなる視差がなめらかになる
	sgbm.P2 = 32*cn*sgbm.SADWindowSize*sgbm.SADWindowSize;
	sgbm.disp12MaxDiff = 10;        // left-right視差チェックにおいて許容される最大の差(整数ピクセル単位)
	sgbm.preFilterCap = 63;         // 事前フィルタにおいて画像ピクセルを切り捨てる閾値
	sgbm.uniquenessRatio = 30;      // パーセント単位で表現されるマージン
	sgbm.speckleWindowSize = 300;   // ノイズスペックや無効なピクセルが考慮されたなめらかな視差領域の最大サイズ(0or50-200)
	sgbm.speckleRange = 1;          // それぞれの連結成分における最大視差値(16 or 32)
	sgbm.fullDP = false;            // 完全な2パス
	/*----------パラメータ----------*/
	
	sgbm(l_img, r_img, n_img);
	
	n_img.convertTo(dis, CV_8U, 255/((55 & -16)*16.));
	mask = dis.clone();
	writeTxt("dis.csv", dis);

	for(int j = 0; j < ROW; j++) { 
		for(int i = 0; i < COL; i++) {
			if(dis.at<uchar>(j, i) < R1L1bg.at<uchar>(j, i)) {
				mask.at<uchar>(j, i) = 0;	// Black
			} else if(dis.at<uchar>(j, i) - R1L1bg.at<uchar>(j, i) >= THRESHOLD) {	
				mask.at<uchar>(j, i) = 255;	// White
			} else if((R1L1bg.at<uchar>(j, i) - dis.at<uchar>(j, i) < THRESHOLD) && (R1L1bg.at<uchar>(j, i) - dis.at<uchar>(j, i) > THRESHOLD*(-1))) {
				mask.at<uchar>(j, i) = 0;	// Black
			} else {
				mask.at<uchar>(j, i) = 255;	// White
			}
		}
	}

	out = Mat::zeros(3, 3, CV_32FC1);
	l_img.copyTo(out, mask);
	
	auto end = chrono::system_clock::now();
	auto dur = end - start;
	auto msec = std::chrono::duration_cast<chrono::milliseconds>(dur).count();

	/* 正解画像と比較 */
	Mat correct_img = imread(argv[3], 1);
	Mat compare_img = l_img.clone();

	int n_correct;

	for(int j = 0; j < ROW; j++) {
		for(int i = 0; i < COL; i++) {
			if(out.at<Vec3b>(j, i) == correct_img.at<Vec3b>(j, i)) {
				n_correct++;
				compare_img.at<Vec3b>(j, i)[0] = 0;
				compare_img.at<Vec3b>(j, i)[1] = 0;
				compare_img.at<Vec3b>(j, i)[2] = 0;
			} else {
				compare_img.at<Vec3b>(j, i)[0] = 0;
				compare_img.at<Vec3b>(j, i)[1] = 0;
				compare_img.at<Vec3b>(j, i)[2] = 255;
			}
		}
	}
	
	double N_TP = 0, N_FP = 0, N_FN = 0, N_TN = 0;
	
	for(int j = 0; j < ROW; j++) {
		for(int i = 0; i < COL; i++) {
			if((out.at<Vec3b>(j, i)[0] == 0) && (out.at<Vec3b>(j, i)[1] == 0) && (out.at<Vec3b>(j, i)[2] == 0)) {	// システムによって背景と抽出された.
				if(out.at<Vec3b>(j, i) == correct_img.at<Vec3b>(j, i)) {	// 実際に背景である.
					N_TN++;
				} else {	// 実際にはオブジェクトである.
					N_FN++;
				}
			} else {	// システムによってオブジェクトと認識された.
				if(out.at<Vec3b>(j, i) == correct_img.at<Vec3b>(j, i)) {	// 実際にオブジェクトである.
					N_TP++;
				} else {	// 実際には背景である.
					N_FP++;
				}
			}
		}
	}
	
	double accuracy = 0, precision = 0, recall = 0, specificity = 0, f_measure = 0, falseaddition = 0, falsedeletion = 0;
	accuracy = (N_TN + N_TP) / N_PIXCEL * 100;
	precision = N_TP / (N_TP + N_FP) *100;
	recall = N_TP / (N_TP + N_FN) * 100;
	specificity = N_TN / (N_FP + N_TN) * 100;
	f_measure = 2 * precision * recall / (precision + recall);
	falseaddition = N_FP / (N_FP + N_TN) * 100;
	falsedeletion = N_FN / (N_TP + N_FN) * 100;
		
//	namedWindow("right", CV_WINiDOW_AUTOSIZE);
//	namedWindow("left", CV_WINDOW_AUTOSIZE);
	namedWindow("dis", CV_WINDOW_AUTOSIZE);
	namedWindow("out", CV_WINDOW_AUTOSIZE);
//	namedWindow("correct", CV_WINDOW_AUTOSIZE);
	namedWindow("compare", CV_WINDOW_AUTOSIZE);
	namedWindow("background", CV_WINDOW_AUTOSIZE);

//	imshow("right", r_img);
//	imshow("left", l_img);
	imshow("dis", dis);
	imshow("out", out);
//	imshow("correct", correct_img);
	imshow("compare", compare_img);
	imshow("background", R1L1bg);
	
	imwrite(FILE + "_dis.png", dis);
	imwrite(FILE + "_out.png", out);
	imwrite(FILE + "_compare.png", compare_img);
	imwrite(FILE + "_bg.png", R1L1bg);

	ofstream ofs(argv[4]);

	if(!ofs) {
		cout << "Cannot Open " << argv[4] << "."<< endl;
		return false;
	}
	
	ofs << argv[1] << "," << argv[2] << "," << "N_PIXCEL,N_TN,N_FN,N_TP,N_FP,Accuracy,Precision,Recall,Specificity,F-measure,False Addition,False Deletion,msec" << endl;
			
	ofs << argv[1];
	ofs << ",";
	ofs << argv[2];
	ofs << ",";
	ofs << N_PIXCEL;
	ofs << ",";
	ofs << N_TN;
	ofs << ",";
	ofs << N_FN;
	ofs << ",";
	ofs << N_TP;
	ofs << ",";
	ofs << N_FP;
	ofs << ",";
	ofs << accuracy;
	ofs << ",";
	ofs << precision;
	ofs << ",";
	ofs << recall;
	ofs << ",";
	ofs << specificity;
	ofs << ",";
	ofs << f_measure;
	ofs << ",";
	ofs << falseaddition;
	ofs << ",";
	ofs << falsedeletion;
	ofs << ",";
	ofs << msec;
	ofs << endl;
	
	cout << "N_PIXCEL: " << N_PIXCEL << endl;
	cout << "N_TN: " << N_TN << endl;
	cout << "N_FN: " << N_FN << endl;
	cout << "N_TP: " << N_TP << endl;
	cout << "N_FP: " << N_FP << endl;
	cout << endl;
	cout << "Accuracy: " << accuracy << "[%]" << endl;
	cout << "Precision: " << precision << "[%]" << endl;
	cout << "Recall: " << recall << "[%]" << endl;
	cout << "Specificity: " << specificity << "[%]" << endl;
	cout << "F-measure: " << f_measure << "[%]" << endl;
	cout << "False Addition: " << falseaddition << "[%]" << endl;
	cout << "False Deletion: " << falsedeletion << "[%]" << endl;
	cout << msec << "[msec]" << endl;
	cout << endl;
	waitKey(5000);

	return 0;

}
