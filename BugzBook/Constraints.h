//
//  Constraints.h
//  QSR
//
//  Created by Valli on 6/14/16.
//  Copyright (c) 2016 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GFNavigationBar.h"
#import "GFRecallAdvanceOrderTableViewCell.h"
#import "GFProductViewController.h"
#import "GFHeaderView.h"
#import "GFSelectionViewController.h"
#import "GFTransactionHeaderView.h"
#import "GFRecallHoldSaleTableViewCell.h"
#import "GFToggleButton.h"

@interface GFNavigationBar (Constraints)
- (void)addConstraints;
@end
@interface GFRecallAdvanceOrderTableViewCell (Constraints)
-(void)addconstraintsForRecallAdvanceOrderLabels;
@end
@interface GFRecallHoldSaleTableViewCell(Constraints)
-(void)addconstraintsForRecallHoldSaleLabels;
@end
@interface GFHeaderView (Constraints)
-(void)addconstraintsToHeaderViewLabelsForType:(GFRecallModalType)modalType;
@end
@interface GFProductViewController(Constraints)
-(void)addconstraintsToSelectionModalDisplay:(GFRecallModalType)modalType;
@end
@interface GFSelectionViewController(Constraints)
-(void)addconstraintsToSelectionModalElements;
@end
@interface GFTransactionHeaderView(Constraints)
-(void)addconstraintsToLabel;
@end
@interface GFToggleButton(Constraints)
-(void)addConstraintsToToggle;
-(void)addConstraintsToMainItemLabel;
@end
