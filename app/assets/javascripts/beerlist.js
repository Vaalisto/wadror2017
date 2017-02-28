$(document).ready(function () {
    $.getJSON('beers.json', function (beers) {
        oluet = beers
        $("#beers").html("oluita löytyi "+beers.length);
    });
});