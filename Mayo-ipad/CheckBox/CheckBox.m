//
//  RadioButton.m
//  Mayo-ipad
//
//  Created by Akshay Ashwathanarayana on 11/20/14.
//  Copyright (c) 2014 Akshay Ashwathanarayana. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox
@synthesize radioButtons;

- (id)initWithFrame:(CGRect)frame andOptions:(NSArray *)options
         andColumns:(int)columns{
    
    NSMutableArray *arrTemp =[[NSMutableArray alloc]init];
    self.selectedOptions =[[NSMutableArray alloc]init];
    self.radioButtons =arrTemp;
    if (self = [super initWithFrame:frame]) {
        // Initialization code
        int framex =0;
        framex= frame.size.width/columns;
        int framey = 0;
        framey =frame.size.height/([options count]/(columns));
        int rem =[options count]%columns;
        if(rem !=0){
            framey =frame.size.height/(([options count]
                                        /columns)+1);
        }
        int k = 0;
        for(int i=0;i<([options count]/columns);i++){
            for(int j=0;j<columns;j++){
                
                int x = framex*0.25;
                int y = framey*0.25;
                UIButton *btTemp = [[UIButton alloc]
                                    initWithFrame:CGRectMake(framex*j+x, framey*i+y,
                                                             framex/2+x, framey/2+y)];
                [btTemp addTarget:self action:
                 @selector(radioButtonClicked:)
                 forControlEvents:UIControlEventTouchUpInside];
                btTemp.contentHorizontalAlignment =
                UIControlContentHorizontalAlignmentLeft;
                [btTemp setImage:[UIImage imageNamed:
                                  @"check-off.png"] forState:UIControlStateNormal];
                [btTemp setTitleColor:[UIColor blackColor]
                             forState:UIControlStateNormal];
                btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
                [btTemp setTitle:[options objectAtIndex:k]
                        forState:UIControlStateNormal];
                [self.radioButtons addObject:btTemp];
                [self addSubview:btTemp];
                k++;
                
            }
        }
        
        for(int j=0;j<rem;j++){
            
            int x = framex*0.25;
            int y = framey*0.25;
            UIButton *btTemp = [[UIButton alloc]
                                initWithFrame:CGRectMake(framex*j+x,
                                                         framey* ([options count]/columns),
                                                         framex/2+x,framey/2+y)];
            [btTemp addTarget:self action:@selector(radioButtonClicked:)
             forControlEvents:UIControlEventTouchUpInside];
            btTemp.contentHorizontalAlignment =
            UIControlContentHorizontalAlignmentLeft;
            [btTemp setImage:[UIImage imageNamed:@"check-off.png"]
                    forState:UIControlStateNormal];
            [btTemp setTitleColor:[UIColor blackColor]
                         forState:UIControlStateNormal];
            btTemp.titleLabel.font =[UIFont systemFontOfSize:14.f];
            [btTemp setTitle:[options objectAtIndex:k]
                    forState:UIControlStateNormal];
            [self.radioButtons addObject:btTemp];
            [self addSubview:btTemp];
            k++;
            
        }
        
    }
    return self;
}

-(IBAction) radioButtonClicked:(UIButton *) sender{
    
    if( [self.selectedOptions containsObject:[NSNumber numberWithInteger:[self.radioButtons indexOfObject:sender]]] ){
        [sender setImage:[UIImage imageNamed:@"check-off.png"]
                forState:UIControlStateNormal];
        [self.selectedOptions removeObject:[NSNumber numberWithInteger:[self.radioButtons indexOfObject:sender]]];
    }else{
        [self.selectedOptions addObject:[NSNumber numberWithInteger:[self.radioButtons indexOfObject:sender]]];
        [sender setImage:[UIImage imageNamed:@"check-on.png"]
                forState:UIControlStateNormal];
    }
}

-(void) removeButtonAtIndex:(int)index{
    [[self.radioButtons objectAtIndex:index] removeFromSuperview];
}

-(void) setSelected:(int) index{
    for(int i=0;i<[self.radioButtons count];i++){
        [[self.radioButtons objectAtIndex:i] setImage:[UIImage
                                                       imageNamed:@"check-off.png"] forState:UIControlStateNormal];
        
    }
    [[self.radioButtons objectAtIndex:index] setImage:[UIImage
                                                       imageNamed:@"check-on.png"] forState:UIControlStateNormal];
    [self.selectedOptions addObject:[NSNumber numberWithInteger:index]];

    
}

-(void)clearAll{
    for(int i=0;i<[self.radioButtons count];i++){
        [[self.radioButtons objectAtIndex:i] setImage:[UIImage
                                                       imageNamed:@"check-off.png"]
                                             forState:UIControlStateNormal];
    }
    self.selectedOptions =[[NSMutableArray alloc]init];
}



@end
