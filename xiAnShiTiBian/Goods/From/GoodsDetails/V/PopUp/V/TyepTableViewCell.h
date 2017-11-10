//
//  TyepTableViewCell.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/12/14.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TyepTableViewCellDelegate <NSObject>

- (void)typeSubscript:(OrderBtn *)sender;
@end

@interface TyepTableViewCell : UITableViewCell

@property (nonatomic, assign)id<TyepTableViewCellDelegate>delegate;

- (void)assignmentIndex:(NSMutableArray *)index;

@property (nonatomic, strong)NSMutableArray *DataArray;
- (void)PhotoNamesDic:(NSDictionary *)dic  title:(NSString *)title  indexPath:(NSIndexPath *)indexPath;
@end

