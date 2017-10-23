//
//  ChooseColor01.m
//  AllController
//
//  Created by ffcs on 12-10-30.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ChooseColor01.h"


@implementation ChooseColor01
//**************************************************************************************************************
#define ALPHA @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#define ALPHA_ARRAY [NSArray arrayWithObjects: @"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", nil]

- (UIColor *) getColor: (NSString *) hexColor
{
	unsigned int red, green, blue;
	NSRange range;
	range.length = 2;
	
	range.location = 0; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
	range.location = 2; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
	range.location = 4; 
	[[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];	
	
	return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [NSString stringWithFormat:@"Crayon names starting with '%@'",[ALPHA_ARRAY objectAtIndex:section]];
}


-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return ALPHA_ARRAY;
}
//**************************************************************************************************************

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
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//**************************************************************************************************************
- (void) deselect
{	
	[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

// Build a section/row list from the alphabetically ordered word list
- (void) createSectionList: (id) wordArray
{
	// Build an array with 26 sub-array sections
	sectionArray = [[NSMutableArray alloc] init];
	for (int i = 0; i < 26; i++){
        [sectionArray addObject:[[NSMutableArray alloc] init]];
    }
	
	// Add each word to its alphabetical section
	for (NSString *word in wordArray)
	{
		if ([word length] == 0) continue;
		
		// determine which letter starts the name
		NSRange range = [ALPHA rangeOfString:[[word substringToIndex:1] uppercaseString]];
		
		// Add the name to the proper array
		[[sectionArray objectAtIndex:range.location] addObject:word];
	}
}
//**************************************************************************************************************

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.title = @"颜色选择";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //**************************************************************************************************************
    // Retrieve the text and colors from file
	NSString *pathname = [[NSBundle mainBundle]  pathForResource:@"crayons" ofType:@"txt" inDirectory:@"/"];
	NSString *wordstring = [NSString stringWithContentsOfFile:pathname
                                                     encoding:NSUTF8StringEncoding
                                                        error:NULL]; //从一个文件中读取字符串，编码后将其值赋值给字符串
    NSArray *wordArray = [wordstring componentsSeparatedByString:@"\n"];
    [self createSectionList:wordArray];
    //**************************************************************************************************************
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
//    return 0;
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
//    return 0;
    return [[sectionArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*      效果1
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        
    }
    
    // Configure the cell...
    
    NSInteger row = [indexPath row];
	NSInteger section = [indexPath section];
    NSArray *crayon = [[[sectionArray objectAtIndex:section] objectAtIndex:row] componentsSeparatedByString:@"#"];
	cell.textLabel.text = [crayon objectAtIndex:0];
	cell.textLabel.textColor = [self getColor:[crayon objectAtIndex:1]];
    */
    //************************************************************************************************************//
    
    
    //************************************************************************************************************//
//    /*    效果2
    UILabel *cellTextLabelView = NULL;
    UIView *cellBgcolorUIView = NULL;
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
		
		// Tag the background view
		[[[cell subviews] objectAtIndex:0] setTag:111];
		// Add and tag the label view
		cellTextLabelView = [[UILabel alloc] initWithFrame: CGRectMake(30, 0, 300, 44)];   //注意以Group类型的表视图时，Cell的text的位置origin.x不要从0开始
		[cellTextLabelView setBackgroundColor:[UIColor clearColor]];
		[cellTextLabelView setShadowColor:[UIColor whiteColor]];
		[cellTextLabelView setFont:[UIFont boldSystemFontOfSize:20]];
		[cellTextLabelView setTag:222];
		[cell addSubview:cellTextLabelView];
    }
    
    // Configure the cell...
    NSInteger row = [indexPath row];
	NSInteger section = [indexPath section];
    NSArray *crayon = [[[sectionArray objectAtIndex:section] objectAtIndex:row] componentsSeparatedByString:@"#"];
    //设置Cell的文本内容  recover labelView from the cell
	cellTextLabelView = (UILabel *)[cell viewWithTag:222];
	[cellTextLabelView setText:[crayon objectAtIndex:0]];
	//设置Cell的文本背景  recover the background
	cellBgcolorUIView = [cell viewWithTag:111];
	[cellBgcolorUIView setBackgroundColor:[self getColor:[crayon objectAtIndex:1]]];
//     */
    //**************************************************************************************************************
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
     [detailViewController release];
     */
    //**************************************************************************************************************
    // Retrieve named color
	NSInteger row = [indexPath row];
	NSInteger section = [indexPath section];
	NSArray *crayon = [[[sectionArray objectAtIndex:section] objectAtIndex:row] componentsSeparatedByString:@"#"];
	
	// Update the nav bar color
	self.navigationController.navigationBar.tintColor = [self getColor:[crayon objectAtIndex:1]];
	
	// Deselect
	[self performSelector:@selector(deselect) withObject:NULL afterDelay:0.5];
    //**************************************************************************************************************
}

@end
