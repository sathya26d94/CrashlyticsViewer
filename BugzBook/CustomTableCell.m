//
//  DiscountsTableCell.m
//  QSR
//
//  Created by admin on 15/11/13.
//  Copyright (c) 2013 admin. All rights reserved.
//

#import "DiscountsTableCell.h"
#import "UITextField+TextField.h"
#import "GFConstants.h"
#import "GFCalculation.h"

#define TEXTFIELD_WIDTH 60
#define TEXTFIELD_HEIGTHT 45
#define TOP_PADDING 28//10
#define LEFT_PADDING 20
#define SEGMENT_WIDTH 80

@interface DiscountsTableCell()
@property(nonatomic)int cellWidth;
-(void)discountPercentLimitExceeded;
@end
@implementation DiscountsTableCell
@synthesize discountTextField;
@synthesize discountReasonTextField;
@synthesize discountSegmentControll;
@synthesize delegate;


#pragma mark -Initialize method
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
            andType:(NSNumber*)value size:(CGSize)cellSize type:(int)typeValue hasPermission:(BOOL)hasPermission
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _cellWidth=cellSize.width;
         self.discountTextField=[[GFTextField alloc]initWithFrame:CGRectMake(cellSize.width/2-2*TEXTFIELD_WIDTH+44,TOP_PADDING, TEXTFIELD_WIDTH, TEXTFIELD_HEIGTHT) type:GFTextFieldPercentType withLength:11 decimalLength:3];
        [self.discountTextField applyVariantTextFieldTheme];
        self.discountTextField.marginValue=0;
        [self addSubview:self.discountTextField];
        self.discountTextField.textAlignment=NSTextAlignmentCenter;
        [self.discountTextField textDidchangeBlock:^(UITextField *textField) {
           [self updateDiscountToObject];
        }];
        if([value intValue]==1){
            [self.discountTextField setDefaultsForMoneyFormatType];
        }
        self.discountTextField.maxPercentType=100;
        [self.discountTextField textDidBeginEditingBlock:^(UITextField *textField) {
            self.discountTextField.maxAmountType=[self.delegate totalAmountForRestrictDiscount];
        }];
        [self.discountTextField textDidchangeFailBlock:^(UITextField *textField, NSString *character) {
            [self discountPercentLimitExceeded];
        }];
        [self.discountTextField.layer setCornerRadius:CORNER_RADIUS];
        self.discountTextField.backgroundColor=LIGHT_WHITE_COLOR;
        [self.discountTextField.layer setBorderColor:TEXTBOX_BORDER_COLOR.CGColor];

        CGRect rectFrame=self.discountTextField.frame;
        rectFrame.origin.x=rectFrame.origin.x+self.discountTextField.frame.size.width+TOP_PADDING-15;
        rectFrame.size.width=SEGMENT_WIDTH;
        self.discountSegmentControll=[[UISegmentedControl alloc]initWithItems:@[[GFCommonObjects currencySymbolFromSettings],@"%"]];
        self.discountSegmentControll.frame=rectFrame;
        [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:HELVETICA_BOLD size:LOWMIN_FONT_SIZE], NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.discountSegmentControll.tintColor=BUTTON_SELECTED_BACKGROUND_COLOR;
        [self.discountSegmentControll addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
        
        if([value intValue]==1){
            [self.discountSegmentControll setSelectedSegmentIndex:0];
        } else {
            [self.discountSegmentControll setSelectedSegmentIndex:1];
        }
        [self addSubview:self.discountSegmentControll];
        
        int restictedLength=100;
        if (typeValue==1) {
            restictedLength=500;
        }else{
            [self.discountTextField becomeFirstResponder];
        }
        self.discountReasonTextField=[[GFTextField alloc]initWithFrame:CGRectMake(2*LEFT_PADDING,self.discountTextField.frame.origin.y+self.discountTextField.frame.size.height+TOP_PADDING-15,cellSize.width-80,TEXTFIELD_HEIGTHT-15) type:GFTextFieldStrAndNumWithCustomSpecialType withLength:restictedLength decimalLength:0];
        self.discountReasonTextField.customSpecialSymbols=NORMAL_TEXTFIELD_VALIDATION;
        self.discountReasonTextField.marginValue=5;
        [self.discountReasonTextField applyVariantTextFieldTheme];
        [self addSubview:self.discountReasonTextField];
        
        [self.discountReasonTextField textDidchangeBlock:^(UITextField *textField) {
            if (self.delegate&&[self.delegate respondsToSelector:@selector(discountReason:)]){
                [self.delegate discountReason:textField.text];
            }
        }];
        [self.discountReasonTextField.layer setCornerRadius:4.0f];
        self.discountReasonTextField.backgroundColor=LIGHT_WHITE_COLOR;
        [self.discountReasonTextField.layer setBorderColor:TEXTBOX_BORDER_COLOR.CGColor];
        self.discountReasonTextField.placeholder=LOC_STR(@"DiscountPlaceHolder",nil);
        
        if(!hasPermission){

            self.securityButton=[[GFButton alloc] initWithFrame:CGRectMake((self.discountSegmentControll.frame.origin.x+self.discountSegmentControll.frame.size.width+TOP_PADDING-15), self.discountSegmentControll.frame.origin.y+((self.discountSegmentControll.frame.size.height-(TEXTFIELD_HEIGTHT-10))/2), SEGMENT_WIDTH+TEXTFIELD_HEIGTHT, TEXTFIELD_HEIGTHT-10)];
            
            UILabel *lockIcon=[[UILabel alloc]init];
            lockIcon.font = [UIFont fontWithName:GFFontFamilyName size:TWENTY_FONT_SIZE];
            lockIcon.textColor=BUTTON_SELECTED_BACKGROUND_COLOR;
            lockIcon.text=[NSString fontIconStringForEnum:GFLockWithHoleIcon];
            lockIcon.textAlignment=NSTextAlignmentCenter;
            lockIcon.frame=CGRectMake(5,0,TOP_PADDING,TOP_PADDING);
            [self.securityButton addSubview:lockIcon];
   
            [self.securityButton setTitle:LOC_STR(@"TapToUnlock", @"") forState:UIControlStateNormal];
           
            [self.securityButton.layer setBorderColor:VARIANT_BORDER_COLOR.CGColor];
            [self.securityButton.layer setBorderWidth:1.0f];
            [self.securityButton.layer setCornerRadius:CORNER_RADIUS];
            [self.securityButton setBackgroundColor:BASE_BACKGROUND_COLOR forState:UIControlStateNormal];
            [self.securityButton setBackgroundColor:ADD_CUSTOMER_HIGHLIGHT_COLOR forState:UIControlStateHighlighted];
            
            
            self.securityButton.titleLabel.font=[UIFont fontWithName:HELVETICA size:LOWMIN_FONT_SIZE];
            self.securityButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            self.securityButton.titleEdgeInsets=UIEdgeInsetsMake(0, 0, 0, 10);
            [self.securityButton setTitleColor:BUTTON_SELECTED_BACKGROUND_COLOR forState:UIControlStateNormal];

            
            [self.securityButton addTarget:self action:@selector(securityButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:self.securityButton];
            [self bringSubviewToFront:self.securityButton];
            
            [self.discountReasonTextField setEnabled:NO];
            [self.discountSegmentControll setEnabled:NO];
            [self.discountTextField setEnabled:NO];
            
            [self.discountSegmentControll setAlpha:0.3];
            [self.discountTextField setAlpha:0.3];
            [self.discountReasonTextField setAlpha:0.3];
        }

    }
    return self;
}
-(void)updateSegmentIndex:(NSNumber*)discType{
    if ([discType intValue]==1) {
        [self.discountSegmentControll setSelectedSegmentIndex:0];
    }else{
        [self.discountSegmentControll setSelectedSegmentIndex:1];
    }
}
-(void)updateDiscAmounts:(NSNumber*)number notes:(NSString*)notes{
  
    if(self.discountTextField.fieldType==GFTextFieldMoneyFormatType){
        if ([number doubleValue]<=0) {
            self.discountTextField.text=[[@0.0 currencyFormatFromNumber] showCurrencySymbol];
        }else{
            self.discountTextField.text=[[number currencyFormatFromNumber] showCurrencySymbol];
        }
    }else{
        if ([number doubleValue]<=0) {
            self.discountTextField.text=@"0";
        }else{
            self.discountTextField.text=[NSString stringWithFormat:@"%@",[number roundOffWithTwodigitsAsString]];
        }
    }
    
    [self updateFrame];
    
    self.discountReasonTextField.text=notes;
}

-(void)updateFrame{
    CGSize textSize =[self.discountTextField.text sizeWithAttributes:
                      @{NSFontAttributeName:
                            self.discountTextField.font}];
    CGRect textRect=self.discountTextField.frame;
    
    CGRect segmentRect=self.discountSegmentControll.frame;
    segmentRect.size.width=SEGMENT_WIDTH;
    
    if (textSize.width>=TEXTFIELD_WIDTH-20){
        textRect.size.width=textSize.width+20;
    }else{
        textRect.size.width=TEXTFIELD_WIDTH;
    }
    
    textRect.origin.x=((_cellWidth-textRect.size.width-segmentRect.size.width-10)/2);
    self.discountTextField.frame=CGRectIntegral(textRect);
    
    segmentRect.origin.x=textRect.origin.x+textRect.size.width+10;
    self.discountSegmentControll.frame=CGRectIntegral(segmentRect);

}

-(void)removeFromSuperview{
   
    [self.discountTextField removeFromSuperview];
    [self.discountReasonTextField removeFromSuperview];
    [super removeFromSuperview];
}
#pragma mark -Private methods
-(void)segmentChanged:(id)sender{
    if ([sender selectedSegmentIndex]==0) {
        [self.discountTextField setDefaultsForMoneyFormatType];
        self.discountTextField.text=[[@0.0 currencyFormatFromNumber] showCurrencySymbol];
    }else{
        self.discountTextField.currencySymbol=nil;
        self.discountTextField.fieldType=GFTextFieldPercentType;
        self.discountTextField.text=@"0";
    }
    [self updateDiscountToObject];
}
-(void)updateDiscountToObject{
    double discountValue;
    
    if(self.discountSegmentControll.selectedSegmentIndex==0){
        discountValue=[[self.discountTextField.text withoutCurrencyValue] doubleValue];
    }else{
        discountValue=[self.discountTextField.text doubleValue];
    }
    
    [self.delegate discAmountForValue:[NSNumber numberWithDouble:discountValue] value:self.discountSegmentControll.selectedSegmentIndex==0?YES:NO];
    [self updateFrame];
}
-(void)securityButtonPressed:(id)sender{
    [GFSecurityObject checkForAuthorization:^(id object) {
        if([object isEqualToString:SUCCESS]){
            [self.discountReasonTextField setEnabled:YES];
            [self.discountSegmentControll setEnabled:YES];
            [self.discountTextField setEnabled:YES];
            [self.discountSegmentControll setAlpha:1];
            [self.discountTextField setAlpha:1];
            [self.discountReasonTextField setAlpha:1];
            [self.securityButton removeFromSuperview];
        }
    } forFunctionName:GFSecurityDiscountFunction];
}
-(void)discountPercentLimitExceeded{
    if(self.discountSegmentControll.selectedSegmentIndex==1){
        if(![self.discountTextField.text containsString:@"."] && [self.discountTextField.text doubleValue]>0)
            [GFCommonObjects displayAlertWithTitle:LOC_STR(@"Info",nil) message:LOC_STR(@"DiscountPercentLimit",nil)];
    }else
        [GFCommonObjects displayAlertWithTitle:LOC_STR(@"Info",nil) message:LOC_STR(@"DiscountAmountLimit",nil)];
}
#pragma mark -dealloc
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
   // NSLog(@"dealloc method of %@",[self class]);
}

@end
