//
//  reviewViewController.m
//  Mayo-ipad
//
//  Created by Sachin Dheeraj on 11/22/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import "reviewViewController.h"

@interface reviewViewController ()

@end

@implementation reviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dict=[[NSUserDefaults standardUserDefaults] objectForKey:@"dict"];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mayobg.png"]]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.isScrolled=false;
    self.surveyQuestions=[[NSUserDefaults standardUserDefaults] objectForKey:@"surveyQuestions"];
}

- (BOOL)shouldAutorotate { return NO; }

- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskLandscape);
}

- (IBAction)continueBtn:(id)sender {
    if (self.isScrolled) {
        [self performSegueWithIdentifier:@"viewPics_segue" sender:self];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                    message:@"Please scroll through all the answers to continue"
                                   delegate: nil
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:nil
          ] show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dict count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        cell.textLabel.numberOfLines = 20;
    }
    cell.backgroundColor = [UIColor clearColor];
    NSString *answer=[self formatAnswerString:[self.dict objectForKey:self.surveyQuestions[indexPath.row]]];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld) %@\n    %@",indexPath.row+1, self.surveyQuestions[indexPath.row],answer];
    return cell;
}

//to make sure continue button appears only when the table is scrolled entirely
- (void)scrollViewDidEndDragging:(UIScrollView *)aScrollView
                  willDecelerate:(BOOL)decelerate
{
    CGPoint offset = aScrollView.contentOffset;
    CGRect bounds = aScrollView.bounds;
    CGSize size = aScrollView.contentSize;
    UIEdgeInsets inset = aScrollView.contentInset;
    float y = offset.y + bounds.size.height - inset.bottom;
    float h = size.height;
    
    float reload_distance = 50;
    if(y > h + reload_distance) {
        self.isScrolled=true;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(NSString*)formatAnswerString:(NSString*)input{
    NSMutableArray *splitStrings=(NSMutableArray*)[input componentsSeparatedByString:@","];
    if ([splitStrings count]>1) {
        [splitStrings removeLastObject];
    }
    NSString *output=[splitStrings componentsJoinedByString:@"\n    "];
    return output;
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"viewPics_segue"]) {
        reviewViewController *destViewController = segue.destinationViewController;
    }
}

@end
