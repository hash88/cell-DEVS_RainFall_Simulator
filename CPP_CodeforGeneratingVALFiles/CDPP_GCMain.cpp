#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <iostream>
#include <opencv2/imgproc/imgproc.hpp>
#include <fstream>

using namespace cv;
using namespace std;

void CallBackFunc(int event, int x, int y, int flags, void* userdata);

struct clickedPointStruct
{
	int x;
	int y;
	int index;
};

vector <clickedPointStruct> pointVector;
int clickIndex;

int main(int argc, char** argv)
{	
	Mat image;
	//image = imread("im1.jpg", IMREAD_COLOR); // Read the file
	image = imread("im3.jpg", IMREAD_COLOR);
	//image = imread("lena10.jpg", IMREAD_COLOR); // Read the file
	Mat grayImage;
	Mat resizedGrayImage;
	Size newSize(30, 30);
	ofstream valFile;
	valFile.open("grow_cut.val");
	clickIndex = 0;
	
	if (!image.data) 
	{
		cout << "Could not open or find the image" << std::endl;
		return -1;
	}

	cvtColor(image, grayImage, CV_BGR2GRAY);
	resize(grayImage, resizedGrayImage, newSize);

	for (int j = 0; j<resizedGrayImage.rows; j++)
	{
		for (int i = 0; i<resizedGrayImage.cols; i++)
		{
				valFile << "(" << j << "," << i << ",0) = " << +resizedGrayImage.at<uchar>(j, i)<<endl;
		}
	}

	namedWindow("Display window", WINDOW_NORMAL); 
	imshow("Display window", resizedGrayImage); 
	setMouseCallback("Display window", CallBackFunc, NULL);
	waitKey(0); 

	while (!pointVector.empty())
	{
		valFile << "(" << pointVector.back().y << "," << pointVector.back().x << ",1) = " << pointVector.back().index << endl; //labels
		valFile << "(" << pointVector.back().y << "," << pointVector.back().x << ",2) = 1" << endl; //theta
		pointVector.pop_back();
	}

	valFile.close();
	imwrite("Gray image.jpg", grayImage);
	imwrite("Resized gray image.jpg", resizedGrayImage);
	return 0;
}

void CallBackFunc(int event, int x, int y, int flags, void* userdata)
{
	if (event == EVENT_LBUTTONDOWN)
	{
		cout << "Left button of the mouse is clicked - position (" << x << ", " << y << ")" << endl;
		pointVector.push_back(clickedPointStruct());
		pointVector[clickIndex].x = x;
		pointVector[clickIndex].y = y;
		pointVector[clickIndex].index = clickIndex + 1;
		clickIndex++;
	}
	else if (event == EVENT_RBUTTONDOWN)
	{
		cout << "Right button of the mouse is clicked - position (" << x << ", " << y << ")" << endl;
	}
	else if (event == EVENT_MBUTTONDOWN)
	{
		cout << "Middle button of the mouse is clicked - position (" << x << ", " << y << ")" << endl;
	}
	else if (event == EVENT_MOUSEMOVE)
	{
		//cout << "Mouse move over the window - position (" << x << ", " << y << ")" << endl;
	}
}