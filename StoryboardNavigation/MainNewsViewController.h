//
//  FirstViewController.h
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@class Fliter;
@class HtmlParserclass;
@class SetWrittingTime;
@class SettingViewController;

typedef enum {
	etNone = 0,
	etItem
}eElementType;

@interface MainNewsViewController: UITableViewController<UISearchDisplayDelegate, UISearchBarDelegate,NSXMLParserDelegate> {
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
    SetWrittingTime * writetimeclass;
       
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
