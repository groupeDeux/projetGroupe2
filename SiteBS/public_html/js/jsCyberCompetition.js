/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    $("#tabs").tabs();
});

$("li[role='presentation']").click(function () {
    $(this).addClass('active').siblings().removeClass('active');
});


/*
$("#tab4").click(function(){
    $('#nomTitreAdmin').text(" Sportif");
});
*/