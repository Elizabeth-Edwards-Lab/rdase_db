$(function() {
  // Resize header links font size on window resize
  // The quickfit tolerance param make the text look too small locally but bigger
  // in production, I don't know why...
  $(window).resize(function() {
    $('.link-bar.one .link-text').quickfit({
      max: "65",
      tolerance: 0.46
    });

    // just make the font-size same as $('.link-bar.one .link-text')
    $('.link-bar.two .link-text').css('font-size', $('.link-bar.one .link-text').css('font-size'));
    $('.link-bar.three .link-text').css('font-size', $('.link-bar.two .link-text').css('font-size'));
    $('.link-bar.four .link-text').css('font-size', $('.link-bar.three .link-text').css('font-size'));
    // return $('.link-bar.two .link-text').css('font-size', $('.link-bar.one .link-text').css('font-size'));
  });

  return $(window).load(function() {
    $('.link-bar.one .link-text').quickfit({
      max: "65",
      tolerance: 0.46
    });

    // just make the font-size same as $('.link-bar.one .link-text')
    $('.link-bar.two .link-text').css('font-size', $('.link-bar.one .link-text').css('font-size'));
    $('.link-bar.three .link-text').css('font-size', $('.link-bar.two .link-text').css('font-size'));
    $('.link-bar.four .link-text').css('font-size', $('.link-bar.three .link-text').css('font-size'));

    $('.link-bar.one').animate({
      right: '0%'
    }, 2000);

    $('.link-bar.two').animate({
      right: '0%'
    }, 2000);

    $('.link-bar.three').animate({
      right: '0%'
    }, 2000);

    $('.link-bar.four').animate({
      right: '0%'
    }, 2000);

    // return $('.link-bar.four').animate({
    //   right: '0%'
    // }, 2000);
  });

});