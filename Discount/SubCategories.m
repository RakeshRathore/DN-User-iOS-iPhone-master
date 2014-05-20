//
//  SubCategories.m
//  Discount
//
//  Created by Sajith KG on 12/02/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "SubCategories.h"
#import "RootVC.h"
#import "AppDelegate.h"
#import "SubCategoryCell.h"
#import "DiscountNow.h"
#import "LeftMenu.h"

@interface SubCategories () {

    UIColor *textColor;
    NSMutableArray *selectedItems;
}

@end

@implementation SubCategories

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
    self.view.backgroundColor = RGB(24, 40, 61);
    
    textColor = RGB(174, 231, 255);
    
    self.categoryName.font = LATO_BOLD(22);
    [self.categoryName setTextColor:textColor];
    
    selectedItems = [[NSMutableArray alloc] init];
    
    self.applyCategoriesBtn.titleLabel.font = LATO_BOLD(16);
    [self.applyCategoriesBtn setTitleColor:[UIColor whiteColor] forState:0];
    [self.applyCategoriesBtn setBackgroundColor:TOPBAR_BG_COLOR];
    
    [self.myTable registerNib:[UINib nibWithNibName:@"SubCategoryCell" bundle:nil]
       forCellReuseIdentifier:@"SubCategoryCell"];
    
}

- (void) resetSubCategories {
    
    DLog(@"self.categoryDetails=%@",self.categoryDetails);

    self.categoryName.text = [self.categoryDetails objectForKey:@"category"];
    self.iconView.image = [UIImage imageNamed:[self.categoryDetails objectForKey:@"categoryPicture"]];
    
    [selectedItems removeAllObjects];
    
    [self.myTable reloadData];
}

- (IBAction) applyCategoriesBtnCall:(UIButton*) sender {
    
    [MY_APP_DELEGATE.rootVC hideSubCategoryViewWithAnimation:NO];
    [MY_APP_DELEGATE.discountViewController.sideMenuViewController hideMenuViewController];
    
    
    UINavigationController *navi = (UINavigationController*) [[MY_APP_DELEGATE.discountViewController.mainTabBarCtr viewControllers] objectAtIndex:2];
    
    if ([navi.viewControllers count]>1) {
        [navi popToRootViewControllerAnimated:NO];
    }
    
    [MY_APP_DELEGATE.discountViewController changeSelectedTab:2];
    
    DiscountNow *discountNow = (DiscountNow*) navi.topViewController;
    
    [discountNow  subCategoriesSelected:selectedItems];
}

- (IBAction)arrowSelected:(id)sender {
    
    LeftMenu *leftMenu = (LeftMenu *)MY_APP_DELEGATE.rootVC.menuViewController;
    [leftMenu setSelectedNoOfSubCategories:[selectedItems count]];
    
    [MY_APP_DELEGATE.rootVC hideSubCategoryViewWithAnimation:YES];
}

#pragma mark  - Table

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.categoryDetails objectForKey:@"subCategories"] count]+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SubCategoryCell *cell = (SubCategoryCell *)[tableView dequeueReusableCellWithIdentifier:@"SubCategoryCell"];
    
    if (cell==nil) {
        cell = [[SubCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SubCategoryCell"];
        cell.selectionImg.alpha=0;
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==0) {
        cell.subCategoryName.text = [NSString stringWithFormat:@"Select All %@",[self.categoryDetails objectForKey:@"category"]];
    }else {
        cell.subCategoryName.text = [[self.categoryDetails objectForKey:@"subCategories"] objectAtIndex:indexPath.row-1];
    }

    cell.selectionImg.hidden = ![self isAlreadySelected:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==0) {
        
        if ([self isAlreadySelected:indexPath.row]) {
            [selectedItems removeAllObjects];
            
        }else {
            for (int i=0; i<=[[self.categoryDetails objectForKey:@"subCategories"] count]; i++) {
                
                [selectedItems addObject:[NSNumber numberWithInteger:i]];
            }
            
        }
        [tableView reloadData];
      
    }else {
        
        SubCategoryCell *cell = (SubCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        if ([self isAlreadySelected:indexPath.row]) {
            
            if ([self isAlreadySelected:0]) {
                
                SubCategoryCell *cellFirst = (SubCategoryCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
                
                [selectedItems removeObject:[NSNumber numberWithInteger:0]];
                
                [UIView transitionWithView:cell
                                  duration:0.3
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    cellFirst.selectionImg.hidden = YES;
                                }
                                completion:NULL];
            }
            
            
            [selectedItems removeObject:[NSNumber numberWithInteger:indexPath.row]];
            
            [UIView transitionWithView:cell
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                cell.selectionImg.hidden = YES;
                            }
                            completion:NULL];
            
        }else {
            [selectedItems addObject:[NSNumber numberWithInteger:indexPath.row]];
            
            [UIView transitionWithView:cell
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                cell.selectionImg.hidden = NO;
                            }
                            completion:NULL];
        }
        
    }
    
    return;
    
    
    
    if ([self isAlreadySelected:indexPath.row]) {
        
        if (indexPath.row==0) {
            [selectedItems removeAllObjects];
        }else {
            [selectedItems removeObject:[NSNumber numberWithInteger:indexPath.row]];
        }
        
    }else {
        
        if (indexPath.row==0) {
            
            for (int i=0; i<=[[self.categoryDetails objectForKey:@"subCategories"] count]; i++) {
                
                [selectedItems addObject:[NSNumber numberWithInteger:i]];
            }
            
        }else {
             [selectedItems addObject:[NSNumber numberWithInteger:indexPath.row]];
            
            
            SubCategoryCell *cell = (SubCategoryCell *)[tableView cellForRowAtIndexPath:indexPath];
            
            [UIView transitionWithView:cell
                              duration:0.4
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                cell.selectionImg.hidden = NO;
                            }
                            completion:NULL];
        }
    }
}

- (BOOL) isAlreadySelected:(NSInteger) currentNo {

    for (NSNumber *number in selectedItems) {
        
        NSInteger no = [number integerValue];
        if (no == currentNo) {
            return YES;
        }
    }
    return NO;
}




@end
