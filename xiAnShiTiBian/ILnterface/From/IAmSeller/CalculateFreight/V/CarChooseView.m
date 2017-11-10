
//
//  CarChooseView.m
//  EntityConvenient
//
//  Created by 石山岭 on 2017/1/18.
//  Copyright © 2017年 石山岭. All rights reserved.
//

#import "CarChooseView.h"

@interface CarChooseView () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *FPickerView;
@property (nonatomic, strong)NSMutableDictionary  *StoreCarDic;

@end

@implementation CarChooseView
- (NSMutableDictionary *)StoreCarDic {
    if (!_StoreCarDic) {
        _StoreCarDic = [NSMutableDictionary dictionary];
    }
    return _StoreCarDic;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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
        
        self.FPickerView = [UIPickerView new];
        _FPickerView.delegate = self;
        _FPickerView.dataSource = self;
        _FPickerView.backgroundColor = MColor(238, 238, 238);
        _FPickerView.showsSelectionIndicator = YES;
        [self addSubview:_FPickerView];
        _FPickerView.sd_layout.leftSpaceToView(self, 0).topSpaceToView(completionBtn,0).rightSpaceToView(self, 0).bottomSpaceToView(self, 0);
    }
    return self;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _DataArray.count;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.StoreCarDic = self.DataArray[row];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return _DataArray[row][@"carType"];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumFontSize = 8.;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:UITextAlignmentCenter];
        [pickerLabel setBackgroundColor:MColor(238, 238, 238)];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:kFit(18)]];
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

//btn点击事件
- (void)handledetermineBtn:(UIButton *)sender {
    if (sender.tag == 132) {
    if ([_delegate respondsToSelector:@selector(deselect)]) {
        [_delegate deselect];
        }
    }
    if (sender.tag == 131) {
    if ([_delegate respondsToSelector:@selector(ChooseCar:)]) {
        [_delegate ChooseCar:self.StoreCarDic];
        }
    }
}

@end
