//
//  Constraints.m
//  QSR
//
//  Created by Valli on 6/14/16.
//  Copyright (c) 2016 admin. All rights reserved.
//

#import "Constraints.h"
#import "Masonry.h"

@implementation GFToggleButton(Constraints)

-(void)addConstraintsToToggle{
    if (self.priceLabel) {
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-GAP_SPACING);
            make.left.greaterThanOrEqualTo(self.nameLabel.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo([NSNumber numberWithInt:25]);
        }];
    }
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(LEFT_PADDING);
        make.right.lessThanOrEqualTo(self.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo(self.mas_height);
    }];
}

-(void)addConstraintsToMainItemLabel{
    [self.mainItemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-GAP_SPACING);
        make.top.equalTo(self.nameLabel.mas_top).with.offset(GAP_SPACING);
        make.width.equalTo([NSNumber numberWithInt:15]);
        make.height.equalTo([NSNumber numberWithInt:15]);
    }];
    
}

@end

@implementation GFNavigationBar (Constraints)

- (void)addConstraints {
    
    [self.menuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(GAP_SPACING);
        make.bottom.equalTo(self.mas_bottom).with.offset(-EDGE_SPACING);
        make.width.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
    }];
    [self.backbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(GAP_SPACING);
        make.bottom.equalTo(self.mas_bottom).with.offset(-EDGE_SPACING);
        make.width.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
    }];
    [self.walkthroughButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-EDGE_SPACING);
        make.bottom.equalTo(self.mas_bottom).with.offset(-EDGE_SPACING);
        make.width.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
    }];
    [self.syncButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.walkthroughButton.mas_left).with.offset(-EDGE_SPACING/2);
        make.bottom.equalTo(self.mas_bottom).with.offset(-EDGE_SPACING);
        make.width.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:STD_BUTTON_WIDTH]);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).with.offset(-EDGE_SPACING*2);
        make.width.equalTo([NSNumber numberWithInt:LABEL_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:LABEL_HEIGHT]);
    }];
}
@end

@implementation GFRecallAdvanceOrderTableViewCell (Constraints)
-(void)addconstraintsForRecallAdvanceOrderLabels {
    [self.orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.orderNoLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.top.equalTo(self.mas_top).with.offset(EDGE_SPACING);
        make.width.equalTo([NSNumber numberWithInt:LARGE_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:TEXT_HEIGHT]);
    }];
    [self.customerMobileIcon mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.orderNoLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.top.equalTo(self.customerNameLabel.mas_bottom);
        make.width.equalTo([NSNumber numberWithInt:TEXT_HEIGHT]);
        make.height.equalTo([NSNumber numberWithInt:TEXT_HEIGHT]);
    }];
    [self.customerMobileLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.customerMobileIcon.mas_right);
        make.top.equalTo(self.customerNameLabel.mas_bottom);
        make.width.equalTo([NSNumber numberWithInt:LARGE_TEXT_WIDTH-LARGE_GAP_SPACING]);
        make.height.equalTo([NSNumber numberWithInt:TEXT_HEIGHT]);
    }];
    [self.deliveryTimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.customerNameLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.deliveryTimeLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.advanceAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.totalAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.balanceAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.advanceAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.print mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.balanceAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:RECALL_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.email mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.print.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:RECALL_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.email.mas_right);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:RECALL_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.highlightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
    [self.tickLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.highlightView.mas_centerX);
        make.centerY.equalTo(self.highlightView.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:FIFTY_LENGTH]);
        make.height.equalTo([NSNumber numberWithInt:FIFTY_LENGTH]);
    }];


}
@end

@implementation GFRecallHoldSaleTableViewCell (Constraints)
-(void)addconstraintsForRecallHoldSaleLabels {
    [self.invoiceNoLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH+EDGE_SPACING]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.invoiceNoLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:LARGE_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
    [self.createdTimeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.customerNameLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.createdTimeLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH+TEXT_HEIGHT]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
    [self.orderTypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.totalAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH+EDGE_SPACING]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.orderTypeLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:RECALL_BUTTON_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SELECTION_VIEW_ROW_HEIGHT]);
    }];
}
@end

@implementation GFHeaderView (Constraints)
-(void)addconstraintsToHeaderViewLabelsForType:(GFRecallModalType)modalType{
    int spacing=0;
    if(modalType==GFHoldType){
        spacing=EDGE_SPACING;
        [self.orderTypeLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.totalAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH+EDGE_SPACING]);
            make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
        }];
    }else{
        [self.advanceAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.totalAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
            make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
        }];
        [self.balanceAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.equalTo(self.advanceAmountLabel.mas_right).with.offset(LARGE_GAP_SPACING);
            make.centerY.equalTo(self.mas_centerY);
            make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
            make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
        }];
    }
    [self.orderNoLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.mas_left).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH+spacing]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
    [self.customerDetailLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.orderNoLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:LARGE_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.customerDetailLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
    [self.totalAmountLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.timeLabel.mas_right).with.offset(LARGE_GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo([NSNumber numberWithInt:SMALL_TEXT_WIDTH+(2*spacing)]);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
}
@end

@implementation GFProductViewController(Constraints)
-(void)addconstraintsToSelectionModalDisplay:(GFRecallModalType)modalType{
    int modalHeight,modalWidth;
    if(modalType==GFHoldType){
        modalWidth=RECALL_HELD_MODAL_WIDTH;
        modalHeight=RECALL_HELD_MODAL_HEIGHT;
    }else{
        modalWidth=RECALL_ORDER_MODAL_WIDTH;
        modalHeight=RECALL_ORDER_MODAL_HEIGHT;
    }
    [self.gfselectionViewController.view mas_makeConstraints:^(MASConstraintMaker *make){
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).with.offset(SECTION_HEADER_HEIGHT);
        make.width.equalTo([NSNumber numberWithInt:modalWidth]);
        make.height.equalTo([NSNumber numberWithInt:modalHeight]);
    }];
}
@end

@implementation GFSelectionViewController(Constraints)
-(void)addconstraintsToSelectionModalElements{
    [self.popoverTopBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.height.equalTo([NSNumber numberWithInt:TOP_BAR_HEIGHT]);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.popoverTopBar.titleLable.mas_centerX);
        make.bottom.equalTo(self.popoverTopBar.mas_bottom);
        make.height.equalTo([NSNumber numberWithInt:TEXT_HEIGHT]);
    }];
}
@end

@implementation GFTransactionHeaderView(Constraints)
-(void)addconstraintsToLabel{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(EDGE_SPACING+GAP_SPACING);
        make.centerY.equalTo(self.mas_centerY);
        make.height.equalTo([NSNumber numberWithInt:SECTION_HEADER_HEIGHT]);
    }];
}
@end
