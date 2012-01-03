//
//  HistoryController.h
//  QRCodeSacnner
//
//  Created by Chih Wei Yang on 11/12/29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResultAction.h"
#define kFilename @"data.plist"

@interface HistoryController : UIViewController
<UITableViewDelegate, UITableViewDataSource>
{
    NSArray * listData;
    UITableView * table;
}
@property (nonatomic, retain) NSArray * listData;
@property (nonatomic, retain) IBOutlet UITableView * table;
-(NSString *)dataFilePath;
@end