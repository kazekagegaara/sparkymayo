//
//  SurveyViewController.m
//  Mayo-ipad
//
//  Created by Ashraf Gaffar on 11/11/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import "SurveyViewController.h"
#import "QuestionAndOptions.h"
#import "SurveyXMLHelper.h"
#import "RadioButton.h"
#import "CheckBox.h"

@interface SurveyViewController ()
@property NSMutableArray *pickerViewsArray;
@property (weak, nonatomic) IBOutlet UITextView *remarks;
@property (weak, nonatomic) IBOutlet UIButton *submitSurvey;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation SurveyViewController
@synthesize dict;
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"mayobg.png"]]];
    //self.view.backgroundColor = [UIColor clearColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.questionsOptionsList = [[NSMutableArray alloc] init];
    self.pickerViewsArray = [[NSMutableArray alloc] init];
//    [self loadQuestionsAndOptionsFromFile];
    SurveyXMLHelper *helper = [[SurveyXMLHelper alloc]init];
    self.questionsOptionsList = [helper getLoadedQuestionOptionsList];

    [self createPickerViews];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

}

- (BOOL)shouldAutorotate { return NO; }

- (NSUInteger)supportedInterfaceOrientations {
    return (UIInterfaceOrientationMaskLandscape);
}

- (void)createPickerViews

{
    for(int x = 0; x < [self.questionsOptionsList count]; x++) //number of picker views
    {
//        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:(CGRect){{15, 20}, 500, 1}];
//        pickerView.delegate = self;
//        pickerView.dataSource = self;
//        pickerView.tag = x;
////        pickerView.backgroundColor = [UIColor clearColor];
//        pickerView.opaque = false;
//        [self.pickerViewsArray addObject:pickerView];
        QuestionAndOptions *item = [self.questionsOptionsList objectAtIndex:x];
        
        if(item.objective){
            RadioButton *radioGroup =[[RadioButton alloc]
                                    initWithFrame:CGRectMake(0, 60, 1000, 75)
                                    andOptions:item.options andColumns:4];
            [self.pickerViewsArray addObject:radioGroup];
        } else{
            CheckBox *checkBoxGroup =[[CheckBox alloc]
                              initWithFrame:CGRectMake(0, 60, 1000, 75)
                              andOptions:item.options andColumns:4];
            [self.pickerViewsArray addObject:checkBoxGroup];
        }
        

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.questionsOptionsList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"questionCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSLog(@"inside cell == nil");
    }
    QuestionAndOptions *item = [self.questionsOptionsList objectAtIndex:indexPath.row];

    for(UIView *view in cell.contentView.subviews){
        if ([view isKindOfClass:[UIView class]]) {
            [view removeFromSuperview];
        }
    }
    // Configure the cell...
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 1000, 75)];
    label.text = item.question;
    [cell.contentView addSubview:label];
    cell.backgroundColor = [UIColor clearColor];
//    [cell.textLabel frameForAlignmentRect:CGRectMake(0, 0, 10, 20)];
//    cell.textLabel.text = item.question;
//    [cell.textLabel sizeToFit];
    [cell.contentView addSubview:(UIPickerView*)[self.pickerViewsArray objectAtIndex:indexPath.row]];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0f; //just some arbitrary value, change it to suit your needs.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (IBAction)SubmitButtonClicked:(id)sender {
    BOOL allAnswered = true;
    NSMutableArray *surveyQustions = [[NSMutableArray alloc] init];
    NSMutableArray *surveyAnswers = [[NSMutableArray alloc] init];
    for( int i = 0; i< self.pickerViewsArray.count; i++){
        UIView *view = [self.pickerViewsArray objectAtIndex:i];
        if ([view isKindOfClass:[RadioButton class]]) {
            int selectedIndex = ((RadioButton *)view).currentIndex;
            if(selectedIndex == -1){
                allAnswered=false;
                break;
//                allAnswered = false;
////                [self tableView:(UITableView *)self.tableView cellForRowAtIndexPath:(NSIndexPath *)]
//                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 380, 1000, 75)];
//                label.textColor = [UIColor redColor];
//                label.text = @"please answer the question";
//                label.font = [UIFont systemFontOfSize:10]
////                [cell.contentView addSubview:label]
//;                [((UITableViewCell *)view.superview) addSubview:label];
            }
            QuestionAndOptions *currentQues = [self.questionsOptionsList objectAtIndex:i];
            [surveyAnswers addObject: [currentQues.options objectAtIndex:selectedIndex]];
            [surveyQustions addObject: currentQues.question];
             }
        
        if ([view isKindOfClass:[CheckBox class]]) {
            NSMutableArray *selectedOptions = ((CheckBox *)view).selectedOptions;
            QuestionAndOptions *currentQues = [self.questionsOptionsList objectAtIndex:i];
            
            NSString *ans =@"";
            for( int i =0; i<[selectedOptions count]; i++){
                ans= [ans stringByAppendingString:[currentQues.options objectAtIndex:i]];
                ans= [ans stringByAppendingString:@","];
            }
            [surveyAnswers addObject: ans];
            [surveyQustions addObject: currentQues.question];
        }

        
    }
    if (allAnswered) {
        [surveyAnswers addObject: self.remarks.text];
        [surveyQustions addObject: @"remarks"];
        self.dict = [NSDictionary dictionaryWithObjects:surveyAnswers forKeys:surveyQustions];
        [[NSUserDefaults standardUserDefaults] setValue:self.dict forKey:@"dict"];
        [[NSUserDefaults standardUserDefaults] setValue:surveyQustions forKey:@"surveyQuestions"];
        [self performSegueWithIdentifier:@"review_segue" sender:self];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Sorry"
                                    message:@"Please answer all the questions to continue"
                                   delegate: nil
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:nil
          ] show];
    }
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"review_segue"]) {
        SurveyViewController *destViewController = segue.destinationViewController;
    }
}

- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    
    self.mainScrollView.contentInset = contentInsets;
    self.mainScrollView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.remarks.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.remarks.frame.origin.y - (keyboardSize.height-110));
        [self.mainScrollView setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.mainScrollView.contentInset = contentInsets;
    self.mainScrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.activeTextField = self.remarks;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.activeTextField = nil;
}
- (IBAction)dismissKeyboard:(id)sender
{
    [self.activeTextField resignFirstResponder];
}
@end
