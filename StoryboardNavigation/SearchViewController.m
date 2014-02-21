//
//  SearchViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 2014. 2. 21..
//  Copyright (c) 2014년 김사랑. All rights reserved.
//

#import "SearchViewController.h"
#import "NewsArticleViewController.h"
#import "News.h"
#import "Fliter.h"
#import "HtmlParserclass.h"

@interface SearchViewController ()

@end

@implementation SearchViewController
@synthesize xmlConnection;
@synthesize elementType;
@synthesize xmlValue;
@synthesize receiveData;
@synthesize xmlParseData;
@synthesize currectItem;
@synthesize newsdata;
@synthesize currentindex;
@synthesize textbuffer;
@synthesize urlstring;
@synthesize urldata;
@synthesize check;
@synthesize checkString;
@synthesize searchResult;
@synthesize searchbar;
@synthesize cell;
@synthesize controlFlag;
@synthesize titlelist;
@synthesize searchResultdetail;

BOOL moveBack;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    
    if(![checkString  isEqual: @"category"]) {
        urlstring = @"http://www.kyongbuk.co.kr/rss/total.xml";
        //urlstring =@"http://203.252.118.80/NewsForBlind/test/total.xml";
        //urlstring = @"http://myhome.chosun.com/rss/www_section_rss.xml";
        //urlstring = @"http://rss.joins.com/joins_news_list.xml";
        moveBack = false;
        
    }else{
        urlstring=[urldata description];
        NSLog(@"url:%@",urldata);
        moveBack = true;
        
    }
    
    [searchbar becomeFirstResponder];
    
    xmlConnection = [[NSURLConnection alloc]
					 initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlstring]]
					 delegate:self];
	
	if (xmlConnection == nil)
		NSLog(@"Connect error");
	else
		[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
    xmlParseData = [[NSMutableArray alloc] init];
    xmlValue = [[NSMutableString alloc] init];
    currectItem = [[NSMutableDictionary alloc] init];
    receiveData = [[NSMutableData alloc] init];
    newsdata = [[NSMutableArray alloc] init];
    aNews=[[News alloc]init];
    fliter=[[Fliter alloc]init];
    textbuffer=[[NSMutableString alloc]init];
    htmlparser=[[HtmlParserclass alloc]init];
    searchResult=[[NSMutableArray alloc]init];
    titlelist=[[NSMutableArray alloc]init];
    searchResultdetail=[[NSMutableArray alloc]init];

}

#pragma mark URLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Receive: %@, %@, %d",
		  [response URL],
		  [response MIMEType],
		  [response expectedContentLength]);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	NSLog(@"%@", [error localizedDescription]);
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSString *str = [[NSString alloc] initWithData:receiveData encoding:-2147481280];
    str = [str stringByReplacingOccurrencesOfString:@"euc-kr" withString:@"utf-8"];
    receiveData=[str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",str);
    
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receiveData];
	
    [parser setDelegate:self];
	[parser parse];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	UITableView *tableView = (UITableView *)[self view];
	[tableView reloadData];
}

#pragma mark XMLParse delegate methods
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"item"])
		elementType = etItem;
    
	[xmlValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
	if (elementType != etItem)
		return;
    
	if ([elementName isEqualToString:@"title"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
		aNews.title=[NSMutableString stringWithString:xmlValue];
        NSLog(@"TITLE:%@",aNews.title);
        [self.titlelist addObject:aNews.title];
        
	} else if ([elementName isEqualToString:@"link"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.link=[NSMutableString stringWithString:xmlValue];
        
    } else if ([elementName isEqualToString:@"description"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.description=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"category"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.category=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"pubDate"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.pubData=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"item"]) {
		[xmlParseData addObject:[NSDictionary dictionaryWithDictionary:currectItem]];
        [newsdata addObject:aNews];
        aNews = [[News alloc]init];
        
	}
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSMutableString *)string {
	if (elementType == etItem) {
        [xmlValue appendString:string];
	}
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
