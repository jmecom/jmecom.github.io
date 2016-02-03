---
layout: post
title: "Rendering SVG elements over a Three.js canvas"
tags: [three.js, javascript, SVG]
date: 2015-1-14
---
I'll start off this blog with a quick post describing a bug I recently faced when working on [Star Graph](http://jmecom.github.io/GameUniverse), a Three.js application that renders new video game releases on Metacritic as stars in a galaxy. Star Graph presents a pop-up menu to the user when they click on a star, giving detailed information about the game that the star represents. Alice Wang (my friend and colleague for this project) and I decided we wanted a line going from the middle of the clicked star to the pop-up menu. Drawing that using [SVG line](http://www.w3schools.com/svg/svg_line.asp) seemed simple enough.

However, we discovered that the SVG elements we were drawing were appearing below the Three.js scene. The fix seemed straightforward: change the z-index of the line. But, this doesn't work. After [some reading](http://www.w3.org/Graphics/SVG/IG/resources/svgprimer.html#SVG_in_HTML) we discovered that SVG elements have their own DOM, and z-index doesn't apply. 

The real issue was the order in which everything was being rendered -- the SVG lines were getting drawn under the scene. Thankfully, the solution is very easy (once you know it exists!): add 'render-order: 2;' to your SVG file. Here is our final line.svg:

{% highlight HTML %}
<svg id="svgTag" version="1.1" xmlns="http://www.w3.org/2000/svg">
  <style>
    line {
      render-order: 2;
      stroke-width: 2;
      fill: #ffffff;
      stroke: #ffffff;
      position: fixed;
      stroke-linecap: round;
      stroke-opacity:0.75;
    }
  </style>
  <line id="line" x1="0" x2="0" y1="0" y2="0"/>
</svg>
{% endhighlight %}

If you're trying to incorporate SVG UI elements to your Three.js scene, I hope this helped. It took us a while to search for the right combination of words, so I hope this comes to you more quickly than it did for us! 
