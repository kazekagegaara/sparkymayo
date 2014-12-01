//
//  SurveyPageXMLHelper.h
//  Mayo-ipad
//
//  Created by Ashraf Gaffar on 11/15/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SurveyXMLHelper : NSObject <NSXMLParserDelegate>
- (NSMutableArray *) getLoadedQuestionOptionsList;
-(id)init;
@end
