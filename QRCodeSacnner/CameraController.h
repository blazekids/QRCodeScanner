//
//  CameraController.h
//  QRCodeSacnner
//
//  Created by Chih Wei Yang on 11/12/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZXingWidgetController.h"

@interface CameraController : UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, ZXingDelegate>
{
    IBOutlet UITextView *resultsView;
    NSString *resultsToDisplay;
    BOOL isCamera;
    UIImage *scanImage;
}
@property (nonatomic, retain) IBOutlet UITextView *resultsView;
@property (nonatomic, copy) NSString *resultsToDisplay;
@property (nonatomic, assign) BOOL isCamera;
@property (nonatomic, retain) UIImage *scanImage;

-(IBAction) getPhoto:(id) sender;
- (void)scanPressed:(BOOL) onCamera WithImage:(UIImage *) image;
@end
