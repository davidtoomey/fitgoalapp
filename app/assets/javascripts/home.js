
$(function(){  // $(document).ready shorthand
	$("").ready(function(){
    $("#one").delay(4000).animate({
      left: '0px'

    });
    $("#two").delay(6000).animate({
      right: '0px'
    });
    $("#three").delay(8000).animate({
      left : '0px'
    });



});
});

$(function(){
  $('.dbtn').hide().delay(10000).fadeIn(3000);
});



var target = $("#target");
target.html(target.text().replace(/./g, "<span>$&</span>"));

jQuery(function($) {

  var target = $("#target");
  target.html(target.text().replace(/./g, "<span>$&</span>"));

  setTimeout(runAnimation, 250);

  function runAnimation() {
    var index, spans;

    index = 0;
    spans = target.children();
    doOne();

    function doOne() {
      var span = $(spans[index]);
      if (!$.trim(span.text())) {
        // Skip blanks
        next();
        return;
      }
 // Do this one
      span.css({
        position: "relative",
      }).animate({
        top: "-20"
      }, "fast").animate({
        top: "0"
      }, "fast", function() {
        span.css("position", "");
        next();
      });
    }


    function stop(){
        //does nothing
    }

    function next() {
      ++index;
      if (index < spans.length) {
        doOne();
      }
      else {
        stop();
      }
    }
  }

});



