//
//  SurveyPageXMLHelper.m
//  Mayo-ipad
//
//  Created by Ashraf Gaffar on 11/15/14.
//  Copyright (c) 2014 rishabh srivastava. All rights reserved.
//

#import "SurveyXMLHelper.h"
#import "QuestionAndOptions.h"

@interface SurveyXMLHelper()
@property QuestionAndOptions *currentQuestionBeingLoaded;
@property NSMutableString *currentElementValue;
@property NSMutableArray *questionsOptionsList;
@end

@implementation SurveyXMLHelper
-(id)init{
    self = [super init];
    self.questionsOptionsList = [[NSMutableArray alloc] init];
    BOOL success;
    NSXMLParser *xmlParser;
    NSString *pathFile = [[NSBundle mainBundle] bundlePath];
    NSString *path = [[NSString alloc] initWithString:[pathFile stringByAppendingPathComponent:@"QuestionOptions.xml"]];
    
    NSData *data = [[NSFileManager defaultManager] contentsAtPath:path];
    
    xmlParser = [[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:NO];
    success = [xmlParser parse]; // return value not used
    NSLog(@"%s", success? "true":"false");
    // if not successful, delegate is informed of error
    return self;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    //    element = elementName;
    
    if ([elementName isEqualToString:@"questionandoptions"]) {
        NSLog(@"inside didStartElement questionandoptions");
        self.currentQuestionBeingLoaded = [[QuestionAndOptions alloc] init];
        self.currentQuestionBeingLoaded.options = [[NSMutableArray alloc] init];
    }
    self.currentElementValue = nil;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(self.currentElementValue == nil)
        self.currentElementValue = [[NSMutableString alloc] init];
    [self.currentElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"questionandoptions"]) {
        NSLog(@"in question end tag %@", self.currentElementValue);
        [self.questionsOptionsList addObject:self.currentQuestionBeingLoaded];
    }
    if ([elementName isEqualToString:@"question"]) {
        NSLog(@"in question end tag: %@", self.currentElementValue);
        self.currentQuestionBeingLoaded.question = self.currentElementValue;
    }
    else if ([elementName isEqualToString:@"option"]) {
        NSLog(@"in option end tag: %@", self.currentElementValue);
        [self.currentQuestionBeingLoaded.options addObject:self.currentElementValue];
    }
    else if ([elementName isEqualToString:@"objective"]) {
        NSLog(@"in objective end tag: %@", self.currentElementValue);
        if( [self.currentElementValue caseInsensitiveCompare:@"no"] == NSOrderedSame){
            NSLog(@"in objective end tag inside if: %@", self.currentElementValue);
            self.currentQuestionBeingLoaded.objective = false;
        }
    }
    self.currentElementValue = nil;
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %i", [parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    //    errorParsing=YES;
}

- (NSMutableArray *) getLoadedQuestionOptionsList{
    return self.questionsOptionsList;
}
@end
