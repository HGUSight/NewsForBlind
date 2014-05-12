//
//  FirstViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//
// love gim.


#import "MainNewsViewController.h"
#import "NewsArticleViewController.h"
#import "News.h"
#import "Fliter.h"
#import "HtmlParserclass.h"
#import "SetWrittingTime.h"
#import "SettingViewController.h"

@interface MainNewsViewController ()

@end

@implementation MainNewsViewController

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
@synthesize cell;
@synthesize controlFlag;

BOOL moveBack;
int tabState;
BOOL rememberFocus = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    controlFlag = 0;
    
    if(![checkString  isEqual: @"category"]) {
         urlstring = @"http://www.kyongbuk.co.kr/rss/headline.xml";
        moveBack = false;
        
    }else{
        urlstring=[urldata description];
        NSLog(@"url:%@",urldata);
        moveBack = true;
        
    }
    
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
    writetimeclass=[[SetWrittingTime alloc]init];

    imagecheck=true;
}

#pragma mark URLConnection delegate methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"Receive: %@, %@, %lld",
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
    receiveData=[[NSMutableData alloc]initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]];
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
		aNews.title=[NSMutableString stringWithString:[fliter settext:xmlValue]];
        
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
        
        NSMutableString *temp=[NSMutableString stringWithString:xmlValue];
        NSString * temp1=[NSString stringWithString:temp];
        aNews.pubData=[NSMutableString stringWithString:[writetimeclass setTime:temp1]];
        
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
    
}

#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    moveBack = false;
    rememberFocus = true;
    checkString = @"notCategory";
    if([[segue identifier]isEqualToString:@"TableIdentifier"])
    {
        
        NewsArticleViewController *viewController=[segue destinationViewController];
        NSIndexPath *currentIndexPath=[self.tableView indexPathForSelectedRow];
              
            News *buf=[[News alloc]init];
            buf=[newsdata objectAtIndex:currentIndexPath.row];
            NSString *data=buf.title;
            NSMutableString *data1=buf.description;
            NSMutableString *data2=buf.link;
            
            viewController.passData=data;
            viewController.passData1=data1;
            viewController.passData2=data2;
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return newsdata.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResuableCellWithIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
        News *buffer=[[News alloc]init];
        buffer=[newsdata objectAtIndex:indexPath.row];
        cell.textLabel.text=buffer.title;
        cell.detailTextLabel.text =buffer.pubData;
    
    return cell;
    
}
- (void)tableView:(UITableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.searchDisplayController.isActive) {
        [self performSegueWithIdentifier:@"TableIdentifier" sender:self];
    }
    
	[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"LastIndex"];
	
	[self selectTableViewCell:indexPath];
	
}
- (void)selectTableViewCell:(NSIndexPath*)indexPath
{
	@try {
		[self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
		 NSManagedObjectModel *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        
	}
	@catch (NSException * e) {
		
	}
	@finally {
        
	}
}
-(void)viewWillAppear:(BOOL)animated{
    
    if((tabState == 1 && [checkString  isEqual: @"category"] )|| (tabState == 2 && ![checkString  isEqual: @"category"] ))
        rememberFocus =false;
    
    if([checkString  isEqual: @"category"]){
        tabState = 2;
    } else
        tabState = 1;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /*
     set focus
    */
    NSInteger row = 0;

    if(![checkString  isEqual: @"category"]) {
        moveBack = false;
      
    }else{
        // if from category
        moveBack = true;
        rememberFocus = false;
    }
    if([checkString  isEqual: @"notCategory"])rememberFocus =true;
    
    //remember
    if(rememberFocus == true){
        row = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastIndex"];
    }
    
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    //coloring
    [self performSelector:@selector(selectTableViewCell:) withObject:indexPath afterDelay:0.1];
    
    // focusing
     UITableView *tableView = (UITableView *)[self view];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.cell);
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if(moveBack==true) {
        [self.navigationController popToRootViewControllerAnimated:animated];
    }
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}

@end
