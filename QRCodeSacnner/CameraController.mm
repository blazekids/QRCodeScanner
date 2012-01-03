//
//  CameraController.m
//  QRCodeSacnner
//
//  Created by Chih Wei Yang on 11/12/21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "CameraController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "QRCodeReader.h"
#import "UniversalResultParser.h"
#import "InfoController.h"
#import "ParsedResult.h"
#import "ResultAction.h"

@implementation CameraController

@synthesize resultsView;
@synthesize resultsToDisplay;
@synthesize isCamera;
@synthesize scanImage;

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
    UIBarButtonItem * backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = backBtn;
    [resultsView setText:resultsToDisplay];
    [backBtn release];
}


- (void)viewDidUnload
{
    self.resultsView = nil;
    self.resultsToDisplay = nil;
    self.isCamera = nil;
    self.scanImage = nil;
    [super viewDidUnload];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) dealloc
{
    [resultsToDisplay release];
    [resultsView release];
    [scanImage release];
    [super dealloc];
}

-(IBAction) getPhoto:(id) sender {
	UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    
	picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
	[self presentModalViewController:picker animated:YES];
}

- (void)scanPressed:(BOOL) onCamera WithImage:(UIImage *)image
{
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:YES OneDMode:NO];
    widController.isCamera = onCamera;
    if(!widController.isCamera)
        widController.scanImage = image;
    
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    NSSet *readers = [[NSSet alloc] initWithObjects:qrcodeReader,nil];
    [qrcodeReader release];
    widController.readers = readers;
    [readers release];
    [UniversalResultParser load];
    NSBundle *mainBundle = [NSBundle mainBundle];
    widController.soundToPlay =
    [NSURL fileURLWithPath:[mainBundle pathForResource:@"beep-beep" ofType:@"aiff"] isDirectory:NO];
    
    [self presentModalViewController:widController animated:YES];
    
    [widController release];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info 
{
	[picker dismissModalViewControllerAnimated:NO];
    [self scanPressed:NO WithImage:[info objectForKey:@"UIImagePickerControllerOriginalImage"]];
}


#pragma mark -
#pragma mark ZXingDelegateMethods
- (void)zxingController:(ZXingWidgetController*)controller didScanResult:(id)parsedResult 
{
    InfoController * conInfo = [self.storyboard instantiateViewControllerWithIdentifier:@"Info"];
    conInfo.dataString =[parsedResult stringForDisplay]; 
    
    if (self.isViewLoaded) {
        [parsedResult populateActions];
        
        for (id i in [parsedResult actions]) {
            if(i != nil){
                conInfo.action = i;
            }    
        }
    }
    
    [self dismissModalViewControllerAnimated:NO];
    [self.navigationController pushViewController:conInfo animated:NO];
}

- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller 
{
    [self dismissModalViewControllerAnimated:YES];
}
@end
