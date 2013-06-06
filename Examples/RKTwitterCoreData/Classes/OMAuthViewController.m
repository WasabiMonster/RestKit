//
//  OMAuthViewController.m
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/24/13.
//
//

#import "OMAuthViewController.h"
#import "OMAuthViewLayout.h"

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
	
	// TODO: Only show Authorization if credentials not verified
	
	// Or this? http://www.wannabegeek.com/?p=168
	
	UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftSwipe)];
	[recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
	//[self addGestureRecognizer:recognizer];
	[[self view] addGestureRecognizer:recognizer];
	
	// [self setAuthFields];
	
	OMAuthViewLayout *view = [[OMAuthViewLayout alloc] initWithFrame:CGRectMake(0, 0, 300, 250)];
	view.backgroundColor = [UIColor grayColor];
	
	view.center = self.view.center;
	
	[self.view addSubview:view];
	
	
}

- (void)leftSwipe
{
	[self performSegueWithIdentifier: @"segueToTable" sender: self];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
