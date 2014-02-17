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
@synthesize searchResult;
@synthesize searchbar;
@synthesize cell;
@synthesize controlFlag;


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
        checkString=[[NSMutableString alloc]init];
        urlstring=[[NSMutableString alloc]init];
        controlFlag = 0;
    
        checkString =[check description];
    
        if(![checkString  isEqual: @"category"]) {
    
            urlstring = @"http://www.kyongbuk.co.kr/rss/total.xml";
       
        }else{
            urlstring=[urldata description];
            NSLog(@"url:%@",urldata);
        
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
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:receiveData];
	
    [parser setDelegate:self];
	
    [parser parse];
	[parser release];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	
	[xmlConnection release];
	[receiveData release];
	
	UITableView *tableView = (UITableView *)[self view];
	[tableView reloadData];
}

#pragma mark XMLParse delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"item"])
		elementType = etItem;
       //NSLog(@"%@",etItem);
       //NSLog(@"%@",elementType);

	[xmlValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    
    
	if (elementType != etItem)
		return;
    
    

	if ([elementName isEqualToString:@"title"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
		aNews.title=[NSMutableString stringWithString:xmlValue];
        NSLog(@"xmlvalue:%@",xmlValue);
	} else if ([elementName isEqualToString:@"link"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
          aNews.link=[NSMutableString stringWithString:xmlValue];
        //[htmlparser sethtml:xmlValue];
        NSLog(@"link:%@",aNews.link);
       
        
    } else if ([elementName isEqualToString:@"description"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.description=[NSMutableString stringWithString:xmlValue];
        
	} else if ([elementName isEqualToString:@"category"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
        aNews.category=[NSMutableString stringWithString:xmlValue];
        NSLog(@"category%@",aNews.category);
        
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


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    if([[segue identifier]isEqualToString:@"TableIdentifier"])
    {
        controlFlag = 1;
        
        NewsArticleViewController *viewController=[segue destinationViewController];
        NSIndexPath *currentIndexPath=[self.tableView indexPathForSelectedRow];
        
        News *buf=[[News alloc]init];
        buf=[newsdata objectAtIndex:currentIndexPath.row];
        //buffer=newsdata[currentindex];
        NSString *data=buf.title;
        NSMutableString *data1=buf.description;
        NSMutableString *data2=buf.link;
        
        //[NSString stringWithFormat:@"Row %d has been selected",currentIndexPath.row];
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

    if (tableView==self.tableView) {
        
        return xmlParseData.count;
    
    }else {
        
        return searchResult.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResuableCellWithIdentifier";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
       News *buf=[[News alloc]init];
        buf=[searchResult objectAtIndex:indexPath.row];
        cell.textLabel.text=buf.title;
    }
    else {
        
        NSDictionary *dict = [xmlParseData objectAtIndex:indexPath.row];
        [[cell textLabel] setText:[dict objectForKey:@"title"]];
    }
    
      // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)TableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSInteger row = [[NSUserDefaults standardUserDefaults] integerForKey:@"LastIndex"];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    
    [self performSelector:@selector(selectTableViewCell:) withObject:indexPath afterDelay:0.1];
    
    UITableView *tableView = (UITableView *)[self view];
    cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.cell);
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
         if(controlFlag == 0)
             [self.navigationController popToRootViewControllerAnimated:animated];
            
}


@end
