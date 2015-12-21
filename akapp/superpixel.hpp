//
//  superpixel.hpp
//  akapp
//
//  Created by Akshay on 12/21/15.
//  Copyright © 2015 cornell university. All rights reserved.
//

#ifndef superpixel_hpp
#define superpixel_hpp
#include <vector>
#include <string>
#include <algorithm>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

typedef unsigned int UINT;
typedef unsigned char uchar;

enum imageType {RGB, GRAY};

class SLIC
{
public:
    SLIC();
    virtual ~SLIC();
    
    //===========================================================================
    ///	Perform SLIC algorithm on the given image
    /// with the given number of superpixels
    //===========================================================================
    void GenerateSuperpixels(
                             cv::Mat& img,
                             UINT numSuperpixels);
    
    //===========================================================================
    ///	Get label on each pixel which shows the number of superpixel it belongs to
    //===========================================================================
    int* GetLabel();
    
    //===========================================================================
    ///	Get the result image with contours on the given color
    //===========================================================================
    cv::Mat GetImgWithContours(cv::Scalar color);
    
private:
    
    //============================================================================
    // Superpixel segmentation for a given step size (superpixel size ~= step*step)
    //============================================================================
    void PerformSLICO_ForGivenStepSize(
                                       const unsigned int*			ubuff,//Each 32 bit unsigned int contains ARGB pixel values.
                                       const int					width,
                                       const int					height,
                                       int*						klabels,
                                       int&						numlabels,
                                       const int&					STEP,
                                       const double&				m);
    //============================================================================
    // Superpixel segmentation for a given number of superpixels
    //============================================================================
    void PerformSLICO_ForGivenK(
                                const unsigned int*			ubuff,//Each 32 bit unsigned int contains ARGB pixel values.
                                const int					width,
                                const int					height,
                                int*						klabels,
                                int&						numlabels,
                                const int&					K,
                                const double&				m);
    
    void PerformSLICO_ForGivenK(
                                const unsigned char*		ubuff,
                                const int					width,
                                const int					height,
                                int*						klabels,
                                int&						numlabels,
                                const int&					K,//required number of superpixels
                                const double&				m);//weight given to spatial distance
    
    //============================================================================
    // Function to draw boundaries around superpixels of a given 'color'.
    // Can also be used to draw boundaries around supervoxels, i.e layer by layer.
    //============================================================================
    void DrawContoursAroundSegments(
                                    unsigned int*				ubuff,
                                    const int*					labels,
                                    const int&					width,
                                    const int&					height,
                                    const cv::Scalar&			color );
    
    void DrawContoursAroundSegments(
                                    unsigned char*			ubuff,
                                    const int*				labels,
                                    const int&				width,
                                    const int&				height,
                                    const cv::Scalar&		color );
    
    void DrawContoursAroundSegmentsTwoColors(
                                             unsigned int*				ubuff,
                                             const int*					labels,
                                             const int&					width,
                                             const int&					height);
    
    
    
private:
    
    //============================================================================
    // Magic SLIC. No need to set M (compactness factor) and S (step size).
    // SLICO (SLIC Zero) varies only M dynamicaly, not S.
    //============================================================================
    void PerformSuperpixelSegmentation_VariableSandM(
                                                     vector<double>&				kseedsl,
                                                     vector<double>&				kseedsa,
                                                     vector<double>&				kseedsb,
                                                     vector<double>&				kseedsx,
                                                     vector<double>&				kseedsy,
                                                     int*						klabels,
                                                     const int&					STEP,
                                                     const int&					NUMITR);
    //============================================================================
    // Pick seeds for superpixels when step size of superpixels is given.
    //============================================================================
    void GetLABXYSeeds_ForGivenStepSize(
                                        vector<double>&				kseedsl,
                                        vector<double>&				kseedsa,
                                        vector<double>&				kseedsb,
                                        vector<double>&				kseedsx,
                                        vector<double>&				kseedsy,
                                        const int&					STEP,
                                        const bool&					perturbseeds,
                                        const vector<double>&		edgemag);
    //============================================================================
    // Pick seeds for superpixels when number of superpixels is input.
    //============================================================================
    void GetLABXYSeeds_ForGivenK(
                                 vector<double>&				kseedsl,
                                 vector<double>&				kseedsa,
                                 vector<double>&				kseedsb,
                                 vector<double>&				kseedsx,
                                 vector<double>&				kseedsy,
                                 const int&					STEP,
                                 const bool&					perturbseeds,
                                 const vector<double>&		edges);
    
    //============================================================================
    // Move the seeds to low gradient positions to avoid putting seeds at region boundaries.
    //============================================================================
    void PerturbSeeds(
                      vector<double>&				kseedsl,
                      vector<double>&				kseedsa,
                      vector<double>&				kseedsb,
                      vector<double>&				kseedsx,
                      vector<double>&				kseedsy,
                      const vector<double>&		edges);
    //============================================================================
    // Detect color edges, to help PerturbSeeds()
    //============================================================================
    void DetectLabEdges(
                        const double*				lvec,
                        const double*				avec,
                        const double*				bvec,
                        const int&					width,
                        const int&					height,
                        vector<double>&				edges);
    //============================================================================
    // xRGB to XYZ conversion; helper for RGB2LAB()
    //============================================================================
    void RGB2XYZ(
                 const int&					sR,
                 const int&					sG,
                 const int&					sB,
                 double&						X,
                 double&						Y,
                 double&						Z);
    //============================================================================
    // sRGB to CIELAB conversion
    //============================================================================
    void RGB2LAB(
                 const int&					sR,
                 const int&					sG,
                 const int&					sB,
                 double&						lval,
                 double&						aval,
                 double&						bval);
    //============================================================================
    // sRGB to CIELAB conversion for 2-D images
    //============================================================================
    void DoRGBtoLABConversion(
                              const unsigned int*&		ubuff,
                              double*&					lvec,
                              double*&					avec,
                              double*&					bvec);
    //============================================================================
    // sRGB to CIELAB conversion for 3-D volumes
    //============================================================================
    void DoRGBtoLABConversion(
                              const unsigned int**&		ubuff,
                              double**&					lvec,
                              double**&					avec,
                              double**&					bvec);
    
    //============================================================================
    // Post-processing of SLIC segmentation, to avoid stray labels.
    //============================================================================
    void EnforceLabelConnectivity(
                                  const int*					labels,
                                  const int&					width,
                                  const int&					height,
                                  int*						nlabels,//input labels that need to be corrected to remove stray labels
                                  int&						numlabels,//the number of labels changes in the end if segments are removed
                                  const int&					K); //the number of superpixels desired by the user
    
    void Mat2Buffer(const cv::Mat& img, UINT*& buffer);
    
    void Mat2Buffer(const cv::Mat& img, uchar*& buffer);
    
    
private:
    int										m_width;
    int										m_height;
    int										m_depth;
    
    double*									m_lvec;
    double*									m_avec;
    double*									m_bvec;
    
    double**								m_lvecvec;
    double**								m_avecvec;
    double**								m_bvecvec;
    
    UINT*									bufferRGB; // buffer for if RGB image
    uchar*									bufferGray; // buffer if gray image
    
    int*									label; // label record the superpixel pixel belongs to
    imageType								type;
};


#endif /* superpixel_hpp */
