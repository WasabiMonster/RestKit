//
//  OMBarDetailViewController.m
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/28/13.
//
//

#import "OMBarDetailViewController.h"
#import "OMBar.h"

@interface OMBarDetailViewController ()
@property (nonatomic, retain) OMBar *bar;

@end

#define ROW_HEIGHT 60

@implementation OMBarDetailViewController

@synthesize bar;
@synthesize tableHeaderView;
// @synthesize photoButton;
@synthesize nameLabel;

-(OMBarDetailViewController*)initWithBar:(OMBar*)aBar;
{
    self = [super initWithStyle:UITableViewCellStyleValue2];
    if(self){
        self.bar = aBar;
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
#warning This sucks
	// TODO: See TableViewCellSubviews sample
	NSLog(@">>> NEW VIEW!!!");
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[self.tableView reloadData];
	// nameLabel.text = bar.name;
	
	UILabel *headLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 200, 40)];
	[headLabel setBackgroundColor:[UIColor clearColor]];
	[headLabel setText: bar.name];
	[[self view] addSubview:headLabel];
	
	NSLog(@">>> View Will Appear: %@", bar.name);
	
}

// TODO: Implement something like this for next view...
/*
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // If the intructions section is tapped, navigate to the instructions view controller
 if (indexPath.section == INSTRUCTIONS_SECTION) {
 InstructionsViewController *nextViewController = [[[InstructionsViewController alloc] initWithNibName:@"RecipeInstructionsView" bundle:nil] autorelease];
 // pass the recipe to the instructions view controller
 ((InstructionsViewController *)nextViewController).recipe = recipe;
 [self.navigationController pushViewController:nextViewController animated:YES];
 }
 }
 */

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITableView Delegate/Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSLog(@">>> rows in section...");
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
	
	static NSString *CellIdentifier = @"TimeZoneCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil) {
		cell = [self tableViewCellWithReuseIdentifier:CellIdentifier];
	}
	
	// configureCell:cell forIndexPath: sets the text and image for the cell -- the method is factored out as it's also called during minuted-based updates.
	[self configureCell:cell forIndexPath:indexPath];
	return cell;
}

#pragma mark -
#pragma mark Configuring table view cells

#define NAME_TAG 1
#define TIME_TAG 2
#define IMAGE_TAG 3

#define LEFT_COLUMN_OFFSET 10.0
#define LEFT_COLUMN_WIDTH 160.0

#define MIDDLE_COLUMN_OFFSET 170.0
#define MIDDLE_COLUMN_WIDTH 90.0

#define RIGHT_COLUMN_OFFSET 280.0

#define MAIN_FONT_SIZE 18.0
#define LABEL_HEIGHT 26.0

#define IMAGE_SIDE 30.0


- (UITableViewCell *)tableViewCellWithReuseIdentifier:(NSString *)identifier
{
	
	/*
	 Create an instance of UITableViewCell and add tagged subviews for the name, local time, and quarter image of the time zone.
	 */
	
	UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
	
	/*
	 Create labels for the text fields; set the highlight color so that when the cell is selected it changes appropriately.
	 */
	UILabel *label;
	CGRect rect;
	
	// Create a label for the time zone name.
	rect = CGRectMake(LEFT_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, LEFT_COLUMN_WIDTH, LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = NAME_TAG;
	label.font = [UIFont boldSystemFontOfSize:MAIN_FONT_SIZE];
	label.adjustsFontSizeToFitWidth = YES;
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];
	
	// Create a label for the time.
	rect = CGRectMake(MIDDLE_COLUMN_OFFSET, (ROW_HEIGHT - LABEL_HEIGHT) / 2.0, MIDDLE_COLUMN_WIDTH, LABEL_HEIGHT);
	label = [[UILabel alloc] initWithFrame:rect];
	label.tag = TIME_TAG;
	label.font = [UIFont systemFontOfSize:MAIN_FONT_SIZE];
	label.textAlignment = UITextAlignmentRight;
	[cell.contentView addSubview:label];
	label.highlightedTextColor = [UIColor whiteColor];
	
	// Create an image view for the quarter image.
	rect = CGRectMake(RIGHT_COLUMN_OFFSET, (ROW_HEIGHT - IMAGE_SIDE) / 2.0, IMAGE_SIDE, IMAGE_SIDE);
	
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
	imageView.tag = IMAGE_TAG;
	[cell.contentView addSubview:imageView];
	
	return cell;
}

- (void)configureCell:(UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@">>> configure cell");
    /*
	 Cache the formatter. Normally you would use one of the date formatter styles (such as NSDateFormatterShortStyle), but here we want a specific format that excludes seconds.
	 */
	static NSDateFormatter *dateFormatter = nil;
	if (dateFormatter == nil) {
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"h:mm a"];
	}
	
	// Get the time zones for the region for the section
	//// Region *region = [displayList objectAtIndex:indexPath.section];
	//// NSArray *regionTimeZones = region.timeZoneWrappers;
	//// TimeZoneWrapper *wrapper = [regionTimeZones objectAtIndex:indexPath.row];
	
	UILabel *label;
	
	// Set the locale name.
	label = (UILabel *)[cell viewWithTag:NAME_TAG];
	//// label.text = wrapper.localeName;
	
	// Set the time.
	//// [dateFormatter setTimeZone:wrapper.timeZone];
	//// label = (UILabel *)[cell viewWithTag:TIME_TAG];
	//// label.text = [dateFormatter stringFromDate:[NSDate date]];
	
	// Set the image.
	//// UIImageView *imageView = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
	//// imageView.image = wrapper.image;
}



@end
