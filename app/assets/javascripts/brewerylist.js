var BREWERIES = {};
var order = 'asc';

BREWERIES.show = function(){
    $("#brewerytable tr:gt(0)").remove();

    var table = $("#brewerytable");

    $.each(BREWERIES.list, function (index, brewery) {
        table.append('<tr>'
            +'<td>'+brewery['name']+'</td>'
            +'<td>'+brewery['year']+'</td>'
            +'<td>'+brewery['count']+'</td>'
            +'<td>'+brewery['active']+'</td>'
            +'</tr>');
    });
};

BREWERIES.sort_by_name = function(){
    BREWERIES.list.sort( function(a,b){
        return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
    });
};

BREWERIES.sort_by_year = function(){
    BREWERIES.list.sort( function(a,b){
        if (order == 'asc') {
            return b.year - a.year;
        } else {
            return a.year - b.year;
        }
    });
    order = order == 'desc' ? 'asc' : 'desc'
};

BREWERIES.sort_by_count = function(){
    BREWERIES.list.sort( function(a,b){
        return b.count - a.count;
    });
};

$(document).ready(function () {
    if ( $("#brewerytable").length>0 ) {

        $("#name").click(function (e) {
            BREWERIES.sort_by_name();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#year").click(function (e) {
            BREWERIES.sort_by_year();
            BREWERIES.show();
            e.preventDefault();
        });

        $("#count").click(function (e) {
            BREWERIES.sort_by_count();
            BREWERIES.show();
            e.preventDefault();
        });


        $.getJSON('breweries.json', function (beers) {
            BREWERIES.list = beers;
            BREWERIES.sort_by_name;
            BREWERIES.show();
        });

    }
});