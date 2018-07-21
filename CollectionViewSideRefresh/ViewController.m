//
//  ViewController.m
//  CollectionViewSideRefresh
//
//  Created by DandJ on 2018/7/11.
//  Copyright © 2018年 DandJ. All rights reserved.
//

#import "ViewController.h"
#import "DefaultViewController.h"
#import "CustomViewController.h"
#import "HideItemViewController.h"
#import "EmptyFooterViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)clickDefault:(id)sender {
    DefaultViewController *defaultController = [self.storyboard instantiateViewControllerWithIdentifier:@"DefaultViewController"];
    [self.navigationController pushViewController:defaultController animated:YES];
}

- (IBAction)clickCustom:(id)sender {
    CustomViewController *customController = [self.storyboard instantiateViewControllerWithIdentifier:@"CustomViewController"];
    [self.navigationController pushViewController:customController animated:YES];
}

- (IBAction)clickShowHide:(id)sender {
    HideItemViewController *hideItemController = [self.storyboard instantiateViewControllerWithIdentifier:@"HideItemViewController"];
    [self.navigationController pushViewController:hideItemController animated:YES];
}
- (IBAction)clickEmptyFooter:(id)sender {
    EmptyFooterViewController *emptyFooterViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EmptyFooterViewController"];
    [self.navigationController pushViewController:emptyFooterViewController animated:YES];
}

@end
