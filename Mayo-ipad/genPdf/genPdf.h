//
//  genPdf.h
//  Mayo-ipad
//
//  Created by Subhransu Mishra and Anirudh Adibhatla on 11/23/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NSMutableDictionary *patientMap;

@interface genPdf : NSObject

@property (nonatomic,strong) NSDictionary *dict;
@property (nonatomic) int *numOfQinDict;
@property (weak, nonatomic) IBOutlet UITextField *patientId;
@property (weak, nonatomic) IBOutlet UITextField  *patientLName;
@property NSString *pdfFileName;

- (void)start:(NSDictionary *)dict image:(UIImage*)img;
- (UIView *)loadTemplate:(NSString *)templateName;
- (NSMutableArray*)getPageBreaks:(int)numOfQuestions;
- (NSMutableArray*)getViews:(NSDictionary *)dict pageBreaksArray:(NSMutableArray *) pageBreaks image:(UIImage*)img;
- (UIView*)genView:(NSDictionary *)dict startQuestion:(int) startQ endQuestion:(int) endQ template:(NSString *)templateName image:(UIImage*)img;
- (void)savePNG:(UIView *)currTemplate fileName:(NSString *)fName;
- (NSString*)createPDFfromUIViews:(NSMutableArray*)arrayOfViews fileName:(NSString *)aFilename;
- (void)deletePdf:(NSString *)fileName;

@end
