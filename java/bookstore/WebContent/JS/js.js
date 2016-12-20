window.onload = function(){
    $("tr:odd").addClass("one");
    $("tr:even").addClass("two");
    $("tr").mouseover(function(){
        $(this).addClass("hover");
    });
    $("tr").mouseout(function(){
        $(this).removeClass("hover");
    });
};
