//
//  ISShowFullPhotoVC.m
//  500PXapp
//
//  Created by Smirnov Ivan on 17.11.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "ISShowFullPhotoVC.h"

@interface ISShowFullPhotoVC ()<UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *viewScrolView;

@end

@implementation ISShowFullPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.viewScrolView.delegate=self;
    self.viewScrolView.minimumZoomScale=1.f;
    self.viewScrolView.maximumZoomScale=5.f;
    [self.viewScrolView setClipsToBounds:YES];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark-UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    
    return self.photo;
    
    
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
