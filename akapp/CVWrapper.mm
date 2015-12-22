#import "CVWrapper.h"
#import "UIImage+OpenCV.h"
#import "UIImage+Rotate.h"
#import "superpixel.hpp"


@implementation CVWrapper


+ (UIImage*) processWithArray:(NSArray*)imageArray
{
    std::vector<cv::Mat> matImages;
    for (id image in imageArray) {
        if ([image isKindOfClass: [UIImage class]]) {
            UIImage* rotatedImage = [image rotateToImageOrientation];
            cv::Mat matImage = [rotatedImage CVMat3];
            matImages.push_back(matImage);
        }
    }
    NSLog (@"computing superpixels...");
    SLIC* test = new SLIC();
    test->GenerateSuperpixels(matImages[0], 200);
    cv::Mat resultPix =  test->GetImgWithContours(cv::Scalar(0, 0, 255));
    UIImage* result =  [UIImage imageWithCVMat:resultPix];
    delete test;
    return result;
}


@end
