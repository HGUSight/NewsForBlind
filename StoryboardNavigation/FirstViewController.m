//
//  FirstViewController.m
//  StoryboardNavigation
//
//  Created by 김사랑 on 13. 12. 27..
//  Copyright (c) 2013년 김사랑. All rights reserved.
//
// love gim.


#import "FirstViewController.h"
#import "ViewController.h"
#import "News.h"
#import "Fliter.h"
#import "NowViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

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


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
       
        checkString=[[NSMutableString alloc]init];
        urlstring=[[NSMutableString alloc]init];
        nowviewctr=[[NowViewController alloc]init];
    
        checkString =[check description];
    
        if(![checkString  isEqual: @"category"]) {
    
            urlstring = @"http://myhome.chosun.com/rss/www_section_rss.xml";
       
        }else{
            urlstring=[urldata description];
            NSLog(@"url:%@",urldata);
        
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
       
	} else if ([elementName isEqualToString:@"link"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
          aNews.link=[NSMutableString stringWithString:xmlValue];
	
    } else if ([elementName isEqualToString:@"description"]) {
		[currectItem setValue:[NSString stringWithString:xmlValue] forKey:elementName];
         //textbuffer=[fliter settext:xmlValue];
         // aNews.description=[NSMutableString stringWithString:textbuffer];
        //textbuffer=[fliter settext:xmlValue];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [xmlParseData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ResuableCellWithIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	NSDictionary *dict = [xmlParseData objectAtIndex:indexPath.row];
	[[cell textLabel] setText:[dict objectForKey:@"title"]];
       
       
      // Configure the cell...
    
    return cell;
}
#pragma mark - Table view delegate

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"TableIdentifier"])
    {
        ViewController *viewController=[segue destinationViewController];
        NSIndexPath *currentIndexPath=[self.tableView indexPathForSelectedRow];
        
        News *buf=[[News alloc]init];
        buf=[newsdata objectAtIndex:currentIndexPath.row];
        //buffer=newsdata[currentindex];
        NSString *data=buf.title;
        NSMutableString *data1=buf.description;
        NSLog(@"%@",data);
        //[NSString stringWithFormat:@"Row %d has been selected",currentIndexPath.row];
        viewController.passData=data;
        viewController.passData1=data1;

    }
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if([checkString  isEqual: @"category"]) {
        if([nowviewctr.nowViewcontroller  isEqual: @"viewcontroller"]) {
          [self.navigationController popToRootViewControllerAnimated:animated];
        }
        
    }
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
