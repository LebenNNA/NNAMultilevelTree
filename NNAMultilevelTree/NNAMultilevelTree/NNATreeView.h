//
//  NNATreeView.h
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNATreeView : UITableView

- (void)insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;
- (void)deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths;

@end
