//
//  ViewController.m
//  NNAMultilevelTree
//
//  Created by NNA on 16/5/17.
//  Copyright © 2016年 Leben.NNA. All rights reserved.
//

#import "ViewController.h"
#import "NNATreeView.h"

@interface ViewController ()  {
    NSMutableArray *_nodesArray;
}

@property (nonatomic, strong) NNATreeView *treeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _nodesArray = @[].mutableCopy;
    
    [self loadData];
    [self buildTree];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadData {
    NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:dataPath];
    NSArray *dataArray = [dataDic objectForKey:@"nodes"];
    for (NSDictionary *nodeDic in dataArray) {
        NNATreeNode *node = [[NNATreeNode alloc] init];
        node = [NNATreeNode dataWithTreeNode:node children:nodeDic depth:0];
        node.parent = nil;
        [_nodesArray addObject:node];
    }
}

- (void)buildTree {
    _treeView = [[NNATreeView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:_treeView];
    _treeView.dataArray = _nodesArray;
    
}

@end
