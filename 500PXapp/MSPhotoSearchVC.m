//
//  MSPhotoSearchVC.m
//  500PXapp
//
//  Created by Максим Стегниенко on 18.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "MSPhotoSearchVC.h"
#import "IsSearchVC.h"
#import "UIImageView+AFNetworking.h"
@interface MSPhotoSearchVC ()

@end

@implementation MSPhotoSearchVC


-(UIStatusBarStyle) preferredStatusBarStyle {
    
    return  UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
  //  [self.navigationBar setTintColor:[UIColor redColor]];
    //self.navigationItem.titleView = nil ;
    
  //  MSPhotoSearchVC *vc = [[MSPhotoSearchVC alloc] init];
    
    self.label.text = self.str;
    [self.imagePhoto setImageWithURL:self.url];
    NSLog(@"%@",self.str);
    [ self.navigationBar setBackgroundImage:[UIImage imageNamed:@"Rectangle48@2x.png"] forBarMetrics:UIBarMetricsDefault];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)backbutton:(id)sender {
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
