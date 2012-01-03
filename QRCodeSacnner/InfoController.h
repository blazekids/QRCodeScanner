//
//  InfoController.h
//  QRCodeSacnner
//
//  Created by Chih Wei Yang on 11/12/28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultAction.h"
#define kFilename @"data.plist"

@interface InfoController : UIViewController
{
    IBOutlet UITextView * resultsView;
    NSString * dataString;
    ResultAction * action;
}
@property (nonatomic, retain) IBOutlet UITextView *resultsView;
@property (strong) NSString * dataString;
@property (strong) ResultAction * action;
-(NSString *)dataFilePath;
-(void)nextAction:(id)sender;
-(void)stroeToFile;
@end
