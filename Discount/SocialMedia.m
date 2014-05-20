//
//  SocialMedia.m
//  Discount
//
//  Created by Sajith KG on 05/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "SocialMedia.h"
#import "SocialMediaCell.h"
#import "AppDelegate.h"

@interface SocialMedia (){
    
}

@end

@implementation SocialMedia

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
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = VIEW_BG_COLOR;
    self.topbarView.backgroundColor = TOPBAR_BG_COLOR;
    self.myTable.backgroundColor = DETAIL_BG_COLOR;
    
    self.viewHdr.font = LATO_REGULAR(18);
    
    [self.myTable registerNib:[UINib nibWithNibName:@"SocialMediaCell" bundle:nil]
       forCellReuseIdentifier:@"SocialMediaCell"];
    
    [self.myTable reloadData];
}

#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}

- (UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 25)];
    lbl.backgroundColor = DETAIL_BG_COLOR;
    lbl.font = LATO_BOLD(16);
    lbl.textColor = STATUS_BAR_COLOR;
    
    switch (section) {
        case 0:
            lbl.text = @"    Social Connections";
            break;
            
        case 1:
            lbl.text = @"    Share My Dibs";
            break;
            
        case 2:
            lbl.text = @"    Share My Favorites";
            break;
            
        default:
            lbl.text = @"";
            break;
    }
    
    return lbl;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SocialMediaCell *cell = (SocialMediaCell *)[tableView dequeueReusableCellWithIdentifier:@"SocialMediaCell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    cell.socialSwitch.superview.tag = indexPath.section;
    cell.socialSwitch.tag = indexPath.row;
    [cell.socialSwitch addTarget:self action:@selector(switchToggled:) forControlEvents:UIControlEventValueChanged];
    
    cell.lineImg.hidden=NO;
    [cell enableCell:YES];
    
    cell.lineImg.frame = CGRectMake(10, cell.frame.size.height-1, 300, 1);
    
    
    switch (indexPath.row) {  // common icon set up
        case 0:
            cell.iconImg.image = [UIImage imageNamed:@"social_facebook.png"];
            break;
            
        case 1:
            cell.iconImg.image = [UIImage imageNamed:@"social_twitter.png"];
            break;
    }
    
    
    if (indexPath.section==0) {
        
        switch (indexPath.row) {
            case 0:{
                
                cell.itemTitleLbl.text = @"Connect to Facebook";
                [cell.socialSwitch setOn:[Global getDefaultBool:SOCIAL_FACEBOOK]];
            }
                break;
                
            case 1: {
                
                cell.itemTitleLbl.text = @"Connect to Twitter";
                [cell.socialSwitch setOn:[Global getDefaultBool:SOCIAL_TWITTER]];
            }
                
                break;
                
            default:
                break;
        }
    }
    
    if (indexPath.section==1) {
        
        switch (indexPath.row) {
            case 0:
                
                cell.itemTitleLbl.text = @"Automatically post to Facebook";
                [cell enableCell:[Global getDefaultBool:SOCIAL_FACEBOOK]];
                [cell.socialSwitch setOn:[Global getDefaultBool:POST_DIBS_FACEBOOK]];
                break;
                
            case 1:
                cell.itemTitleLbl.text = @"Automatically post to Twitter";
                [cell enableCell:[Global getDefaultBool:SOCIAL_TWITTER]];
                [cell.socialSwitch setOn:[Global getDefaultBool:POST_DIBS_TWITTER]];
                break;

            default:
                break;
        }
    }
    
    if (indexPath.section==2) {
        
        switch (indexPath.row) {
            case 0:
                cell.itemTitleLbl.text = @"Automatically post to Facebook";
                [cell enableCell:[Global getDefaultBool:SOCIAL_FACEBOOK]];
                [cell.socialSwitch setOn:[Global getDefaultBool:POST_FAVS_FACEBOOK]];
                break;
                
            case 1:
                cell.itemTitleLbl.text = @"Automatically post to Twitter";
                [cell enableCell:[Global getDefaultBool:SOCIAL_TWITTER]];
                [cell.socialSwitch setOn:[Global getDefaultBool:POST_FAVS_TWITTER]];
                break;
                
            default:
                break;
        }
    }
    
    
    return cell;
}

#pragma mark Toggle

- (void) switchToggled:(id)sender {
    
    UISwitch *mySwitch = (UISwitch *)sender;
    
    if (mySwitch.superview.tag==0) {
        
        switch (mySwitch.tag) {
            case 0:{
                
                if ([mySwitch isOn]) {
                    [MY_APP_DELEGATE checkFacebookLoginCall:self];
                } else {
                    [Global saveDefaultBool:NO forKey:SOCIAL_FACEBOOK];
                    [Global saveDefaultBool:NO forKey:POST_DIBS_FACEBOOK];
                    [Global saveDefaultBool:NO forKey:POST_FAVS_FACEBOOK];
                    [self.myTable performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
                }
            }
                break;
                
            case 1: {
                
                if ([mySwitch isOn]) {
                    [MY_APP_DELEGATE checkTwitterLogin:self];
                } else {
                    [Global saveDefaultBool:NO forKey:SOCIAL_TWITTER];
                    [Global saveDefaultBool:NO forKey:POST_DIBS_TWITTER];
                    [Global saveDefaultBool:NO forKey:POST_FAVS_TWITTER];
                    [self.myTable performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
                }
            }
                
                break;
                
            default:
                break;
        }
        
        
    }else if (mySwitch.superview.tag==1) {
    
        switch (mySwitch.tag) {
            case 0:{
                
                if ([mySwitch isOn])
                    [Global saveDefaultBool:YES forKey:POST_DIBS_FACEBOOK];
                else
                    [Global saveDefaultBool:NO forKey:POST_DIBS_FACEBOOK];
                
            }
                break;
                
            case 1: {
                
                if ([mySwitch isOn])
                    [Global saveDefaultBool:YES forKey:POST_DIBS_TWITTER];
                else
                    [Global saveDefaultBool:NO forKey:POST_DIBS_TWITTER];
            }
                
                break;
                
            default:
                break;
        }
    
    }else {
        
        switch (mySwitch.tag) {
            case 0:{
                
                if ([mySwitch isOn])
                    [Global saveDefaultBool:YES forKey:POST_FAVS_FACEBOOK];
                else
                    [Global saveDefaultBool:NO forKey:POST_FAVS_FACEBOOK];
            }
                break;
                
            case 1: {
                
                if ([mySwitch isOn])
                    [Global saveDefaultBool:YES forKey:POST_FAVS_TWITTER];
                else
                    [Global saveDefaultBool:NO forKey:POST_FAVS_TWITTER];
            }
                
                break;
                
            default:
                break;
        }
    }

}

#pragma mark  Facebook

- (void) successFacebookLogin {
    
    [Global saveDefaultBool:YES forKey:SOCIAL_FACEBOOK];
    [self.myTable performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
}

- (void) failureFacebookLogin {
    
    [Global saveDefaultBool:NO forKey:SOCIAL_FACEBOOK];
    [Global saveDefaultBool:NO forKey:POST_DIBS_FACEBOOK];
    [Global saveDefaultBool:NO forKey:POST_FAVS_FACEBOOK];
    [self.myTable reloadData];
}

#pragma mark  Twitter

- (void) successTwitterLogin {
    
    [Global saveDefaultBool:YES forKey:SOCIAL_TWITTER];
    [self.myTable performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
}

- (void) failureTwitterLogin {
    
    [Global saveDefaultBool:NO forKey:SOCIAL_TWITTER];
    [Global saveDefaultBool:NO forKey:POST_DIBS_TWITTER];
    [Global saveDefaultBool:NO forKey:POST_FAVS_TWITTER];
    [self.myTable reloadData];
}



@end
