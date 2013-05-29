//
//  RKTwitterViewController.m
//  RKTwitter
//
//  Created by Blake Watters on 9/5/10.
//  Copyright (c) 2009-2012 RestKit. All rights reserved.
//

#import "RKTwitterViewController.h"
#import "OMBar.h"
#import "OMBarDetailViewController.h"

static void RKTwitterShowAlertWithError(NSError *error)
{
    UIAlertView *alert = [[UIAlertView alloc]	initWithTitle:@"Error"
												message:[error localizedDescription]
												delegate:nil
												cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@interface RKTwitterViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@end

@implementation RKTwitterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// self.tableView.allowsSelection = YES; // Worked!!!
	
    // Set debug logging level. Set to 'RKLogLevelTrace' to see JSON payload
    RKLogConfigureByName("RestKit/Network", RKLogLevelDebug);

    // Setup View and Table View
    self.title = @"Test RestKit";

    // Core data fetch/pull....
	NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Bar"];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"joinDate" ascending:NO];
    fetchRequest.sortDescriptors = @[descriptor];
    NSError *error = nil;
	
    // Setup fetched results
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:[RKManagedObjectStore defaultStore].mainQueueManagedObjectContext
																		sectionNameKeyPath:nil
																		cacheName:nil];
	
    [self.fetchedResultsController setDelegate:self];
    BOOL fetchSuccessful = [self.fetchedResultsController performFetch:&error];
    NSAssert([[self.fetchedResultsController fetchedObjects] count], @"Seeding didn't work...");
    if (! fetchSuccessful) {
        RKTwitterShowAlertWithError(error);
    }

    [self loadData];
}


- (void)loadData
{
    // Load the object model via RestKit
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/api/v1/bar/?format=json" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load complete: Table should refresh...");
		// NSLog(@">>> mappingResult: %@", mappingResult.array);

        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"LastUpdatedAt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Load failed with error: %@", error);

        RKTwitterShowAlertWithError(error);
    }];
}

- (IBAction)refresh:(id)sender
{
    // Load the object model via RestKit
    [self loadData];
}


// TODO: Unhighlight
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// TODO: Get Bar Model object from RK here....
    // OMBar *bar = nil; // [recipesController objectInRecipesAtIndex:indexPath.row];
	OMBar *bar = [self.fetchedResultsController objectAtIndexPath:indexPath];
	
	NSLog(@">>> Touched %i", indexPath.row);
	
    [self showBarDetail:bar];
}

- (void)showBarDetail:(OMBar *)bar
{
	// TODO: See Apple's way: https://developer.apple.com/videos/ios/ <-- passing data between scenes in storyboards
	NSLog(@">>> showBarDetail() [RKObjectManager sharedManager].description: %@", [RKObjectManager sharedManager].description);
    OMBarDetailViewController *detailViewController = [[OMBarDetailViewController alloc] initWithBar:bar];
    [self.navigationController pushViewController:detailViewController animated:YES];
    // [detailViewController release];
}


#pragma mark UITableViewDelegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OMBar *status = [self.fetchedResultsController objectAtIndexPath:indexPath];
    CGSize size = [[status name] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(300, 9000)];
    return size.height + 40;
}

#pragma mark UITableViewDataSource methods

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDate *lastUpdatedAt = [[NSUserDefaults standardUserDefaults] objectForKey:@"LastUpdatedAt"];
    NSString *dateString = [NSDateFormatter localizedStringFromDate:lastUpdatedAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterMediumStyle];
    if (nil == dateString) {
        dateString = @"Never";
    }
    return [NSString stringWithFormat:@"Last Loaded: %@", dateString];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reuseIdentifier = @"Tweet Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"listbg.png"]];
    }
    OMBar *status = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = status.name;
    return cell;
}

#pragma mark NSFetchedResultsControllerDelegate methods

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
	NSLog(@">>> controllerDidChangeContent..."); // Fires only when the table has changed
    [self.tableView reloadData];
}

@end
