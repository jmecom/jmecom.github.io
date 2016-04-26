---
layout: page
title: Proposal - Image Analogies
tags: [comp-photo, image, analogies, matlab]
date: 2016-04-26
---

*Proposed by Jordan Mecom, Alice Wang, and Will Hardy.*

### Proposal
We plan to to implement [image analogies](http://mrl.nyu.edu/publications/image-analogies/), which is a framework for processing images by example. The algorithm takes in 3 inputs: A, A' and B and aims to output B' so that A' and B' are analagous (A:A' :: B:B').

Image analogies has many different applications, such texture synthesis, style-transfer, image colorization, and more. Because each application requires some modifications to the general algorithm, we'll develop this project in stages. 

First, we'll implement toy filters (blurring, embossing, etc.) to ensure our algorithm works. Our mian goal is to implement style transfer / artistic filters. From there, we can work on other applications, depending on time. We probably have more ideas here than time to implement them well, so we appreciate any feedback letting us know which ideas have potential.

### Input data and expected results

Below are examples for input data. We'll test originally on data found [here](http://mrl.nyu.edu/projects/image-analogies/tf.html). Once these work, we can try more original inputs. Some ideas are below, progressing from easier to harder (stretch goals). 

#### Instagram filters

Instagram provides some simple filters that we can try to recreate on various images. We expect the algorithm to perform very well on these, since they aren't much different from toy filters.

A, A': ![A and A'](http://i.imgur.com/3NJF8sf.jpg)

#### Complex artistic filters

A: ![A](http://i.imgur.com/8EuKPjU.jpg)

A': ![A'](http://i.imgur.com/MeUQMcx.jpg)

B: ![B](http://i.imgur.com/HU2ZHoD.jpg)

This example will attempt to render the photograph of the field and clouds in the style of the input painting. We aren't sure how the algorithm will perform here, but we don't expect the result to be particularly true to the input photograph. The brush strokes and colors may be captured, but the output may end up being too abstract.

A: ![A](http://i.imgur.com/cjJixr3.png)

A': ![A'](http://i.imgur.com/a9Yz1tJ.png)

B: ![B](http://i.imgur.com/186CK94.jpg)

This comic book filter should do pretty well, since it's somewhat similar to artistic styles (such as line art and stippling) found on the original project page. The main concern here is that the texture and line art styles applied to the input image may "interfere" with each other. 

#### Video game re-rendering

A: ![A](http://i.imgur.com/Du6HmQd.jpg)

A': ![A'](http://i.imgur.com/v53QM07.jpg)

B: ![B](http://i.imgur.com/y7luWu1.png)

Our idea here is to re-render a video game in the style of another. Algorithmically this is the same as style transfer, but since the input data is computer generated the results may be perceived differently. We don't think this will work that well. With style transfer, the input is typically artistic, so the output can be interpreted in many different ways. In other words, there aren't really "mistakes". Here, however, we think the result will either be (1) totally mangled or (2) contain too many visual discontinuities.

We will also try more similar scenes between games. Optimally, we could find the same scene rendered in two different game engines, but it may be difficult to find this.

#### Image recolorization

A: ![A](http://i.imgur.com/kTj7yYZ.jpg)
A': ![A'](http://i.imgur.com/JUbj0ke.jpg)
B: ![B](http://i.imgur.com/Gbg4ml6.jpg)

Another application for this paper is image recolorization. This is different from style transfer, but discussed in the paper, so we should be able to get nice results.


#### Miniature faking (tilt shift photography)

A: ![A](http://i.imgur.com/bt0RWjG.jpg)
A': ![A'](http://i.imgur.com/bjYCJul.jpg)

Filters can be manually used to create fake miniature images. We'll attempt to feed an original image and a faked miniature to the image analogies framework. This application isn't discussed in the original paper at all, so it will require a lot of experimentation to work well. We think that with carefully chosen inputs we can achieve good results. Some important characteristics of input photographs is that they're (1) looking down on a scene, (2) colorful, and (3) have a range of depth. Of our novel ideas, we think this is the most promising in terms of having good looking results.

#### Face blushes

A and A': 
![A and A'](http://i.imgur.com/aEkR4nQ.jpg)

Here we'll attempt to re-render faces to be cutesy. We aren't sure what types of input features will work best for this, so we'll have to experiment. If we can find good parameters and select features well then we think the results here could be quite good.

#### Video summary

A: 

<iframe width="560" height="315" src="https://www.youtube.com/embed/JAAaUxObdFk" frameborder="0" allowfullscreen> </iframe>

A': ![A'](http://i.imgur.com/bI4ilhi.jpg)

The process of summarizing a video with a single image involves many of the same mathematical models as texture synthesis and blending, both of which the original paper touched on and seemed to perform quite well.  We will attempt to interpret a video into the framework and model the image summary process performed above on several source videos.  We expect that once we have appropriately transformed our input videos into the framework, we should be able to achieve positive results.  Finding videos that yield pleasing results can be a challenge in itself, so we'll have to do some searching to find some good videos upon which to test this method (probably passing them through the original video summary method to verify).


#### Floor plan renders

A and A': ![A and A'](http://i.imgur.com/7vwPmDa.jpg)

B: ![B](http://i.imgur.com/Rb1SJPV.jpg)


We will also attempt to take a 2d floor plan drawing and render it in a 3d style as seen in the source image above.  We will test on various different floor plan samples, such as the one shown, to see if any plans we can find will produce convincing results. This idea probably won't work (at all) but it could be interesting to try.

