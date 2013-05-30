//
//  OMBar.m
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/24/13.
//
//

#import "OMBar.h"

@implementation OMBar

@dynamic email;
@dynamic joinDate;
@dynamic location;
@dynamic name;
@dynamic phone;
@dynamic website;
// TODO: Add hash and/or user

/*
 Initialize
 */
- (id)init {
	if ((self = [super init])) {
		NSLog(@">>> Init OMBar...");
	}
	return self;
}

@end
