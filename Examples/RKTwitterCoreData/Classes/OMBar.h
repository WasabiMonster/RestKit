//
//  OMBar.h
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 5/24/13.
//
//

#import <RestKit/RestKit.h>
#import <RestKit/CoreData.h>

@interface OMBar : NSManagedObject

@property (nonatomic, copy) NSString *email;

@property (nonatomic, copy) NSDate *joinDate;

@property (nonatomic, copy) NSString *location;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *website;

@end
