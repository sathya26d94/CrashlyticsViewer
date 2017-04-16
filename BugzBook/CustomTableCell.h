//
//  DiscountsTableCell.h
//  QSR
//
//  Created by admin on 15/11/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SaleItems.h"


typedef enum{
    ModifierDiscountCellType=0,
    MoreDiscountCellType
}DiscountCellType;



@protocol DiscountsTableCellDelegate <NSObject>
-(void)discAmountForValue:(NSNumber*)number value:(BOOL)value;
-(void)discountReason:(NSString*)notes;
-(double)totalAmountForRestrictDiscount;
@end

@interface DiscountsTableCell : UITableViewCell
@property(nonatomic,strong)GFTextField *discountTextField;
@property(nonatomic,strong)UISegmentedControl *discountSegmentControll;
@property(nonatomic,strong)GFTextField *discountReasonTextField;
@property(nonatomic,strong)GFButton *securityButton;
@property(nonatomic,weak)id<DiscountsTableCellDelegate>delegate;
-(void)updateDiscAmounts:(NSNumber*)number notes:(NSString*)notes;
-(void)updateSegmentIndex:(NSNumber*)discType;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
            andType:(NSNumber*)value size:(CGSize)cellSize type:(int)typeValue hasPermission:(BOOL)hasPermission;
@end
