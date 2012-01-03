//
//  HistoryController.m
//  QRCodeSacnner
//
//  Created by Chih Wei Yang on 11/12/29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "HistoryController.h"

@implementation HistoryController
@synthesize listData;
@synthesize table;

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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/ 

-(void)viewDidAppear:(BOOL)animated
{
    
    //load history data
    NSString * filePath = [self dataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath])
        listData = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    //NSLog(@"Fileopen");
    
    [super viewDidAppear:animated];
    [table reloadData];
}

- (void)viewDidUnload
{
    listData = nil;
    table = nil;
    [super viewDidUnload];
}

-(void)dealloc
{
    [listData release];
    [table release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark Table View Data Source Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [listData objectAtIndex:([self.listData count]-1-indexPath.row)];
    
    return cell;
}

/*-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ResultAction * action = [listData objectAtIndex:(indexPath.row*2+1)];
    
    [action performActionWithController:self shouldConfirm:NO];
}*/
@end
