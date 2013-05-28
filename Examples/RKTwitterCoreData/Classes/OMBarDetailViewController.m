//
//  OMBarDetailViewController.m
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/28/13.
//
//

#import "OMBarDetailViewController.h"

@interface OMBarDetailViewController ()

@end

@implementation OMBarDetailViewController

// @synthesize bar;
@synthesize tableHeaderView;
// @synthesize photoButton;
@synthesize nameLabel;

-(OMBarDetailViewController*)initWithBar:(OMBar*)aBar;
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if(self){
        //self.bar = aBar;
        self.navigationItem.title = @"Bar Details";
		NSLog(@">>> Initting w/ Bar %@", aBar);
    }
    return self;
}

/* - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	// TODO: Needed?
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
} */

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@">>> NEW VIEW!!!");
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
