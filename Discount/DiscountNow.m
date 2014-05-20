//
//  DiscountNow.m
//  Discount
//
//  Created by Sajith KG on 06/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "DiscountNow.h"
#import "ListCell.h"
#import "AppDelegate.h"
#import "DiscountDetail.h"
#import "DiscountViewController.h"
#import "Map.h"
#import "UIImage+customColor.h"
#import "SavedDiscount.h"

@interface UIView (PrivateMethods)
+ (void)setAnimationPosition:(CGPoint)point;
@end

@interface DiscountNow (){
    
    NSMutableArray *allAnnotations;
    DiscountViewController *discountViewController;
    
    NSDictionary *dict1,*dict2,*dict3,*dict4,*dict5;
    
    ScrollDirection scrollDirection;
    
    // NSArray *dummyArray;
    NSMutableArray *dummyArray;
    
    
    NSString *sortingSelected;
}

@end

@implementation DiscountNow

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
	self.listTable.backgroundColor = VIEW_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    
    self.holderView.backgroundColor = VIEW_BG_COLOR;
    
    self.titleLbl.font = LATO_REGULAR(18);
    
    self.nearbyBtn.titleLabel.font = LATO_REGULAR(16);
    [self.nearbyBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    self.trendingBtn.titleLabel.font = LATO_REGULAR(16);
    [self.trendingBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    self.AtoZbtn.titleLabel.font = LATO_REGULAR(16);
    [self.AtoZbtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    
    self.favouritesBtn.titleLabel.font = LATO_REGULAR(16);
    [self.favouritesBtn setTitleColor:TOPBAR_BG_COLOR forState:0];
    _itemsArray = [[NSMutableArray alloc] init];
    dummyArray =[[NSMutableArray alloc] init];
    
    [self callWebservice];
    
    
    sortingSelected = @"Nearby";
    
    //    NSArray *keysArray = @[@"discountTitle",@"discountPrice",@"originalPrice",@"percentageSavings",@"companyName",@"Expiration",@"whatsIncluded",@"storeID",@"address",@"city",@"state",@"zip",@"phoneNo",@"imageURL",@"latitude",@"longitude",@"pinType",@"youtube_link",@"categoryIcon",@"description"];
    
    //    NSArray *valueArray1 = @[@"Half off Ribs Month",@"10",@"22.50",@"56%",@"Voodoo BBQ",@"3 Days",@"For one month, we will be featuring our Award Winning Ribs and BBQ sauce at 50% off. Why? Because you just need to try them. Come in at any location and 'Grab a Slab' today, bring some home, just keep eating. BYOB",@"9987553",@"415 N Sangamon",@"Chicago",@"IL",@"60642",@"(401) 228-7373",@"Burger.jpg",@"41.6265",@"-87.3650",@"map_pin_hotel.png",@"https://www.youtube.com/watch?v=TBewVCJnhts",@"menu_restaurent.png",@"Our meats are dry rubbed with amazing Cajun spices and slow-smoked to perfection with oak and pecan, not swimming in sauce. Want an extra kick? We’ve created three unique BBQ sauces made with Louisiana ingredients. Then we pile on the homemade signature sides and pour you a sweet tea or Louisiana’s famous Abita Beer, each one with a decidedly southern drawl. Taste the magic of VooDoo BBQ & Grill."];
    //
    //    NSArray *valueArray2 =  @[@"Summer Family Fun Special",@"999",@"1500",@"33%",@"Caldera Resorts",@"5 Days ",@"The first 100 people to Cash In this offer will receive a 33% discount for your family to stay at the luxurious Caldera Resort and Spa. We offer 24 hour room service, 3 pools, and snorkel tours. DIB today and come enjoy the sun with us.",@"6213479",@"1648 W Oneterio",@"Chicago",@"IL",@"60651",@"(312) 875-9696",@"beach.jpg",@"41.6255",@"-87.8040",@"map_pin_hotel.png",@"https://www.youtube.com/watch?v=cY-LtBrFrmk",@"menu_travel.png",@"Caldera Springs is the next generation of the rich Sunriver legacy. Outdoors, nearly nine miles of walking, jogging and biking trails wind their way through 400 acres of forests and meadows with plenty of opportunities to discover nature in your own backyard. Refreshing lakes and flowing streams sparkle throughout Caldera Springs, which are a big part of what makes living here so inviting. There are plenty of adventures both on and off shore.We would like to introduce ourselves to all our new neighbors and friends! Molly Green Boutique is excited to now be located in the Riverchase Galleria Mall. We so enjoyed our time in Homewood and we’re just as happy to be in our new home in Hoover! Molly Green is locally owned and run by Bluff Park native sisters-Brittany Hartwell and Anna Miller. Molly Green reflects their funky fresh and easy going styles."];
    //
    //    NSArray *valueArray3 = @[@"Summer Dress Fashion",@"38",@"76",@"50%",@"Molly Green",@"6 Days",@"Summer is here! We know you want to spruce up your closet. At Molley Green we are offering a Buy One Get One on our new designers top styles. Come to our Location on Madison Ave and see what we have in store. ",@"6458887",@"2419 W. Madison St.",@"Chicago",@"IL",@"60612",@"(773) 227-5300",@"store-interior.jpg",@"41.6355",@"-87.2740",@"map_pin_coffee.png",@"https://www.youtube.com/watch?v=9QU7M0MUR3c",@"menu_events.png",@"We would like to introduce ourselves to all our new neighbors and friends! Molly Green Boutique is excited to now be located in the Riverchase Galleria Mall. We so enjoyed our time in Homewood and we’re just as happy to be in our new home in Hoover! Molly Green is locally owned and run by Bluff Park native sisters-Brittany Hartwell and Anna Miller. Molly Green reflects their funky fresh and easy going styles."];
    //
    //    NSArray *valueArray4 = @[@"Speedy Oil Change ",@"300",@"500",@"60%",@"Midwest Motors ",@"3 Days",@"The time is near, Winter is here come on down to Motors and get a Speedy Oil Change. ",@"2231588",@"2553 W Chicago Ave",@"Chicago",@"IL",@"60622",@"(773) 235-6500",@"mechanic.jpg",@"41.5255",@"-87.3740",@"map_pin_beer.png",@"http://www.youtube.com/v/impZ7krcPzI",@"menu_automative.png",@"Midwest Motors has the most reliable mechanics this side of Chicago!"];
    //
    //    NSArray *valueArray5 = @[@"A Pig on Every Grill",@"25",@"35",@"71%",@"Slab Of Ribs",@"7 Days",@"Slab of Ribs will be hosting the biggest all you can each barbecue week. If you can eat what \"WE\" put on your plate your meal is on us.",@"2155479",@"1470 East Touhy Avenue",@"Des Planies",@"IL",@"60016",@"(847) 391-9860",@"BBQ.jpg",@"41.6075",@"-87.6750",@"map_pin_beer.png",@"http://www.youtube.com/v/zL0CCsdS1cE",@"menu_entertainment.png",@"Delicious barbeques everyday at Slab of Ribs!"];
    //
    //    dict1 = [NSDictionary dictionaryWithObjects:valueArray1 forKeys:keysArray];
    //    dict2 = [NSDictionary dictionaryWithObjects:valueArray2 forKeys:keysArray];
    //    dict3 = [NSDictionary dictionaryWithObjects:valueArray3 forKeys:keysArray];
    //    dict4 = [NSDictionary dictionaryWithObjects:valueArray4 forKeys:keysArray];
    //    dict5 = [NSDictionary dictionaryWithObjects:valueArray5 forKeys:keysArray];
    //
    //    _itemsArray = [[NSMutableArray alloc] initWithObjects:dict1,dict2,dict3,dict4,dict5,nil];
    allAnnotations=[[NSMutableArray alloc] init];
    
    //    dummyArray = @[dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5,dict1,dict2,dict3,dict4,dict5];
    
    
    
    
    UINavigationController *navi = (UINavigationController*) [self.tabBarController.viewControllers objectAtIndex:1];
    Map *map = (Map*) navi.topViewController;
    [map setItemsArray:self.itemsArray];
    [map updateAnnotations];
    
    [self.itemsArray addObjectsFromArray:dummyArray];
    
    
    [self.listTable registerNib:[UINib nibWithNibName:@"ListCell" bundle:nil]
         forCellReuseIdentifier:@"ListCell"];
    
    self.myMapView.mapType = MKMapTypeStandard;
    [self updateMap];
    
    [self.myMapView removeFromSuperview];
    
    [self.listTable reloadData];
    
    [self addAnnotationsOverMap];
    
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

-(void)callWebservice
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *auth_token = [defaults stringForKey:@"auth_token"];
    
    NSString *str               =   [[NSString alloc]initWithFormat:@"%@/discounts?user_token=%@",MAIN_URL,auth_token];
    
    NSURL *url                  =   [NSURL URLWithString:str];
    
    NSMutableURLRequest *req    = [NSMutableURLRequest requestWithURL:url];
    req.timeoutInterval = 30.0;
    
    [req setHTTPMethod:@"GET"];
    
    
    NSURLResponse* response;
    NSError* error;
    
    NSData* result = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    
    NSString * rsltStr;
    
    
    rsltStr = [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
    
    
    
    NSLog(@"RESULT ##### :: %@",rsltStr);
    
    
    
    if (error)
    {
        [AppDelegate showWithTitle:appName message:@"An error occured.Please try again."];
    }
    else
    {
        NSDictionary *dict  =   [rsltStr JSONValue];
        NSLog(@"dict = %@",dict);
        NSLog(@"data = %@",[dict objectForKey:@"discounts"]);
        NSLog(@"data 1 ::::::::::::%@",[[dict objectForKey:@"discounts"] objectAtIndex:0]);
        
        
        NSLog(@"business ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"businesses"]);
        NSLog(@"discount_price ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"discount_price"]);
        
        NSLog(@"end_time ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"end_time"]);
        
        NSLog(@"expiration ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"expiration"]);
        
        NSLog(@"images ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"images"]);
        
        NSLog(@"locations ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"locations"]);
        
        NSLog(@"medias ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"medias"]);
        
        NSLog(@"original_price ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"original_price"]);
        NSLog(@"medias ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"medias"]);
        
        NSLog(@"original_price ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"original_price"]);
        
        NSLog(@"remaining_time ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"remaining_time"]);
        
        NSLog(@"store_id ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"store_id"]);
        
        NSLog(@"store_name ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"store_name"]);
        NSLog(@"title ::::::: %@",[[[dict objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"title"]);
        
        
        NSArray *keysArray = @[@"discountTitle",@"discountPrice",@"originalPrice",@"percentageSavings",@"companyName",@"Expiration",@"whatsIncluded",@"storeID",@"address",@"city",@"state",@"zip",@"phoneNo",@"imageURL",@"latitude",@"longitude",@"pinType",@"youtube_link",@"categoryIcon",@"description"];
        NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"discounts"]];
        NSLog(@"arr = %d",arr.count);
        for(NSDictionary *linkDic in arr)
        {
            NSLog(@"link dic = %@",linkDic);
            
            NSLog(@"business ::::::: %@",[[[linkDic objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"businesses"]);
            NSLog(@"discount_price ::::::: %@",[[[linkDic objectForKey:@"discounts"] objectAtIndex:0] objectForKey:@"discount_price"]);
            
            //            NSArray *valueArray1 = [[NSArray alloc]initWithObjects:[linkDic objectForKey:@"title"]
            //                                    ,[linkDic objectForKey:@"discount_price"],
            //                                    [linkDic objectForKey:@"original_price"],
            //                                    @"10%",
            //                                    [[linkDic  objectForKey:@"store_name"] objectAtIndex:0],@"2 ",
            //                                    [[[linkDic objectForKey:@"businesses"] objectAtIndex:0] objectForKey:@"description"],
            //                                    [[linkDic objectForKey:@"store_id"] objectAtIndex:0],
            //                                    [[[linkDic objectForKey:@"locations"] objectAtIndex:0] objectForKey:@"address"],
            //                                    [[[linkDic objectForKey:@"locations"] objectAtIndex:0] objectForKey:@"city_id"],
            //                                    [[[linkDic objectForKey:@"locations"] objectAtIndex:0] objectForKey:@"state_id"] ,
            //                                    [[[linkDic objectForKey:@"locations"] objectAtIndex:0] objectForKey:@"zip"],
            //                                    [[[linkDic objectForKey:@"businesses"] objectAtIndex:0] objectForKey:@"contact_number"],
            //                                    [[[linkDic objectForKey:@"images"]objectAtIndex:0] objectAtIndex:0],
            //                                    [[[linkDic objectForKey:@"locations"] objectAtIndex:0] objectForKey:@"latitude"],
            //                                    [[[linkDic objectForKey:@"locations"] objectAtIndex:0] objectForKey:@"longitude"],
            //                                    @"map_pin_hotel.png",@"https://www.youtube.com/watch?v=TBewVCJnhts",@"menu_restaurent.png",
            //                                    [[[linkDic objectForKey:@"businesses"] objectAtIndex:0] objectForKey:@"description"],nil];
            
            NSArray *valueArray1 = @[@"Half off Ribs Month",@"10",@"22.50",@"56%",@"Voodoo BBQ",@"3 Days",@"For one month, we will be featuring our Award Winning Ribs and BBQ sauce at 50% off. Why? Because you just need to try them. Come in at any location and 'Grab a Slab' today, bring some home, just keep eating. BYOB",@"9987553",@"415 N Sangamon",@"Chicago",@"IL",@"60642",@"(401) 228-7373",@"Burger.jpg",@"41.6265",@"-87.3650",@"map_pin_hotel.png",@"https://www.youtube.com/watch?v=TBewVCJnhts",@"menu_restaurent.png",@"Our meats are dry rubbed with amazing Cajun spices and slow-smoked to perfection with oak and pecan, not swimming in sauce. Want an extra kick? We’ve created three unique BBQ sauces made with Louisiana ingredients. Then we pile on the homemade signature sides and pour you a sweet tea or Louisiana’s famous Abita Beer, each one with a decidedly southern drawl. Taste the magic of VooDoo BBQ & Grill."];
            NSLog(@"array = %@",valueArray1);
            dict1 = [NSDictionary dictionaryWithObjects:valueArray1 forKeys:keysArray];
            [_itemsArray addObject:dict1];
            [dummyArray addObject:dict1];
            
        }
        
        NSLog(@"items array = %@",_itemsArray);
        //        NSArray *valueArray1 = @[@"Half off Ribs Month",@"10",@"22.50",@"56%",@"Voodoo BBQ",@"3 Days",@"For one month, we will be featuring our Award Winning Ribs and BBQ sauce at 50% off. Why? Because you just need to try them. Come in at any location and 'Grab a Slab' today, bring some home, just keep eating. BYOB",@"9987553",@"415 N Sangamon",@"Chicago",@"IL",@"60642",@"(401) 228-7373",@"Burger.jpg",@"41.6265",@"-87.3650",@"map_pin_hotel.png",@"https://www.youtube.com/watch?v=TBewVCJnhts",@"menu_restaurent.png",@"Our meats are dry rubbed with amazing Cajun spices and slow-smoked to perfection with oak and pecan, not swimming in sauce. Want an extra kick? We’ve created three unique BBQ sauces made with Louisiana ingredients. Then we pile on the homemade signature sides and pour you a sweet tea or Louisiana’s famous Abita Beer, each one with a decidedly southern drawl. Taste the magic of VooDoo BBQ & Grill."];
        
        
        //        {
        //            discounts =     (
        //                             {
        //                                 businesses =             (
        //                                                           {
        //                                                               "category_id" = "<null>";
        //                                                               "contact_number" = "(312) 875-9696";
        //                                                               "created_at" = "2014-01-24T11:15:22.230Z";
        //                                                               description = "Partake in this opportuntity of a lifetime to dine, relax, and enjoy life. Come down to our fabulous hotel and spa to take a load off.";
        //                                                               id = 22;
        //                                                               name = "Resort Spa";
        //                                                               "parent_id" = 3;
        //                                                               "updated_at" = "2014-01-24T11:15:22.230Z";
        //                                                               "use_business_address" = 0;
        //                                                               "user_id" = 9;
        //                                                           }
        //                                                           );
        //                                 "discount_price" = 20;
        //                                 "end_time" = "2014-01-29";
        //                                 expiration = "2014-01-29";
        //                                 id = 21;
        //                                 images =             (
        //                                                       (
        //                                                        "https://s3.amazonaws.com/discountnow_production/uploads/media/image/22/Beach.jpg"
        //                                                        )
        //                                                       );
        //                                 location =             (
        //                                                         (
        //                                                          "41.8788515",
        //                                                          "-87.6364782"
        //                                                          )
        //                                                         );
        //                                 locations =             (
        //                                                          {
        //                                                              address = "233 S Wacker Dr";
        //                                                              "business_id" = 22;
        //                                                              "city_id" = 12698;
        //                                                              "created_at" = "2014-01-24T11:15:22.277Z";
        //                                                              "google_address" = "<null>";
        //                                                              id = 22;
        //                                                              latitude = "41.8788515";
        //                                                              longitude = "-87.6364782";
        //                                                              "state_id" = 166;
        //                                                              "updated_at" = "2014-01-24T11:15:22.277Z";
        //                                                              zip = "<null>";
        //                                                          }
        //                                                          );
        //                                 medias =             (
        //                                                       {
        //                                                           "created_at" = "2014-01-24T11:20:17.185Z";
        //                                                           "discount_id" = 21;
        //                                                           "embedded_code" = "";
        //                                                           id = 22;
        //                                                           image =                     {
        //                                                               medium =                         {
        //                                                                   url = "https://s3.amazonaws.com/discountnow_production/uploads/media/image/22/medium_Beach.jpg";
        //                                                               };
        //                                                               thumb =                         {
        //                                                                   url = "https://s3.amazonaws.com/discountnow_production/uploads/media/image/22/thumb_Beach.jpg";
        //                                                               };
        //                                                               url = "https://s3.amazonaws.com/discountnow_production/uploads/media/image/22/Beach.jpg";
        //                                                           };
        //                                                           title = "";
        //                                                           "updated_at" = "2014-01-24T11:20:17.185Z";
        //                                                       }
        //                                                       );
        //                                 "original_price" = 30;
        //                                 "remaining_time" = Expired;
        //                                 savings = 10;
        //                                 "store_id" =             (
        //                                                           22
        //                                                           );
        //                                 "store_name" =             (
        //                                                             "Resort Spa"
        //                                                             );
        //                                 title = "Vacation on the Islands of Chicago";
        //                             }
        //                             );
        //        }
        
        
        
        
        
        
        
        
        
        
        
    }
    
}


#pragma mark -
#pragma mark Search

- (void) reloadDataWithSearchQueries: (NSDictionary*) dict {
    
    DLog(@"dict=%@",dict);
    
    if ([[dict objectForKey:@"searchKey"] length] && [[dict objectForKey:@"location"] length]) {
        sortingSelected =  [NSString stringWithFormat:@"Search Results for \"%@ in %@\"",[dict objectForKey:@"searchKey"],[dict objectForKey:@"location"]];
    }else {
        
        if ([[dict objectForKey:@"searchKey"] length]) {
            sortingSelected =  [NSString stringWithFormat:@"Search Results for \"%@ in all locations\"",[dict objectForKey:@"searchKey"]];
        }else {
            
            sortingSelected =  [NSString stringWithFormat:@"Search results for \"All offers in %@\"",[dict objectForKey:@"location"]];
        }
    }
    
    [self.listTable reloadData];
    [self.listTable scrollRectToVisible:CGRectMake(0, 0, 320, 50) animated:YES];
}
#pragma mark -
#pragma mark Category

- (void) subCategoriesSelected: (NSArray*) ary {
    
    DLog(@"ary=%@",ary);
}

#pragma mark -
#pragma mark Sorting

- (IBAction)sortBtnCall:(id)sender {
    
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
    [self.itemsArray removeAllObjects];
    
    NSArray *tempAry;
    
    switch (sender.tag) {
        case 1:
            tempAry = @[dict1,dict2,dict3,dict4,dict5];
            sortingSelected = @"Nearby";
            break;
        case 2:
            tempAry = @[dict4,dict3,dict1,dict2,dict5];
            sortingSelected = @"Trending";
            break;
        case 3:
            tempAry = @[dict5,dict1,dict3,dict2,dict4];
            sortingSelected = @"A-Z";
            break;
        case 4:
            tempAry = @[dict2,dict1,dict5,dict3,dict4];
            sortingSelected = @"Favorites";
            break;
            
        default:
            break;
    }
    
    [self.itemsArray addObjectsFromArray:tempAry];
    [self.itemsArray addObjectsFromArray:dummyArray];
    
    [self.listTable reloadData];
    [self.listTable scrollRectToVisible:CGRectMake(0, 0, 320, 50) animated:YES];

}

#pragma mark -
#pragma mark MAP

#pragma mark Toggle

- (void) toggleCurrentView {
    
    if (!self.myMapView.superview) {
        
        [UIView transitionWithView:self.holderView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [self.holderView addSubview:self.myMapView];
                            [self.listView removeFromSuperview];
                        }
                        completion:^(BOOL finished){
                            
                        }];
        
    }else {
        [UIView transitionWithView:self.holderView
                          duration:1.0
                           options:UIViewAnimationOptionTransitionFlipFromRight
                        animations:^{
                            [self.myMapView removeFromSuperview];
                            [self.holderView addSubview:self.listView];
                        }
                        completion:^(BOOL finished){
                            
                        }];
    }
}

#pragma mark Add annotations

- (void) updateMap {
    
    MKCoordinateSpan span;
    //    span.latitudeDelta=0.5;
    //    span.longitudeDelta=0.5;
    span.latitudeDelta=1;
    span.longitudeDelta=1;
    MKCoordinateRegion region;
    region.span=span;
    region.center=CLLocationCoordinate2DMake(41.5255, -87.3740);
    [self.myMapView setRegion:region animated:YES];
    [self.myMapView regionThatFits:region];
}

- (void) addAnnotationsOverMap {
    
    //[self.itemsArray removeAllObjects];  // webservice
    
    [self.myMapView removeAnnotations:allAnnotations];
    [allAnnotations removeAllObjects];
    
    for (int i=0;i<[self.itemsArray count];i++) {
        
        NSMutableDictionary *currentDict = [self.itemsArray objectAtIndex:i];
        
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = [[currentDict objectForKey:@"latitude"] floatValue];
        coordinate.longitude = [[currentDict objectForKey:@"longitude"] floatValue];
        
        MyLocation *myLocation = [[MyLocation alloc] initWithCoordinate:coordinate andTag:[NSString stringWithFormat:@"%d",i] andName:[currentDict objectForKey:@"discountTitle"] andSubName:[currentDict objectForKey:@"whatsIncluded"]];
        [allAnnotations addObject:myLocation];
    }
    
    [self.myMapView addAnnotations:allAnnotations];
}

#pragma mark MapView delegate

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKAnnotationView *pinView = nil;
    MyLocation *location = (MyLocation *) annotation;
    if(annotation != mapView.userLocation)
    {
        if([annotation isKindOfClass:[MyLocation class]]) {
            
            static NSString *defaultPinID = @"groupPin";
            pinView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
            
            if (pinView == nil ) {
                pinView = [[MKAnnotationView alloc]
                           initWithAnnotation:annotation reuseIdentifier:defaultPinID];
                
                MyLocation *current = (MyLocation*) annotation;
                UIImage *pinImage = [UIImage imageNamed:[[self.itemsArray objectAtIndex:[current.Id intValue]] objectForKey:@"pinType"]];
                pinView.image = pinImage;
                
                UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
                //rightButton.backgroundColor = [UIColor redColor];
                
                
                if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7")) {
                    rightButton.frame=CGRectMake(0, 0, 40, 44);
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateNormal];
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateHighlighted];
                }else {
                    rightButton.frame=CGRectMake(0, 0, 44, 32);
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateNormal];
                    [rightButton setImage:[UIImage imageNamed:@"map_arrow.png"] forState:UIControlStateHighlighted];
                }
                
                rightButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
                
                
                [rightButton setContentMode:UIViewContentModeScaleAspectFit];
                pinView.rightCalloutAccessoryView = rightButton;
                pinView.calloutOffset = CGPointMake(-3, 3);
                pinView.canShowCallout = YES;
            }
            
            pinView.rightCalloutAccessoryView.tag = [location.Id intValue];
        }
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views) {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.myMapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    [UIView animateWithDuration:0.1 animations:^{
                        aV.transform = CGAffineTransformIdentity;
                    }];
                }];
            }
        }];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    
    //[self pushDetailView:(int)control.tag];
}

#pragma mark  - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.itemsArray count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *title = [[UILabel alloc] init];
    title.text=sortingSelected;
    title.font = LATO_REGULAR(14);
    title.backgroundColor = [UIColor grayColor];
    title.textColor = [UIColor whiteColor];
    title.textAlignment = NSTextAlignmentCenter;

    return title;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    DLog(@"indexPath=%@  dragging=%d  decelerating=%d",indexPath  ,  tableView.dragging ,tableView.decelerating );
//    DLog(@" %d %d",tableView.dragging ,tableView.decelerating);
    
    ListCell *cell = (ListCell *)[tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.highlighted=NO;
    
    [cell.optionBtn setTag:indexPath.row];
    [cell.favoriteBtn setTag:indexPath.row];
    [cell.captureBtn setTag:indexPath.row];
    [cell.mapBtn setTag:indexPath.row];
    [cell.shareBtn setTag:indexPath.row];
    
    [cell.optionBtn addTarget:self action:@selector(showHideOptionView:) forControlEvents:UIControlEventTouchUpInside];
    [cell.favoriteBtn addTarget:self action:@selector(favoriteBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    [cell.shareBtn addTarget:self action:@selector(shareBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    [cell.mapBtn addTarget:self action:@selector(mapBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [cell.captureBtn addTarget:self action:@selector(captureBtnCall:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.favoriteBtn.selected=NO;
    
    NSDictionary *currentDict=[self.itemsArray objectAtIndex:indexPath.row];
    
    [cell.captureBtn setTitle:@"Dibs!" forState:0];
    
    cell.daysLbl.text = [currentDict objectForKey:@"Expiration"];
    cell.priceLbl.text = [NSString stringWithFormat:@"$%@",[currentDict objectForKey:@"discountPrice"]];
    
    [cell.itemPic setImage:[UIImage imageNamed:[currentDict objectForKey:@"imageURL"]]];
    
    [cell.categoryPic setImage:[[UIImage imageNamed:[currentDict objectForKey:@"categoryIcon"]] imageWithOverlayColor:[UIColor whiteColor]]];
    
    cell.itemTitleLbl.text = [currentDict objectForKey:@"discountTitle"];
    cell.itemDesLbl.text = [NSString stringWithFormat:@"$%@ for $%@ \n%@ off at %@",[currentDict objectForKey:@"discountPrice"],[currentDict objectForKey:@"originalPrice"],[currentDict objectForKey:@"percentageSavings"],[currentDict objectForKey:@"companyName"]];
    
    cell.itemTitleLbl.hidden=YES;
    cell.itemDesLbl.hidden=YES;
    
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
        
//        CGFloat animationTime = self.listTable.decelerationRate;
        CGFloat animationTime = 0.6;
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:animationTime];
        [cell.itemTitleLbl setFrame:itemTitleLblFrame];
        [UIView commitAnimations];
        
        CGRect itemDesLblFrame = cell.itemDesLbl.frame;
        CGRect startFrame1 = CGRectMake(cell.itemDesLbl.frame.origin.x, cell.itemDesLbl.frame.origin.y+animate, cell.itemDesLbl.frame.size.width, cell.itemDesLbl.frame.size.height);
        
        [cell.itemDesLbl setFrame:startFrame1];
        
        [UIView beginAnimations:@"animateTableView" context:nil];
        [UIView setAnimationDuration:animationTime];
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
    [discountDetail setCurrentItem:[self.itemsArray objectAtIndex:selectedRow]];
    discountDetail.isSavedDeal=NO;
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
    
    NSDictionary *currentItem = [self.itemsArray objectAtIndex:sender.tag];
    
    [[SocialKit sharedSocialKit] setMessage:[NSString stringWithFormat:@"Check this %@",[currentItem objectForKey:@"discountTitle"]]];
    [[SocialKit sharedSocialKit] setUrlStr:@"http://acapellaglobal.com/clients/Discount_Now_Admin/admin/index.html"];
    [[SocialKit sharedSocialKit] ShowShareOptions];

    //[self doAutoPost];
}

#pragma mark  Capture

- (void) captureBtnCall:(id) sender
{

    [self.listTable deselectRowAtIndexPath:[self.listTable indexPathForSelectedRow] animated:YES];
    
    NSIndexPath *currentIndexPath = [self.listTable indexPathForSelectedRow];
    ListCell *listCell = (ListCell*)[self.listTable cellForRowAtIndexPath:currentIndexPath];
    [listCell toggleDibbButton];

    [UIView beginAnimations:@"suck" context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationCompleted)];
    [UIView setAnimationTransition:103 forView:discountViewController.view cache:NO];
    [UIView setAnimationDuration:0.8f];
    [UIView setAnimationPosition:CGPointMake(288, 545)];
    [UIView commitAnimations];
    
    [MY_APP_DELEGATE.discountViewController changeSelectedTab:4];
}

- (void) animationCompleted {
    
    SavedDiscount *savedDiscount = [MY_APP_DELEGATE.discountViewController.SavedNavi.viewControllers objectAtIndex:0];
    [savedDiscount showThankYouPage:[self.itemsArray objectAtIndex:[self.listTable indexPathForSelectedRow].row]];
    
    [MY_APP_DELEGATE.discountViewController increaseDiscountBadge];
}

#pragma mark  Map

- (void)mapBtnTapped:(UIButton*)sender {
    
    MapFullView *mapFullView = [[MapFullView alloc] init];
    mapFullView.currentItem = [self.itemsArray objectAtIndex:[self.listTable indexPathForSelectedRow].row];
    mapFullView.handler = self;
    [MY_APP_DELEGATE.rootVC presentViewController:mapFullView animated:YES completion:nil];
}


@end
