//
//  XmlParser.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 21..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import <Foundation/Foundation.h>

@class News;
@class Fliter;
@class HtmlParserclass;



typedef enum {
	etNone = 0,
	etItem
}eElementType;


@interface XmlParser : NSObject {
    NSURLConnection *xmlConnection;
	eElementType elementType;
	NSMutableString *xmlValue;
	NSMutableData *receiveData;
	NSMutableArray *xmlParseData;
	NSMutableDictionary *currectItem;
    NSMutableArray *newsdata;
    News *aNews;
    NSIndexPath *currentindex;
    NSMutableString *textbuffer;
    Fliter *fliter;
    NSString *urlstring;
    NSString *checkString;
    HtmlParserclass *htmlparser;
    UITableViewCell *cell;
    int controlFlag;

}
@property (nonatomic, retain)NSURLConnection *xmlConnection;
@property (nonatomic)eElementType elementType;
@property (nonatomic, retain)NSMutableString *xmlValue;
@property (nonatomic, retain)NSMutableData *receiveData;
@property (nonatomic, retain)NSMutableArray *xmlParseData;
@property (nonatomic, retain)NSMutableDictionary *currectItem;
@property (nonatomic, retain)NSMutableArray *newsdata;
@property (nonatomic) NSIndexPath *currentindex;
@property (nonatomic, retain) NSMutableString *textbuffer;
@property (nonatomic,retain) NSString *urlstring;
@property (nonatomic,retain) NSString *checkString;
@property (strong, nonatomic)id urldata;
@property (strong, nonatomic)id check;
@property (nonatomic, retain)UITableViewCell *cell;
@property (nonatomic)int controlFlag;



@end
