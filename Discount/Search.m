//
//  Search.m
//  Discount
//
//  Created by Sajith KG on 21/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "Search.h"
#import "ProfileCell.h"
#import "AppDelegate.h"
#import "DiscountDetail.h"
#import "DiscountViewController.h"
#import "DiscountNow.h"

@class DiscountNow;

@interface Search () {

    NSMutableArray *itemsArray,*namesArray,*locationArray;
    BOOL isNameSelected,isLocationSelected;
}

@end

@implementation Search

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.listTable.backgroundColor = RGB(244, 243, 237);
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.cancelBtn.titleLabel.font =LATO_REGULAR(16);
    
    self.listTable.backgroundColor = DETAIL_BG_COLOR;
    
    self.searchBtn.titleLabel.font =LATO_BOLD(18);
    
    [[LocationSearchBar appearance] setImage:[UIImage imageNamed:@"search_location.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setFont:LATO_REGULAR(13)];
    
    [[UISearchBar appearance] setTintColor:[UIColor grayColor]];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitleTextAttributes:@{NSFontAttributeName:LATO_REGULAR(15)} forState:UIControlStateNormal];
    
    locationArray = [[NSMutableArray alloc] initWithObjects:@"Current Location",@"New York",@"Los Angeles",@"Chicago",@"Phoenix",@"San Antonio",@"Austin",@"San Francisco",@"Washington",@"Atlanta",@"Miami",nil];
    
    namesArray = [[NSMutableArray alloc] initWithObjects:@"Restaurants",@"Sushi",@"Sports Bar",@"Car Battery",@"Hotels",@"Antiques",@"Dry Cleaning",@"Spa",nil];

    itemsArray = [[NSMutableArray alloc] initWithObjects:@"Item 1",@"Item 2",@"Item 3",@"Item 4",@"Item 5",@"Item 6",@"Item 7",nil];
    
    [self.listTable registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil]
       forCellReuseIdentifier:@"ProfileCell"];
    
    self.searchBar.placeholder = @"Keyword, Business Name, or Title";
    self.locationSearchBar.placeholder = @"Location";
    
    [self.listTable reloadData];
    
//    for (id subview in [self.searchBar subviews]) {
//        DLog(@"subview=%@",subview);
//    }
}

#pragma mark - IBAction

- (IBAction) cancelBtnCall {

    self.searchBar.text=@"";
    self.locationSearchBar.text=@"";
    [self.view endEditing:YES];
    
    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    
    UIView * fromView = self.view;
    UIView * toView = [[self.tabBarController.viewControllers objectAtIndex:2] view];
    
    // Transition using a page curl.
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.3
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    completion:^(BOOL finished) {
                        if (finished) {
                            [discountViewController changeSelectedTab:2];
                            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                        }
                    }];
}

- (IBAction) searchBtnCall {
    
    if (![self.searchBar.text length] && ![self.locationSearchBar.text length]) {
        [Global showAlertWithMessage:@"Search fields should not be empty"];
        return;
    }
    
    DiscountNow *discountNow = MY_APP_DELEGATE.discountViewController.discountNow;
    [discountNow reloadDataWithSearchQueries:@{@"searchKey": self.searchBar.text,@"location": self.locationSearchBar.text}];
    
    [self cancelBtnCall];
}

#pragma mark - UISearchBar

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    return YES;
 }

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    isNameSelected = (self.searchBar == searchBar);
    isLocationSelected = (self.locationSearchBar == searchBar);
    [self.listTable reloadData];
    
//    DLog(@"%@",searchBar);
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    isNameSelected=NO;
    isLocationSelected=NO;
    [self.listTable reloadData];
    
//    DLog(@"%@",searchBar);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    //searchBar.text=@"";
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar {

    searchBar.text=@"";
    [self.view endEditing:YES];
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (isLocationSelected)
        return [locationArray count];
    
    else if (isNameSelected)
        return [namesArray count];
    
    else
        return [itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCell *cell = (ProfileCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.itemTitleLbl.textColor = [UIColor whiteColor];
    cell.arrowImg.hidden=YES;
    
    
    if (isLocationSelected) {
        cell.itemTitleLbl.text = [locationArray objectAtIndex:indexPath.row];
        
        if (indexPath.row==0) {
            cell.itemTitleLbl.textColor = RGB(7, 0, 231);
        }
    }
    
    else if (isNameSelected) {
        cell.itemTitleLbl.text = [namesArray objectAtIndex:indexPath.row];
    }
    
    else {
        cell.itemTitleLbl.text = [itemsArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (isLocationSelected)
        self.locationSearchBar.text=[locationArray objectAtIndex:indexPath.row];
    
    else if (isNameSelected)
        self.searchBar.text=[namesArray objectAtIndex:indexPath.row];
    
    else
        [MY_APP_DELEGATE showDevelopmentMessage];
    
    [self.view endEditing:YES];
}



@end
