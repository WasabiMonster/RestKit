//
//  OMBarDetailViewController.h
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/28/13.
//
//

#import <UIKit/UIKit.h>

@class OMBar;

@interface OMBarDetailViewController : UITableViewController {
	OMBar *bar;
	UIView *tableHeaderView;
	// UIButton *photoButton;
	UILabel *nameLabel;
}

-(OMBarDetailViewController*)initWithBar:(OMBar*)aBar;

@property (nonatomic, retain) IBOutlet UIView *tableHeaderView;
// @property (nonatomic, retain) IBOutlet UIButton *photoButton;
@property (nonatomic, retain) IBOutlet UILabel *nameLabel;


@end
