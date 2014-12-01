//
//  reviewViewController.h
//  Mayo-ipad
//
//  Created by Sachin Dheeraj on 11/22/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface reviewViewController : UIViewController
@property NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UIButton *continueBtn;
@property BOOL isScrolled;
@property NSMutableArray *surveyQuestions;
@end
