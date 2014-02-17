//
//  HtmlParser.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 6..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "HtmlParserclass.h"
#import "HTMLNode.h"
#import "HTMLParser.h"
#import "Fliter.h"


@implementation HtmlParserclass
@synthesize str,newstext;

-(NSString*) sethtml:(NSMutableString *)htmllink {
    
    fliter=[[Fliter alloc]init];
    
    NSError *error = nil;
   
    NSString *htmlWillInsert =[NSString stringWithContentsOfURL:
                               [NSURL URLWithString:htmllink] encoding:-2147481280 error:nil];
    
    HTMLParser *parser = [[HTMLParser alloc] initWithString:htmlWillInsert error:&error];
    
    if (nil) {
        NSLog(@"Error: %@", error);
    }
    
    HTMLNode *bodyNode = [parser body];
    
    NSArray *divNodes = [bodyNode findChildTags:@"div"];
    
    for (HTMLNode *divNode in divNodes) {
        if ([[divNode getAttributeNamed:@"id"] isEqualToString:@"news_text"]) {
            NSLog(@"data:%@", [divNode  rawContents]); //Answer to second question
            str =[NSMutableString stringWithString:[divNode rawContents]];
        }
        
    }
    
    NSMutableString *newstext =[NSMutableString stringWithString:[fliter settext:str]];
    NSLog(@"newsdata:%@", newstext);
    
    return newstext;

 
   
    /*
    NSArray *inputNodes = [bodyNode findChildTags:@"input"];
    
    for (HTMLNode *inputNode in inputNodes) {
        if ([[inputNode getAttributeNamed:@"name"] isEqualToString:@"input2"]) {
            NSLog(@"%@", [inputNode getAttributeNamed:@"value"]); //Answer to first question
        }
    }
    
    NSArray *spanNodes = [bodyNode findChildTags:@"span"];
    
    for (HTMLNode *spanNode in spanNodes) {
        if ([[spanNode getAttributeNamed:@"class"] isEqualToString:@"spantext"]) {
            NSLog(@"%@", [spanNode rawContents]); //Answer to second question
        }
    }
*/
    
    
}


/*
-(NSMutableString *)getNewsarticle {
    

}
*/


@end
