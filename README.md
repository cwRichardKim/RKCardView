RKCardView
==========
Beautiful Twitter / Facebook style cards (built with [@JaredTMoskowitz](https://twitter.com/jaredtmoskowitz))

This is a **template** for making beautiful cards

###Example
This is an example of a project that uses the repo

![Example](http://i.imgur.com/YVaSExwl.png)

##Standard Template:
This is what you get.  It starts with 2 defaukt example photos (of me)

![template](http://i.imgur.com/shA68PXl.png)

##Responsive Design!
Change the size and the card responds in turn

![responsive](http://i.imgur.com/KmG01Kql.png)
![responsive2](http://i.imgur.com/YVKSVvdl.png)

##Add blur!
```objc
[card addBlurToCoverPhoto:YES];
```
![blur](http://i.imgur.com/gA6Ahrdl.png)

##Usage
```obj-c
    RKCardView* cardView= [[RKCardView alloc]initWithFrame:CGRectMake(BUFFERX, BUFFERY, self.view.frame.size.width-2*BUFFERX, self.view.frame.size.height-2*BUFFERY)];
    
    cardView.coverImageView.image = [UIImage imageNamed:@"exampleCover"];
    cardView.profileImageView.image = [UIImage imageNamed:@"exampleProfile"];
    cardView.titleLabel.text = @"Richard Kim";
    [cardView addBlurToCoverPhoto:YES];
    [self.view addSubview:cardView];
```
