//
//  OMAuthViewController.m
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/24/13.
//
//

#import "OMAuthViewController.h"

@interface OMAuthViewController ()

@end

@implementation OMAuthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	NSLog(@">>> loaded view done did...");
	
	// Do any additional setup after loading the view.
	
	// Or this? http://www.wannabegeek.com/?p=168
	
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(myRightAction)];
	[recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
	//[self addGestureRecognizer:recognizer];
	[[self view] addGestureRecognizer:recognizer];
}

- (void)myRightAction
{
	NSLog(@">>> myRightAction");
	[self performSegueWithIdentifier: @"segueToTable" sender: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
