//
//  JHDownMenuView.m
//  模仿QQ下拉菜单
//
//  Created by zhou on 16/7/21.
//  Copyright © 2016年 zhou. All rights reserved.
//

#define JHMargin 10


#import "JHDownMenuView.h"
#import "SearchTypeTVCell.h"

@interface JHDownMenuView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong)NSArray *ImageArray;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) JHDownMenuView *menuView;


@end

@implementation JHDownMenuView

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        
        [self addSubview:_tableView];
    }
    return _tableView;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor redColor];
        self.tableView.frame = CGRectMake(0, JHMargin, self.bounds.size.width, self.bounds.size.height - JHMargin);
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.showsHorizontalScrollIndicator = NO;
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.bounces = NO;
        self.tableView.layer.cornerRadius = 10;
        self.tableView.clipsToBounds = YES;
        [_tableView registerClass:[SearchTypeTVCell class] forCellReuseIdentifier:@"SearchTypeTVCell"];
        self.dataArray = @[@"商品",
                           @"实体店",
                           @"个人店",
                           @"厂家"];
    }
    self.ImageArray = @[@"shangpin", @"dianpu", @"gerendian", @"Searchchangjia"];
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SearchTypeTVCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchTypeTVCell" forIndexPath:indexPath];
    
    [cell titleImage:[UIImage imageNamed:self.ImageArray[indexPath.row]] titleStr:self.dataArray[indexPath.row]];
       
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if ([_delegate respondsToSelector:@selector(SearchTypeIndex:)]) {
        [_delegate SearchTypeIndex:(int)indexPath.row];
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return kFit(50);
}

- (void)drawRect:(CGRect)rect
{
    // 背景色
    [[UIColor redColor] set];
    
    // 获取视图
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // 开始绘制
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef, 20, self.tableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, 40, self.tableView.frame.origin.y);
    CGContextAddLineToPoint(contextRef, 30, self.tableView.frame.origin.y - JHMargin);
    // 结束绘制
    CGContextClosePath(contextRef);
    // 填充色
    
    [ MColor(73, 72, 75) setFill];
    // 边框颜色
    [MColor(73, 72, 75) setStroke];
    // 绘制路径
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
}

@end
