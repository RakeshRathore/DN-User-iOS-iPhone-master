//
//  SavedDiscount.m
//  Discount
//
//  Created by Sajith KG on 23/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "SavedDiscount.h"
#import "ListCell.h"
#import "AppDelegate.h"
#import "DiscountDetail.h"
#import "DiscountViewController.h"
#import "DiscountNow.h"
#import "UIImage+customColor.h"
#import "Redeem.h"

@interface SavedDiscount (){
    
    ThankYou *thankyou;
    
    NSMutableArray *itemsArray;
    DiscountViewController *discountViewController;
    ScrollDirection scrollDirection;
    
    NSArray *dummyArray;
    NSDictionary *dict1,*dict2,*dict3,*dict4,*dict5;
    
    NSString *sortingSelected;
}


@end

@implementation SavedDiscount

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

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    [discountViewController hideLeftButton:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    self.listTable.backgroundColor = VIEW_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    
    self.titleLbl.font = LATO_REGULAR(18);
    
    self.nearbyBtn.titleLabel.font = LATO_REGULAR(16);
    [self.nearbyBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    self.myDiscountBtn.titleLabel.font = LATO_REGULAR(16);
    [self.myDiscountBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    self.AtoZbtn.titleLabel.font = LATO_REGULAR(16);
    [self.AtoZbtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    self.lightningBtn.titleLabel.font = LATO_REGULAR(16);
    [self.lightningBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    sortingSelected = @"My Discounts";

    
    NSArray *keysArray = @[@"discountTitle",@"discountPrice",@"originalPrice",@"percentageSavings",@"companyName",@"Expiration",@"whatsIncluded",@"storeID",@"address",@"city",@"state",@"zip",@"phoneNo",@"imageURL",@"latitude",@"longitude",@"pinType",@"youtube_link",@"categoryIcon",@"description"];
    
    NSArray *valueArray1 = @[@"Half off Ribs Month",@"10",@"22.50",@"56%",@"Voodoo BBQ",@"3 Days",@"For one month, we will be featuring our Award Winning Ribs and BBQ sauce at 50% off. Why? Because you just need to try them. Come in at any location and 'Grab a Slab' today, bring some home, just keep eating. BYOB",@"9987553",@"415 N Sangamon",@"Chicago",@"IL",@"60642",@"(401) 228-7373",@"Burger.jpg",@"41.6265",@"-87.3650",@"map_pin_hotel.png",@"https://www.youtube.com/watch?v=TBewVCJnhts",@"menu_restaurent.png",@"Our meats are dry rubbed with amazing Cajun spices and slow-smoked to perfection with oak and pecan, not swimming in sauce. Want an extra kick? We’ve created three unique BBQ sauces made with Louisiana ingredients. Then we pile on the homemade signature sides and pour you a sweet tea or Louisiana’s famous Abita Beer, each one with a decidedly southern drawl. Taste the magic of VooDoo BBQ & Grill."];
    
    NSArray *valueArray2 =  @[@"Summer Family Fun Special",@"999",@"1500",@"33%",@"Caldera Resorts",@"5 Days ",@"The first 100 people to Cash In this offer will receive a 33% discount for your family to stay at the luxurious Caldera Resort and Spa. We offer 24 hour room service, 3 pools, and snorkel tours. DIB today and come enjoy the sun with us.",@"6213479",@"1648 W Oneterio",@"Chicago",@"IL",@"60651",@"(312) 875-9696",@"beach.jpg",@"41.6255",@"-87.8040",@"map_pin_hotel.png",@"https://www.youtube.com/watch?v=cY-LtBrFrmk",@"menu_travel.png",@"Caldera Springs is the next generation of the rich Sunriver legacy. Outdoors, nearly nine miles of walking, jogging and biking trails wind their way through 400 acres of forests and meadows with plenty of opportunities to discover nature in your own backyard. Refreshing lakes and flowing streams sparkle throughout Caldera Springs, which are a big part of what makes living here so inviting. There are plenty of adventures both on and off shore.We would like to introduce ourselves to all our new neighbors and friends! Molly Green Boutique is excited to now be located in the Riverchase Galleria Mall. We so enjoyed our time in Homewood and we’re just as happy to be in our new home in Hoover! Molly Green is locally owned and run by Bluff Park native sisters-Brittany Hartwell and Anna Miller. Molly Green reflects their funky fresh and easy going styles."];
    
    NSArray *valueArray3 = @[@"Summer Dress Fashion",@"38",@"76",@"50%",@"Molly Green",@"6 Days",@"Summer is here! We know you want to spruce up your closet. At Molley Green we are offering a Buy One Get One on our new designers top styles. Come to our Location on Madison Ave and see what we have in store. ",@"6458887",@"2419 W. Madison St.",@"Chicago",@"IL",@"60612",@"(773) 227-5300",@"store-interior.jpg",@"41.6355",@"-87.2740",@"map_pin_coffee.png",@"https://www.youtube.com/watch?v=9QU7M0MUR3c",@"menu_events.png",@"We would like to introduce ourselves to all our new neighbors and friends! Molly Green Boutique is excited to now be located in the Riverchase Galleria Mall. We so enjoyed our time in Homewood and we’re just as happy to be in our new home in Hoover! Molly Green is locally owned and run by Bluff Park native sisters-Brittany Hartwell and Anna Miller. Molly Green reflects their funky fresh and easy going styles."];
    
    NSArray *valueArray4 = @[@"Speedy Oil Change ",@"300",@"500",@"60%",@"Midwest Motors ",@"3 Days",@"The time is near, Winter is here come on down to Motors and get a Speedy Oil Change. ",@"2231588",@"2553 W Chicago Ave",@"Chicago",@"IL",@"60622",@"(773) 235-6500",@"mechanic.jpg",@"41.5255",@"-87.3740",@"map_pin_beer.png",@"http://www.youtube.com/v/impZ7krcPzI",@"menu_automative.png",@"Midwest Motors has the most reliable mechanics this side of Chicago!"];
    
    NSArray *valueArray5 = @[@"A Pig on Every Grill",@"25",@"35",@"71%",@"Slab Of Ribs",@"7 Days",@"Slab of Ribs will be hosting the biggest all you can each barbecue week. If you can eat what \"WE\" put on your plate your meal is on us.",@"2155479",@"1470 East Touhy Avenue",@"Des Planies",@"IL",@"60016",@"(847) 391-9860",@"BBQ.jpg",@"41.6075",@"-87.6750",@"map_pin_beer.png",@"http://www.youtube.com/v/zL0CCsdS1cE",@"menu_entertainment.png",@"Delicious barbeques everyday at Slab of Ribs!"];
    
    dict1 = [NSDictionary dictionaryWithObjects:valueArray1 forKeys:keysArray];
    dict2 = [NSDictionary dictionaryWithObjects:valueArray2 forKeys:keysArray];
    dict3 = [NSDictionary dictionaryWithObjects:valueArray3 forKeys:keysArray];
    dict4 = [NSDictionary dictionaryWithObjects:valueArray4 forKeys:keysArray];
    dict5 = [NSDictionary dictionaryWithObjects:valueArray5 forKeys:keysArray];
    
    itemsArray = [[NSMutableArray alloc] initWithObjects:dict5,dict4,dict3,dict2,dict1,nil];
    
    dummyArray = @[dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5];
    [itemsArray addObjectsFromArray:dummyArray];
    
    [self.listTable registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil]
         forCellReuseIdentifier:@"ListCell"];
    
    [self.listTable reloadData];
    
    [self.view bringSubviewToFront:self.sortBGView];
    self.sortBGView.alpha = 0.0;
    [self.view bringSubviewToFront:self.sortView];
    
    [self.view bringSubviewToFront:self.topbarView];
    
    self.sortView.frame = CGRectMake(self.sortView.frame.origin.x, -106, self.sortView.frame.size.width, self.sortView.frame.size.height);
    self.sortView.hidden = YES;
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapGestureRecognizer addTarget:self action:@selector(hideSortView)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [self.sortBGView addGestureRecognizer:tapGestureRecognizer];
    
    discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    
}

- (void) showThankYouPage:(NSDictionary*) dict {
    
    if (thankyou.view.superview!=nil) {
        [thankyou.view removeFromSuperview];
    }
    
    //[MY_APP_DELEGATE.discountViewController showBackButton:NO];

    thankyou = [[ThankYou alloc] init];
    thankyou.currentItem = dict;
    
    [self.view addSubview:thankyou.view];
    [thankyou resetContent];
    thankyou.view.alpha = 0;
    
    [thankyou.cancelBtn addTarget:self action:@selector(hideThankYouPage) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] init];
    [tapGestureRecognizer addTarget:self action:@selector(hideThankYouPage)];
    [tapGestureRecognizer setNumberOfTapsRequired:1];
    [thankyou.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.delegate=self;
    
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^ {
                        thankyou.view.alpha = 1;
                    }
                    completion:nil];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    return !(CGRectContainsPoint(thankyou.popView.bounds, [touch locationInView:thankyou.popView]));
}

- (void) hideThankYouPage {
    
    if (thankyou.view.superview==nil) {
        return;
    }
    
    [UIView transitionWithView:self.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionNone
                    animations:^ {
                        thankyou.view.alpha = 0;
                    }
                    completion:^(BOOL yes){
                    
                        [thankyou.view removeFromSuperview];
                    }];

}


#pragma mark -
#pragma mark Sorting

- (IBAction)sortBtnCall:(id)sender {
    
    [self hideThankYouPage];
    
    UIButton *btn = (UIButton*)sender;
    
    if (btn.isSelected) { // Hide
        
        [self hideSortView];
        
    }else {  //Show
        
        self.sortView.hidden = NO;
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:0.3];
        
        self.sortBGView.alpha = 0.5;
        

        
        self.sortView.frame = CGRectMake(self.sortView.frame.origin.x, 64, self.sortView.frame.size.width, self.sortView.frame.size.height);
        
        [UIView commitAnimations];
        
        [self.sortBtn setSelected:YES];
    }
}

- (void) animateDone {
    
    self.sortView.hidden = !self.sortBtn.isSelected;
    
}

- (void) hideSortView {
    
    [UIView beginAnimations:@"animateTableView" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animateDone)];
    
    self.sortBGView.alpha = 0.0;
    

    
    self.sortView.frame = CGRectMake(self.sortView.frame.origin.x, -106, self.sortView.frame.size.width, self.sortView.frame.size.height);
    
    [UIView commitAnimations];
    
    [self.sortBtn setSelected:NO];
    
}

- (IBAction)selectedSortingOption:(UIButton*)sender {
    
    [self hideSortView];
    [itemsArray removeAllObjects];
    
    NSArray *tempAry;
    
    switch (sender.tag) {
        case 1:
            tempAry = @[dict1,dict2,dict3,dict4,dict5];
            sortingSelected = @"My Discounts";
            break;
        case 2:
            tempAry = @[dict4,dict3,dict1,dict2,dict5];
            sortingSelected = @"Nearby";
            break;
        case 3:
            tempAry = @[dict5,dict1,dict3,dict2,dict4];
            sortingSelected = @"A-Z";
            break;
        case 4:
            tempAry = @[dict2,dict1,dict5,dict3,dict4];
            sortingSelected = @"Lightning";
            break;
            
        default:
            break;
    }
    
    [itemsArray addObjectsFromArray:tempAry];
    [itemsArray addObjectsFromArray:dummyArray];
    
    [self.listTable reloadData];
    [self.listTable scrollRectToVisible:CGRectMake(0, 0, 320, 50) animated:YES];
    
}

#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *title = [[UILabel alloc] init];
    title.text=sortingSelected;
    title.font = LATO_BOLD(14);
    title.backgroundColor = [UIColor grayColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;
    
    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    
    [cell.optionBtn setTag:indexPath.row];
    [cell.favoriteBtn setTag:indexPath.row];
    [cell.captureBtn setTag:indexPath.row];
    [cell.mapBtn setTag:indexPath.row];
    [cell.shareBtn setTag:indexPath.row];
    
    [cell.optionBtn addTarget:self action:@selector(showHideOptionView:) forControlEvents:UIControlEventTouchUpInside];
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shareBtn addTarget:self action:@selector(shareBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mapBtn addTarget:self action:@selector(mapBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.captureBtn addTarget:self action:@selector(redeemBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.selected=NO;
    
    [cell.captureBtn setTitle:@"Cash It In!" forState:0];
    
    NSDictionary *currentDict=[itemsArray objectAtIndex:indexPath.row];
    
//    cell.itemTitleLbl.text = [currentDict objectForKey:@"discountTitle"];
//    cell.daysLbl.text = [currentDict objectForKey:@"Expiration"];
//    cell.priceLbl.text = [NSString stringWithFormat:@"$%@",[currentDict objectForKey:@"discountPrice"]];
//    cell.itemDesLbl.text = [NSString stringWithFormat:@"$%@ for $%@ %@ off at %@",[currentDict objectForKey:@"discountPrice"],[currentDict objectForKey:@"originalPrice"],[currentDict objectForKey:@"percentageSavings"],[currentDict objectForKey:@"companyName"]];
//    [cell.itemPic setImage:[UIImage imageNamed:[currentDict objectForKey:@"imageURL"]]];
    
    cell.daysLbl.text = [currentDict objectForKey:@"Expiration"];
    cell.priceLbl.text = [NSString stringWithFormat:@"$%@",[currentDict objectForKey:@"discountPrice"]];
    
    [cell.itemPic setImage:[UIImage imageNamed:[currentDict objectForKey:@"imageURL"]]];
    
    [cell.categoryPic setImage:[[UIImage imageNamed:[currentDict objectForKey:@"categoryIcon"]] imageWithOverlayColor:[UIColor whiteColor]]];
    
    cell.itemTitleLbl.text = [currentDict objectForKey:@"discountTitle"];
    cell.itemDesLbl.text = [NSString stringWithFormat:@"$%@ for $%@ \n%@ off at %@",[currentDict objectForKey:@"discountPrice"],[currentDict objectForKey:@"originalPrice"],[currentDict objectForKey:@"percentageSavings"],[currentDict objectForKey:@"companyName"]];
    
    cell.itemTitleLbl.hidden=YES;
    cell.itemDesLbl.hidden=YES;
    cell.dibbImg.hidden = NO;
    
    if (tableView.decelerating) {
        
        //temp
        cell.itemTitleLbl.hidden=NO;
        cell.itemDesLbl.hidden=NO;
        
        CGFloat animate;
        
        if (scrollDirection==ScrollDirectionDown)
            animate=50;
        else
            animate=-50;
        
        CGRect itemTitleLblFrame = cell.itemTitleLbl.frame;
        CGRect startFrame = CGRectMake(cell.itemTitleLbl.frame.origin.x, cell.itemTitleLbl.frame.origin.y+animate, cell.itemTitleLbl.frame.size.width, cell.itemTitleLbl.frame.size.height);
        
        [cell.itemTitleLbl setFrame:startFrame];
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:self.listTable.decelerationRate];
        [cell.itemTitleLbl setFrame:itemTitleLblFrame];
        [UIView commitAnimations];
        
        CGRect itemDesLblFrame = cell.itemDesLbl.frame;
        CGRect startFrame1 = CGRectMake(cell.itemDesLbl.frame.origin.x, cell.itemDesLbl.frame.origin.y+animate, cell.itemDesLbl.frame.size.width, cell.itemDesLbl.frame.size.height);
        
        [cell.itemDesLbl setFrame:startFrame1];
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:self.listTable.decelerationRate];
        [cell.itemDesLbl setFrame:itemDesLblFrame];
        [UIView commitAnimations];
    }else {
        cell.itemTitleLbl.hidden=NO;
        cell.itemDesLbl.hidden=NO;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self showDiscountDetails];
   
}

#pragma mark Detail View

- (void) showDiscountDetails {
    
    int selectedRow = (int)[self.listTable indexPathForSelectedRow].row;
    
    [discountViewController showBackButton:YES];
    DiscountDetail *discountDetail = [[DiscountDetail alloc] init];
    [discountDetail setCurrentItem:[itemsArray objectAtIndex:selectedRow]];
    discountDetail.isSavedDeal=YES;
    discountDetail.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:discountDetail animated:YES];
    
    [self.listTable deselectRowAtIndexPath:[self.listTable indexPathForSelectedRow] animated:NO];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // DLog(@"scrollView %@",scrollView);
    
    if (self.lastContentOffset < scrollView.contentOffset.y)
        scrollDirection = ScrollDirectionDown;
    else
        scrollDirection = ScrollDirectionUp;
    
    self.lastContentOffset = scrollView.contentOffset.y;
}

#pragma mark -
#pragma mark Option View

- (void) showHideOptionView:(UIButton*) sender {
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    if ([[self.listTable indexPathForSelectedRow] isEqual:currentIndexPath]) {
        [self.listTable deselectRowAtIndexPath:currentIndexPath animated:YES];
    }else {
        [self.listTable selectRowAtIndexPath:currentIndexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

#pragma mark  Favorite

- (void) favoriteBtnCall:(UIButton*) sender {
    
    NSIndexPath *currentIndexPath = [NSIndexPath indexPathForRow:sender.tag inSection:0];
    
    ListCell *listCell = (ListCell*)[self.listTable cellForRowAtIndexPath:currentIndexPath];
    
    [listCell toggleFavoriteButton];
}

#pragma mark  Share

- (void) shareBtnCall:(UIButton*) sender {
    
    NSDictionary *currentItem = [itemsArray objectAtIndex:sender.tag];
    
    [[SocialKit sharedSocialKit] setMessage:[NSString stringWithFormat:@"Check this %@",[currentItem objectForKey:@"discountTitle"]]];
    [[SocialKit sharedSocialKit] setUrlStr:@"http://acapellaglobal.com/clients/Discount_Now_Admin/admin/index.html"];
    [[SocialKit sharedSocialKit] ShowShareOptions];
}

#pragma mark  Capture

- (void) redeemBtnCall:(UIButton*) sender
{
    [self.listTable deselectRowAtIndexPath:[self.listTable indexPathForSelectedRow] animated:YES];
    
    Redeem *redeemVC = [[Redeem alloc] init];
    UINavigationController *redeemNavi = [[UINavigationController alloc] initWithRootViewController:redeemVC];
    redeemNavi.navigationBar.hidden=YES;
    redeemNavi.view.backgroundColor = STATUS_BAR_COLOR;

    redeemVC.currentItem = [itemsArray objectAtIndex:sender.tag];
    [discountViewController presentViewController:redeemNavi animated:YES completion:NULL];
}

#pragma mark  Map

- (void)mapBtnTapped:(UIButton*)sender {
    
    MapFullView *mapFullView = [[MapFullView alloc] init];
    mapFullView.handler = self;
    mapFullView.currentItem = [itemsArray objectAtIndex:[self.listTable indexPathForSelectedRow].row];
    [MY_APP_DELEGATE.rootVC presentViewController:mapFullView animated:YES completion:nil];
}

@end
