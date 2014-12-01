//
//  RadioButton.h
//  Mayo-ipad
//
//  Created by Ashraf Gaffar on 11/20/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButton : UIView{
    NSMutableArray *radioButtons;
}

@property (nonatomic,retain) NSMutableArray *radioButtons;
@property int currentIndex;
- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options
         andColumns:(int)columns;
-(IBAction) radioButtonClicked:(UIButton *) sender;
-(void) removeButtonAtIndex:(int)index;
-(void) setSelected:(int) index;
-(void)clearAll;
@end
