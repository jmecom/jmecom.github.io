---
layout: page
title: "Image alignment with pyramids"
date: 2016-02-04
---

View the repository [here](https://github.com/jmecom/image-pyramid).

### Problem

The Prokudin-Gorskii image collection from the Library of Congress is a series of glass plate negative photographs taken by Sergei Mikhailovich Prokudin-Gorskii. To view these photographs in color digitally, one must overlay the three images and display them in their respective RGB channels. However, due to the technology used to take these images, the three photos are not perfectly aligned. The goal of this project is to automatically align, clean up, and display a single color photograph from a glass plate negative.

___

### Algorithm

I developed two algorithms to align images from the collection: `single-scale alignment` and `multi-scale alignment` using Gaussian image pyramids. Single scale alignment is, essentially, brute force. The algorithm specifically does the following

{% highlight python %}
single_scale_align:
  automatically crop the solid white border and fuzzy black border
  split the image into three separate images, one for each channel
  find the best shift for the green and red channels to align them with the blue
  perform the alignment and merge the images 
{% endhighlight %}

I used two different methods to find the best shift. The first (called `findshift`) simply tries to align an image with an anchor (the blue channel) by testing all possible displacements within a range, scoring each displacement, and using the best. The score is calculated by taking the sum of squared difference between the two images. The optimal score for this error function is zero: an image's sum of squared difference with itself is zero.

The second (called `findshift_edges`) is very similar, but instead of scoring the images directly it first creates binary images highlighting the edges using Canny edge detection. It then scores, still using sum of squred differences, the edge detected images. This approach almost always worked better.

Multi-scale alignment is very similar to single-scale. The only difference is that the best shift is found using image pyramids.

In pseudocode, the pyramid shift finding algorithm works as follows

{% highlight python %}
pyramid_find_shift (anchor image A, shifted image S, pyramid depth N):
  if N is 0, 
    let best_shift be the result of findshift_edges(A, S, 15)
  else,
    Gaussian blur and resize A and S by a factor of 2

    let best_shift be the result of pyramid_find_shift(scaled A, scaled S, N-1)
    multiply best_shift by 2
    circularly shift S by best_shift 

    let best_shift be best_shift + findshift_edges(A, S, 2)
{% endhighlight %}

### Performance

The performance of the algorithms is summarized in the table below.

|                | Single-scale  | Multi-scale
: ------------- :|:-------------:|: ----------:
| findshift      | 5 seconds     | 8 seconds
| findshift_edges| 34 seconds    | 92 seconds

Edge detection greatly slows the algorithm down, but for certain images gives better results. This is discussed further in the extra-credit section below.

___

### Results

#### Single-scale alignment

Unaligned             |  Aligned
:-------------------------:|:-------------------------:
![]({{ jmecom.github.io }}/images/gorskii-collection/un-field.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/field.jpg)
![]({{ jmecom.github.io }}/images/gorskii-collection/un-girl.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/girl.jpg)
![]({{ jmecom.github.io }}/images/gorskii-collection/un-house.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/house.jpg)
![]({{ jmecom.github.io }}/images/gorskii-collection/un-tzar.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/tzar.jpg)

#### Multi-scale alignment

Unaligned images are displayed before aligned images. To view full images, right click and "view image". 

![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-town.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-town.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-church.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-church.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-guy.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-guy.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-field.jpg)  
![]({{ jmecom.github.io }}/images/gorskii-collection/big-field.jpg)
![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-3girls.jpg) 
![]({{ jmecom.github.io }}/images/gorskii-collection/big-3girls.jpg) 
![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-river.jpg) 
![]({{ jmecom.github.io }}/images/gorskii-collection/big-river.jpg) 
![]({{ jmecom.github.io }}/images/gorskii-collection/big-un-tzar.jpg) 
![]({{ jmecom.github.io }}/images/gorskii-collection/big-tzar.jpg) 

___

### Extra credit

All of the images above use the extra credit discussed below.

#### Automatic cropping

Separate methods were used to crop the white and black borders. The white border for each image was solid and relatively consistent, so I just created an all-white image of the same size, found the absolute difference between the two images and then used that to calculate the bounding box for cropping. Removing the black borders was done as follows
{% highlight python %}
remove_black_borders(img, threshold, range):
  convert the image to black and white 
  complement the image
  for each edge
    for each 1 pixel column (left, right) or row (top, bottom) within range
      if sum(white pixels) / (length of edge) > threshold
        mark this column/row as cropping point
    crop
{% endhighlight %}

#### Better features: alignment using edges

I discussed `findshift_edges` above, however one image in particular is interesting in that the alignment is substantially better when using edges vs regular `findshift` but only if the image is not cropped beforehand. The result is below.

Uncropped, `findshift`             |  Uncropped, `findshift_edges`
:-------------------------:|:-------------------------:
![]({{ jmecom.github.io }}/images/gorskii-collection/uncropped-findshift-girl.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/uncropped-edges_findshift-girl.jpg)

The difference is not as great when the images are cropped first. The most likely explanation for `findshift`'s failure is an attempt to line up border colors that overpowers the attempt to line up the actual image. `findshift_edges` probably detects the edges of the girl very effectively and values lining her up more. 

It's also worth noting that I tried other edge detection algorithms, such as Sobel, but Canny seemed to have the best results.

### Fake glass negatives

I used Photoshop to create fake glass negatives from photos that I took in San Francisco. The result of running my algorithm on these images is below.

Unaligned            |  Aligned
:-------------------------:|:-------------------------:
![]({{ jmecom.github.io }}/images/gorskii-collection/un-sf1.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/sf1.jpg)
![]({{ jmecom.github.io }}/images/gorskii-collection/un-hayes.jpg)  |  ![]({{ jmecom.github.io }}/images/gorskii-collection/hayes.jpg)

### Analysis and conclusion

Overall, the algorithms perform quite well especially when edge detection is used. Some images above don't quite have perfect results, such as the man in the field, but do better than not aligning at all. The most notable failure case was the one described above in extra-credit of the girl standing in the field. However, after cropping and edge detection is added, that photo ends up being one of the best aligned images.

If I were to try to improve the algorithm, I'd like to try the following

* 1) Better cropping. The cropping of the fuzzy black borders was okay, but could be improved.

* 2) Recoloration. Many photos have distorted colors, so automatically rebalancing the colors could noticable improve image quality.

