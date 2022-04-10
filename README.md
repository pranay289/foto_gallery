- Foto gallery package will help you to create reactive image slider.
- For state management the `foto_gallery` package uses `GetX`.
- You can also slide images using the keyboard.

## Using

To import foto_gallery package.

```
import 'package:foto_gallery/app/ui/pages/foto_gallery_page.dart';
```
The easiest way to use this package is if you are using listview then it will more easy for you.
Here is example code.

```dart

import 'package:flutter/material.dart';
import 'package:foto_gallery/app/ui/pages/foto_gallery_page.dart';

ListView.builder(
        itemCount: imageList.length,
        itemBuilder: ((context, index) {
          return Container(
            height: 300,
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FotoGallery(
                image: imageList[index],
                imageList: imageList,
                imgurl: imageList[index],
                index: index,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      ),

```
- If you can observe there are two options one is `image` and another one is `imgurl`.
- The `image: imageList[index]` is used to provide a unique tag to the hero widget.
- The other one which is `imgurl:imageList[index]` is use to provide imageUrl.

```
FotoGallery(

     image: imageList[index], // To provide unique tag
     imageList: imageList,
     imgurl: imageList[index],
     index: index,
     fit: BoxFit.cover,
 ),
```

