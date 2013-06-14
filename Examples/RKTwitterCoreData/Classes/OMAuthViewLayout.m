//
//  OMAuthViewLayout.m
//  RKTwitterCoreData
//
//  Created by Patrick Wilson on 6/3/13.
//
//

#import "OMAuthViewLayout.h"

@implementation OMAuthViewLayout


// Designated initializer
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		_loginField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 270, 56)];
		[self setupInputField:_loginField withPlaceText:@"Login"];
		[self addSubview:_loginField];
		
		_passField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 270, 56)];
		[self setupInputFieldAsPassword:_passField withPlaceText:@"Password"];
		CGRect viewFrame = _passField.frame; // animatable. do not use frame if view is transformed since it will not correctly reflect the actual location of the view. use bounds + center instead
		viewFrame.origin.y += 70;
		_passField.frame = viewFrame;
		[self addSubview:_passField];
		
		_submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[_submitButton setTitle:@"Submit" forState:UIControlStateNormal];
		_submitButton.frame = CGRectMake(20, 300, 70, 50);
		[self addSubview:_submitButton];
		
    }
    return self;
}

- (void)setupInputField:(UITextField*)field
		  withPlaceText:(NSString*)placeText
{
	field.placeholder = placeText;
	field.textColor = [UIColor blackColor];
	field.backgroundColor = [UIColor whiteColor];
	field.returnKeyType = UIReturnKeyDone;
	field.borderStyle = UITextBorderStyleRoundedRect;
}

- (void)setupInputFieldAsPassword:(UITextField*)field
					withPlaceText:(NSString*)placeText
{
	[self setupInputField:field withPlaceText:placeText];
	field.secureTextEntry = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
