RKCardView
==========
Beautiful Twitter / Facebook style cards (built with [@JaredTMoskowitz](https://twitter.com/jaredtmoskowitz))

[Follow me on Twitter @cwRichardKim](https://twitter.com/cwRichardKim)

Or [Check out my Medium posts on UI / UX](https://medium.com/@cwRichardKim)

This is a **template** for making beautiful cards

![Anatomy](http://i.imgur.com/bRZpKIZ.png)

![Methods](http://i.imgur.com/j86bi2u.png)

##Responsive Design!
Change the size and the card responds in turn

![responsive](http://i.imgur.com/JjogZGtl.png)
![responsive2](http://i.imgur.com/shA68PXl.png)

##Examples
An example of RKCardView used in a real project

![Example](http://i.imgur.com/YVaSExwl.png)

##Usage
__Pod__
```objc-c
pod 'RKCardView'
```

```obj-c
    RKCardView* cardView= [[RKCardView alloc]initWithFrame:CGRectMake(x origin, y origin, card width, card height)];
    
    cardView.coverImageView.image = [UIImage imageNamed:@"your cover photo"];
    cardView.profileImageView.image = [UIImage imageNamed:@"your profile picture"];
    cardView.titleLabel.text = @"Richard Kim";
    [cardView addBlur]; // comment this out if you don't want blur
    [cardView addShadow]; // comment this out if you don't want a shadow
    [self.view addSubview:cardView];
```

### Areas for Improvement / Involvement
* More rigorous responsive design (making it look nicer with a wider range of dimensions)
* Other custom properties (eg: tap to expand, double sided, tap to flip)
