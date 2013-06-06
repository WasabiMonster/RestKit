//
//  OMBar.h
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 6/6/13.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface OMBar : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSDate * joinDate;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * location;

@end
