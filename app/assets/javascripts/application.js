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
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .


$(document).ready(function() {
  color_vars($("#theory"));
});

$(document).ready(function() {
  $(".unit_select").on("click", function(element){
    console.log($(element.target)[0]);
    $("#selectedUnit").html($(element.target)[0].dataset.sign);
  });
  //select first unit
  $(".unit_select")[0].click();
})

$(document).ready(function() {
  $("#skipQuestion").on("click", function(e) {
    event.preventDefault();
    location.reload();
  });
});

$(document).ready(function() {
  $("#helpQuestion").on("click", function(e) {
    event.preventDefault();
    elements = $(".help");
    for(var i = 0; i < elements.length; i++) {
      console.log($(elements[i]))
      $(elements[i]).toggle()
    }
  })
})

$(document).ready(function() {
  setTimeout(function () { closeNotices(); closeAlerts(); }, 10000);
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

function hasNumbers(t) {
  return /\d/.test(t);
}
