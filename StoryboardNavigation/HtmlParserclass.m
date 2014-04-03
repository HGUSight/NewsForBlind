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

int count;

@implementation HtmlParserclass
@synthesize str,newstext, str1, str2;
@synthesize text, text1;
@synthesize stringobject;

-(NSString*) sethtml:(NSMutableString *)htmllink {
    
    count=0;
    fliter=[[Fliter alloc]init];
    stringobject=[[NSMutableArray alloc]init];
    newstext=[[NSMutableString alloc]init];
    
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
           
            str =[NSMutableString stringWithString:[divNode rawContents]];
            
        }else if([[divNode getAttributeNamed:@"class"] isEqualToString:@"news_photo"]) {
            
            if([NSMutableString stringWithString:[divNode rawContents]]!=nil) {
                
                str2 =[NSMutableString stringWithString:[divNode rawContents]];
            }
            
        }

    }
    
    for(int i = 0; i < [str length]; i++) {
       
        
        if(str2!=NULL) {
            
            text1= [str rangeOfString:str2];
       
        }
        
        if(text1.location != NSNotFound) {
            
            [str deleteCharactersInRange:text1];
           
            
        }else {
            
            break;
        }
        
    }
    
    newstext =[NSMutableString stringWithString:[fliter settext:str]];
    
    
    return newstext;

}



@end
