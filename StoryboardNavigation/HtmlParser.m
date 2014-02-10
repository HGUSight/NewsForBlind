//
//  HtmlParser.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 6..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "HtmlParser.h"
#import "TFHpple.h"

@implementation HtmlParser
@synthesize articlebuf, linkhtmlurl;

-(void) sethtml:(NSMutableString *)htmllink {
   
    NSString *htmlWillInsert =[NSString stringWithContentsOfURL:
                               [NSURL URLWithString:htmllink] encoding:-214781280 error:nil];
    NSLog(@"html:%@",htmllink);
    NSData *htmlData=[htmlWillInsert dataUsingEncoding:NSUnicodeStringEncoding];
    if (htmlData != nil) {
        TFHpple *xpathParser = [[TFHpple alloc] initWithHTMLData:htmlData];
        NSArray *parserArray  = [xpathParser searchWithXPathQuery:@"//*"];
        for (int i = 0; i < [parserArray count]; i++) {
            TFHppleElement *element = [parserArray objectAtIndex:i];
            NSLog(@"%@", [element content]);
        }
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"연결 실패"
                                                        message:@"데이터를 가져올 수 없습니다."
                                                       delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil];
        [alert show];
    }
    NSLog(@"connectWebsiteEnd");
    
}


/*
-(NSMutableString *)getNewsarticle {
    

}
*/


@end
