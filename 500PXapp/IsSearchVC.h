//
//  IsSearchVC.h
//  500PXapp
//
//  Created by Максим Стегниенко on 20.10.16.
//  Copyright © 2016 techpark_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IsSearchVC : UIViewController <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *searchField;

- (IBAction)actionTextField:(UITextField *)sender ;

-(IBAction)cancelButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *appearConstrain;




@end
