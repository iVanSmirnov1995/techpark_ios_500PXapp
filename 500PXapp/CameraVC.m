//
//  CameraVC.m
//  500PXapp
//
//  Created by Максим Стегниенко on 20.12.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import "CameraVC.h"

@interface CameraVC ()  <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)showCamera:(UIButton *)sender {
    
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}
- (IBAction)showPhotos:(UIButton *)sender {
    
    [self showImagePickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.sourceType = sourceType;
    
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
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
