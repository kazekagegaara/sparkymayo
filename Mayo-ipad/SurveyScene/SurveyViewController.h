//
//  SurveyViewController.h
//  Mayo-ipad
//
//  Created by Ashraf Gaffar on 11/11/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurveyViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property NSMutableArray *questionsOptionsList;
@property UITextField *activeTextField;
@property NSDictionary *dict;
@end
