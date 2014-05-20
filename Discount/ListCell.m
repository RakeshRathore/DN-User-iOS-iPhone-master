//
//  ListCell.m
//  Discount
//
//  Created by Sajith KG on 21/01/14.
//  Copyright (c) 2014 Justin. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    CGFloat animationTime = 0.0;
    
    if (animated) {
        animationTime = 0.4;
    }

    if (selected) {
        
        [UIView animateWithDuration:animationTime animations:^{
            self.cellView.frame = CGRectMake(-194, self.cellView.frame.origin.y, self.cellView.frame.size.width, self.cellView.frame.size.height);
            
        } completion:^(BOOL finished){
        
            [self.optionBtn setImage:[UIImage imageNamed:@"cell_arrow_right.png"] forState:0];
        }];
        
    }else {
    
        [UIView animateWithDuration:animationTime animations:^{
             self.cellView.frame = CGRectMake(0, self.cellView.frame.origin.y, self.cellView.frame.size.width, self.cellView.frame.size.height);
            
            
        }completion:^(BOOL finished){
            
            [self.optionBtn setImage:[UIImage imageNamed:@"cell_arrow_left.png"] forState:0];
        }];
    }
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
    self.itemTitleLbl.font = LATO_BOLD(16);
    self.itemDesLbl.font = LATO_BOLD(12);
    self.priceLbl.font = LATO_BOLD(20);
    self.daysLbl.font = LATO_BOLD(12);
    
    self.priceLbl.layer.cornerRadius = 2;
    self.priceLbl.clipsToBounds = YES;
    
    self.optionView.backgroundColor = DETAIL_BG_COLOR;
    
    self.lineHor.backgroundColor = RGB(30, 57, 77);
    self.lineVer.backgroundColor = RGB(30, 57, 77);
    
    [self.captureBtn.titleLabel setFont:LATO_REGULAR(18)];
    
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_sel.png"] forState:UIControlStateSelected];
    [self.favoriteBtn setImage:[UIImage imageNamed:@"favorite_sel.png"] forState:UIControlStateSelected];
    
}

- (void) toggleDibbButton {

    [self.dibbImg setHidden:false];
        
}

- (void) toggleFavoriteButton {
    
    if (!self.favoriteBtn.isSelected) {
        
        self.favoriteBtn.selected=!self.favoriteBtn.isSelected;
        
        self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.4, 1.4);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    self.favoriteBtn.transform = CGAffineTransformIdentity;
                    
                }];
            }];
        }];
    }else {
        
        self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0 , 1.0);
        
        [UIView animateWithDuration:0.3/1.5 animations:^{
            self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
        } completion:^(BOOL finished) {
            self.favoriteBtn.selected=!self.favoriteBtn.isSelected;
            [UIView animateWithDuration:0.3/2 animations:^{
                self.favoriteBtn.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
            } completion:^(BOOL finished) {
                [UIView animateWithDuration:0.3/2 animations:^{
                    self.favoriteBtn.transform = CGAffineTransformIdentity;
                    
                }];
            }];
        }];
        
    }
}







@end
