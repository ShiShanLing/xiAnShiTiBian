//
//  ProductDetailsPictureTVCell.m
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/12.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import "ProductDetailsPictureTVCell.h"
#import <ImageIO/CGImageSource.h>
#import <ImageIO/CGImageProperties.h>

@implementation ProductDetailsPictureTVCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSURL *url = [[NSURL alloc] initWithString:@"http://i4.cqnews.net/news/attachement/jpg/site82/2016-08-23/9143505007648195979.jpg"];
        [self getImageSizeWithURL:url];
        
        self.image = [UIImageView new];
        self.image.image = [UIImage imageNamed:@"jieshao"];
       CGFloat heigth = [UIImage imageNamed:@"jieshao"].size.height /( [UIImage imageNamed:@"jieshao"].size.width/kScreen_widht);
        [self.contentView addSubview:_image];
        _image.sd_layout.leftSpaceToView(self.contentView, 0).topSpaceToView(self.contentView, kFit(20)).rightSpaceToView(self.contentView, 0).heightIs(heigth);
        
        [self setupAutoHeightWithBottomView:_image bottomMargin:0];
        
    }
    return self;
}
- (CGSize)getImageSizeWithURL:(NSURL *)url
{
    CGImageSourceRef image = CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0.0f, height = 0.0f;
    
    if (image)
    {
        CFDictionaryRef imageAcc = CGImageSourceCopyPropertiesAtIndex(image, 0, NULL);
        
        if (imageAcc != NULL)
        {
            CFNumberRef widthNumber  = CFDictionaryGetValue(imageAcc, kCGImagePropertyPixelWidth);
            if (widthNumber != NULL) {
                CFNumberGetValue(widthNumber, kCFNumberFloatType, &width);
            }
            
            CFNumberRef heightNumber = CFDictionaryGetValue(imageAcc, kCGImagePropertyPixelHeight);
            if (heightNumber != NULL) {
                CFNumberGetValue(heightNumber, kCFNumberFloatType, &height);
            }
            
            CFRelease(imageAcc);
        }
        CFRelease(image);
        NSLog(@"Image dimensions: %.0f x %.0f px", width, height);
    }
    return CGSizeMake(width, height);
}

@end
