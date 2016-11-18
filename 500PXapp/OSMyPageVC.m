//
//  OSMyPageVC.m
//  500PXapp
//
//  Created by user on 13.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "OSMyPageVC.h"

@interface OSMyPageVC ()

@end

@implementation OSMyPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self imagesLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) imagesLoad {
    
    NSURL *urlForMiniature = [[NSURL alloc] initWithString:@"http://lorempixel.com/300/300/"];
    NSData* dataForMiniature = [[NSData alloc] initWithContentsOfURL:urlForMiniature];
    self.miniature.image = [UIImage imageWithData:dataForMiniature];
    
    NSData* dataForAvatar = [NSData dataWithContentsOfURL:
                                [NSURL URLWithString:
                                 [NSString stringWithFormat:
                                  @"http://lorempixel.com/%f/%f", self.miniature.image.size.width,self.miniature.image.size.height]]];
    self.avatar.image = [UIImage imageWithData:dataForAvatar];
    
    
//    let imageData = try! Data(contentsOf: URL(string: "http://lorempixel.com/310/310")!)
//    imageView.image = UIImage(data: imageData)
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
