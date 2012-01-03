//
//  InfoController.m
//  QRCodeSacnner
//
//  Created by Chih Wei Yang on 11/12/28.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "InfoController.h"

@implementation InfoController
@synthesize resultsView;
@synthesize dataString;
@synthesize action;

-(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:kFilename];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    resultsView.text = self.dataString;
    [self stroeToFile];
    
    //set right button of navigation bar
    UIBarButtonItem * rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    //set back button of navigation bar
    UIBarButtonItem * backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    
    [rightBtn release];
    [backBtn release];
    //[action performActionWithController:self shouldConfirm:YES];
}


- (void)viewDidUnload
{
    resultsView = nil;
    dataString = nil;
    action = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [resultsView release];
    [dataString release];
    [action release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)nextAction:(id)sender
{
    [action performActionWithController:self shouldConfirm:NO];
}

-(void)stroeToFile
{
    NSString * filePath = [self dataFilePath];
    NSMutableArray * listData;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        listData = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    else
        listData = [[NSMutableArray alloc] init];
    
    if ([listData count] >= 10)
    {
        for(int i=0;i<([listData count]-10);++i)
            [listData removeObjectAtIndex:0];
    }
    
    //Find "\n" in dataString
    NSRange searchString = [dataString rangeOfString:@"\n"];
    
    NSString * newString;
    
    if(searchString.location == NSNotFound)
        newString = dataString;
    else
        newString = [dataString substringToIndex:searchString.location];
    
    [listData addObject:newString];
    [listData writeToFile:filePath atomically:YES];
    
    newString = nil;
    [newString release];
    [listData release];
}
@end
