// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .


$(document).on('mouseenter', '#badges_block a.thumb-link', function(e) {
  var $inner = $(this).find('.caption .inner');
  $inner.css( 'bottom', $inner.children('.more').outerHeight(true) );

}).on('mouseleave', '#badges_block a.thumb-link', function(e) {
  $(this).find('.caption .inner').css('bottom', 0);
});


//Functions for making answering view interactive
$(".unit_select").ready(function() {
  $(".unit_select").on("click", function(element){
    $("#selectedUnit").html($(element.target)[0].dataset.sign);
  });
  if($(".unit_select").length > 0) {
    $(".unit_select")[0].click();
  }
})

$(document).ready(function() {
  $(".thumb-link").popover({html: true, trigger: "hover", placement: "right"});
})

$("#skipQuestion").ready(function() {
  $("#skipQuestion").on("click", function(e) {
    event.preventDefault();
    location.reload();
  });
});

$("#helpQuestion").ready(function() {
  $("#helpQuestion").on("click", function(e) {
    event.preventDefault();
    elements = $(".help");
    for(var i = 0; i < elements.length; i++) {
      $(elements[i]).toggle()
    }
  })
});

$("#close_calculator").ready(function() {
  $("#close_calculator").on("click", function(e) {
    event.preventDefault();
    elements = $(".help");
    for(var i = 0; i < elements.length; i++) {
      $(elements[i]).hide()
    }
  })
});

$("#answer_value").ready(function() {
  $("#answer_value").focus()
  $("#answer_value").on("keypress", function(e){
    var code = e.keyCode || e.which;
    if(code == 13) {
      e.preventDefault();
      $("#answer_value").parent().parent().parent().submit();
    }
  })
});

$("#time_left").ready(function reload_time() {
  if($("#time_left").length > 0) {
    var time=$("#time_left").html();
    var minutes = time.split(":")[0];
    var seconds = time.split(":")[1];
    if(seconds > 0) {
      seconds--;
    }
    else if(seconds <= 0 && minutes > 0) {
      seconds = 60;
      minutes--;
    }
    else {
      window.alert("Time is up!");
      location.reload();
    }
    $("#time_left").html(trailing_zero(minutes)+":"+trailing_zero(seconds))
    setTimeout(reload_time, 1000);
  }
});

var trailing_zero = function(n) {
  if (n.length < 2) {
    return "0"+n;
  }
  else {
    return n;
  }
}

//Functions to close alerts and notices
$(document).ready(function() {
  setTimeout(function () { closeNotices(); closeAlerts(); }, 5000);
});

var closeNotices = function() {
  elements = $(".notice");
  for(var i =0; i<elements.length; i++) {
    $(elements[i]).css('display', 'none');
  }
}

var closeAlerts = function() {
  elements = $(".alert");
  for(var i =0; i<elements.length; i++) {
    $(elements[i]).css('display', 'none');
  }
}

//Function for highlighting variables
var color_vars = function(element) {
  var html = $(element).html();
  var split = html.split(" ");
  var newhtml = "";
  for(var i = 0; i < split.length; i++) {
    var part = "";
    if(hasNumbers(split[i])) {
      part = " <span class='highlight'>"+split[i]+"</span> ";
    }
    else {
      part = " "+split[i];
    }
    newhtml = newhtml + part;
  }
  $(element).html(newhtml);
};

$(document).ready(function() {
  if($("#theory").lenght > 0) {
    color_vars($("#theory"));
  }
});

function hasNumbers(t) {
  return /\d/.test(t);
}

