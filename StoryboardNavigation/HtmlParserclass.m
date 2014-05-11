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
#import "NewsArticleViewController.h"

int count;

@implementation HtmlParserclass
@synthesize photo;
@synthesize str,newstext, str1, str2,newsdate,newswriter,photourl;
@synthesize text, text1;
@synthesize stringobject;

-(NSString*) sethtml:(NSMutableString *)htmllink {
    
    count=0;
    fliter=[[Fliter alloc]init];
    stringobject=[[NSMutableArray alloc]init];
    newstext=[[NSMutableString alloc]init];
    articleController=[[NewsArticleViewController alloc]init];
    
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
            
        }else if([[divNode getAttributeNamed:@"class"] isEqualToString:@"title_days"]) {
            
            if([NSMutableString stringWithString:[divNode rawContents]]!=nil) {
                
                newsdate =[NSMutableString stringWithString:[divNode rawContents]];
                newsdate =[NSMutableString stringWithString:[fliter settext:newsdate]];
                
            }
        
        }else if([[divNode getAttributeNamed:@"class"] isEqualToString:@"writer"]) {
            
            if([NSMutableString stringWithString:[divNode rawContents]]!=nil) {
            
                newswriter =[NSMutableString stringWithString:[divNode rawContents]];
                newswriter =[NSMutableString stringWithString:[fliter settext:newswriter]];
                
            }
            
        }else if([[divNode getAttributeNamed:@"id"] isEqualToString:@"photoimg"]) {
            
            if([NSMutableString stringWithString:[divNode rawContents]]!=nil) {

                photourl =[NSMutableString stringWithString:[divNode rawContents]];
                photo = [photourl substringFromIndex:29];
                photo = [photo substringToIndex:62];
                articleController.photourl=photo;
                
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
    NSString *stringWithBalnk =[newstext substringFromIndex:(0)];
    int position = 0;
   
    NSRange blankRange;
    blankRange.length = position+1;
    blankRange.location = position;

    unichar charAtPos;
    
    // delete empty lines
    do {
        charAtPos = [stringWithBalnk characterAtIndex:position];
        stringWithBalnk = [stringWithBalnk substringFromIndex:(position+1)];
    }while(charAtPos == '\n' || charAtPos =='\r');
    [newstext setString:stringWithBalnk];
    
    // add data, writer
    if (newsdate!=NULL) {
        [newstext appendString:newsdate];
    }
    [newstext appendString:@"\n"];
    if (newswriter!=NULL) {
        [newstext appendString:newswriter];
    }
    NSLog(newstext);
    return newstext;
}
-(NSString*)getphotourl {
    
    return photo;
    
}


@end
