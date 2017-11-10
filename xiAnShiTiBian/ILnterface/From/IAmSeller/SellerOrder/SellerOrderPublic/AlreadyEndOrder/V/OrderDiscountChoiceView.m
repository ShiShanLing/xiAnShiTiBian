//
//  OrderDiscountChoiceView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/2/6.
//  Copyright © 2017年 石山岭. All rights reserved.
//
#import "OrderDiscountChoiceView.h"

@interface OrderDiscountChoiceView ()<UIPickerViewDataSource, UIPickerViewDelegate, UIPickerViewAccessibilityDelegate>

@property (nonatomic, strong)NSArray *DiscountArray;

@property (nonatomic, strong)UIPickerView *pickerView;

@property (nonatomic, strong)NSString *discountSrr;

@end

@implementation OrderDiscountChoiceView

- (NSArray *)DiscountArray {
    if (!_DiscountArray) {
        _DiscountArray = @[@"不打",@"9.9", @"9.8", @"9.5", @"9.2", @"9.0", @"8.8"];
    }
    return _DiscountArray;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.discountSrr = @"不打";
        self.backgroundColor = [UIColor whiteColor];
        UIButton *completionBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [completionBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        completionBtn.tag = 131;
        [completionBtn addTarget:self action:@selector(handledetermineBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:completionBtn];
        completionBtn.sd_layout.rightSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(kFit(54)).heightIs(kFit(39));
        
        UIButton *cancelBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        [cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        cancelBtn.tag = 132;
        [cancelBtn addTarget:self action:@selector(handledetermineBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:cancelBtn];
        cancelBtn.sd_layout.leftSpaceToView(self, 0).topSpaceToView(self, 0).widthIs(kFit(54)).heightIs(kFit(39));

        self.pickerView = [UIPickerView new];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = MColor(238, 238, 238);
        _pickerView.showsSelectionIndicator = YES;
        [self addSubview:_pickerView];
        _pickerView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(completionBtn,0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
        
    }
    return self;
}
//返回有多少列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

    return 1;

}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

    NSLog(@"数组个数%ld数组内容%@", _DiscountArray.count, _DiscountArray);
    return self.DiscountArray.count;

}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [NSString stringWithFormat:@"%@折", self.DiscountArray[row]];
    
}

//返回当前的显示项
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.discountSrr =  self.DiscountArray[row];
    
}

//btn点击事件
- (void)handledetermineBtn:(UIButton *)sender {
    if (sender.tag == 132) {
        if ([_delegate respondsToSelector:@selector(deselect)]) {
            [_delegate deselect];
        }
    }
    if (sender.tag == 131) {
        if ([_delegate respondsToSelector:@selector(ChooseDiscount:)]) {
            [_delegate ChooseDiscount:self.discountSrr];
        }
    }
}


@end
