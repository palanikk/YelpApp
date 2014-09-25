//
//  YelpBusinessCellTabletViewCell.m
//  Yelp
//
//  Created by Palanisamy Kozhanthaiappan on 9/23/14.
//  Copyright (c) 2014 Palanisamy Kozhanthaiappan. All rights reserved.
//

#import "YelpBusinessCellTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface YelpBusinessCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bizImage;
@property (weak, nonatomic) IBOutlet UIImageView *ratingImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end

@implementation YelpBusinessCellTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.bizImage.layer.cornerRadius = 5;
    self.bizImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setBusiness:(YelpBusiness *)business {
    _business = business;

    if (self.count) {
        self.nameLabel.text = [NSString stringWithFormat:@"%ld. %@", self.count, business.name];
    }
    else {
        self.nameLabel.text = business.name;
    }

    NSString *reviewCount;
    if (business.reviewCount == 1) {
        reviewCount = [NSString stringWithFormat:@"%ld review", business.reviewCount];
    }
    else {
        reviewCount = [NSString stringWithFormat:@"%ld reviews", business.reviewCount];
    }
    self.reviewCountLabel.text = reviewCount;
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@, %@", business.streetAddress, business.neighborhood];
    self.categoryLabel.text = [business.categories componentsJoinedByString:@", "];

    NSURL *url = [NSURL URLWithString:business.imageURL];
    [self.bizImage setImageWithURL:url];

    url = [NSURL URLWithString:business.ratingImageURL];
    [self.ratingImage setImageWithURL:url];

}

@end
