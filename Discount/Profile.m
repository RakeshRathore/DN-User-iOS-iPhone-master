//
//  Profile.m
//  Discount
//
//  Created by Sajith KG on 04/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "Profile.h"
#import "DiscountViewController.h"
#import "AppDelegate.h"
#import "ProfileCell.h"
#import "Preferences.h"
#import "SocialMedia.h"
#import "Account.h"
#import "About.h"
#import "WebController.h"
#import "WalletScore.h"

@interface Profile () {
    
    NSMutableArray *itemsArray;
}

@end

@implementation Profile

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

-(IBAction)backBtnCall:(id)sender {
    
    DiscountViewController *discountViewController = (DiscountViewController*) MY_APP_DELEGATE.discountViewController;
    [discountViewController removeProfileScreen];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//	self.view.backgroundColor = VIEW_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.profileBG.backgroundColor = TOPBAR_BG_COLOR;
    
    self.myTable.backgroundColor = DETAIL_BG_COLOR;
    
    self.profileBtn.layer.cornerRadius = 40;
    self.profileBtn.clipsToBounds = YES;
    
    self.discountView.layer.cornerRadius = 2;
    self.discountView.clipsToBounds = YES;
    self.discountView.backgroundColor = VIEW_BG_COLOR;
    
    self.favoriteView.layer.cornerRadius = 2;
    self.favoriteView.clipsToBounds = YES;
    self.favoriteView.backgroundColor = VIEW_BG_COLOR;
    
    self.myProfileHdr.font = LATO_REGULAR(18);
    self.nameLbl.font = LATO_REGULAR(18);
    
    self.discountValue.font = LATO_REGULAR(20);
    self.favoriteValue.font = LATO_REGULAR(20);
    
    self.discountHdr.font = LATO_REGULAR(12);
    self.favoriteHdr.font = LATO_REGULAR(12);
    
    self.discountValue.textColor = TOPBAR_BG_COLOR;
    self.favoriteValue.textColor = TOPBAR_BG_COLOR;
    
    itemsArray = [[NSMutableArray alloc] initWithObjects:@"My Profile",@"WalletScore™",@"Preferences",@"Social Media",@"Help",@"About",@"Logout",nil];
    
    [self.myTable registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil]
         forCellReuseIdentifier:@"ProfileCell"];
    
    [self.myTable reloadData];
}


#pragma mark table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [itemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProfileCell *cell = (ProfileCell *)[tableView dequeueReusableCellWithIdentifier:@"ProfileCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.itemTitleLbl.textColor = [UIColor whiteColor];
    cell.arrowImg.hidden=NO;
    cell.itemTitleLbl.text = [itemsArray objectAtIndex:indexPath.row];
    
    if (indexPath.row == (int)[itemsArray count]-1) {
        cell.itemTitleLbl.textColor = RGB(224, 0, 7);
        cell.arrowImg.hidden=YES;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
            
        case 0: {
            
            Account *account = [[Account alloc] init];
            [self.navigationController pushViewController:account animated:YES];
        }
            
            break;
            
        case 1: {
            
            WalletScore *walletScore = [[WalletScore alloc] init];
            [self.navigationController pushViewController:walletScore animated:YES];
        }
            
            break;
            
        case 2: {
            
            Preferences *preferences = [[Preferences alloc] init];
            [self.navigationController pushViewController:preferences animated:YES];
        }
            
            break;
            
        case 3: {
            
            SocialMedia *socialMedia = [[SocialMedia alloc] init];
            [self.navigationController pushViewController:socialMedia animated:YES];
        }
            
            break;
            
        case 4: {
            
            WebController *help = [[WebController alloc] init];
            help.webPageType = kHelp;
            help.titleStr = [itemsArray objectAtIndex:indexPath.row];
            [self.navigationController pushViewController:help animated:YES];
        }
            
            break;
            
        case 5: {
            
            About *about = [[About alloc] init];
            [self.navigationController pushViewController:about animated:YES];
        }
            
            break;
            
        case 6: {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                            message:@"Are you sure you would like to logout?"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Cancel",@"Logout",nil];
            alert.tag=1111;
            [alert show];
        }
            
            break;
            
        default:
            break;
    }
}


#pragma mark Alert

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        
        if (buttonIndex==1) {
            
            if (alertView.tag==1111) {  //logout
                
                ViewController *viewController = MY_APP_DELEGATE.viewController;
                
                    if([viewController respondsToSelector:@selector(loginCall)])
                    {
                        [viewController loginCall];
                    }
            }
        }
    }
}


-(IBAction)wallerScoreBtnCall:(id)sender {
    
    
}



@end
