// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){

        $('.fg-button').hover(
    		function(){ $(this).removeClass('ui-state-default').addClass('ui-state-focus'); },
    		function(){ $(this).removeClass('ui-state-focus').addClass('ui-state-default'); }
    	);

//	$('#menu').menu({
//            content: $('#menu').next().html(),
//            flyOut: true
//        });

        //$("#tabs").tabs();

       $('input:submit , .boton ').button();

       $('input[datatype=lupita]').dblclick(function(e) {
       if ($(this).attr("id") == "post_desc_tipo_norma")
       {
         var str = 'input[datacontainer=' + $(this).attr('datacontainer') + ']'
         $(str).each(function(){
           $(this).val('')
         });
       }
       $(this).val('');
      })

       //$("#radio").buttonset();


});


$(function () {
  $('#aportes th a').live('click', function () {
    //$.getScript(this.href);
    $('#aportes').load(this.href)
    return false;
  });
})


$(function () {
  $('#aportes th a, #aportes .pagination a').live('click',
    function () {
     // $.getScript(this.href);
      $('#aportes').load(this.href)
      return false;
    }
  );
});



$(function () {
  $('#tratamientos th a').live('click', function () {
    //$.getScript(this.href);
    $('#tratamientos').load(this.href)
    return false;
  });
})


$(function () {
  $('#tratamientos th a, #tratamientos .pagination a').live('click',
    function () {
     // $.getScript(this.href);
      $('#tratamientos').load(this.href)
      return false;
    }
  );
});


$(function () {
  $('#aceptados th a').live('click', function () {
    //$.getScript(this.href);
    $('#aceptados').load(this.href)
    return false;
  });
})


$(function () {
  $('#aceptados th a, #aceptados .pagination a').live('click',
    function () {
     // $.getScript(this.href);
      $('#aceptados').load(this.href)
      return false;
    }
  );
});

$(function () {
  $('#enviados th a').live('click', function () {
    //$.getScript(this.href);
    $('#enviados').load(this.href)
    return false;
  });
})


$(function () {
  $('#enviados th a, #enviados .pagination a').live('click',
    function () {
     // $.getScript(this.href);
      $('#enviados').load(this.href)
      return false;
    }
  );
});

// inicio paginacion ajax acreditaciones en registro_interno_creditos
$(function () {
  $('#acreditados th a').live('click', function () {
    $('#acreditados').load(this.href)
    return false;
  });
})

$(function () {
  $('#acreditados th a, #acreditados .pagination a').live('click',
    function () {
      $('#acreditados').load(this.href)
    //$.getScript(this.href);
      return false;
    }
  );
});
// fin paginacion ajax acreditaciones en registro_interno_creditos

//inicio paginacion ajax
$(function () {
  $('#resultado_busq_ajax th a, #resultado_busq_ajax .pagination a').live('click',
    function () {
      $.getScript(this.href);
      return false;
    });	
});
//fin paginacion ajax

function format_error(div_id, html) {
            var newHtml = "<div class='ui-state-error ui-corner-all' style='padding: 0 .7em; '>";
            newHtml += "<p><span class='ui-icon ui-icon-alert' style='float: left; margin-right: .3em;'>";
            newHtml += "</span>";
            newHtml += html;
            newHtml += "</p></div>";
            $('#'+div_id).html(newHtml);
            $('#'+div_id).show().delay(1000).hide(300);
}


function format_ok(div_id, html) {
            var newHtml = "<div class='ui-state-highlight ui-corner-all' style='padding: 0 .7em; '>";
            newHtml += "<p><span class='ui-icon ui-icon-info' style='float: left; margin-right: .3em;'>";
            newHtml += "</span>";
            newHtml += html;
            newHtml += "</p></div>";
            $('#'+div_id).html(newHtml);
            $('#'+div_id).show().delay(1000).hide(300);
}


function comprobarSiBisisesto(anio){
      if ( ( anio % 100 != 0) && ((anio % 4 == 0) || (anio % 400 == 0))) {
          return true;
          }
      else {
          return false;
          }
}


function fecha_valida(value){
            if (value != undefined && value != "" ){
                var resultado = true
                var dia  =  parseInt(value.substring(0,2),10);
                var mes  =  parseInt(value.substring(3,5),10);
                var anio =  parseInt(value.substring(6),10);
                var numDias = 0;
                switch(mes){
                    case 1:
                    case 3:
                    case 5:
                    case 7:
                    case 8:
                    case 10:
                    case 12:
                        numDias=31;
                        break;
                    case 4: case 6: case 9: case 11:
                        numDias=30;
                        break;
                    case 2:
                        if (comprobarSiBisisesto(anio)){ numDias=29 }else{ numDias=28};
                        break;
                    default:
                        resultado = false;
                }
                if (dia>numDias || dia==0){
                    resultado = false;
                }
                if (anio<1800){
                    resultado = false;
                }
           }else{
             resultado = false;
           }
           return resultado
};

function anio_valido(value){
  if (value != undefined && value != "" ){
	  var resultado = true
	  var mydate=new Date()
	  var year=mydate.getYear();
	  year+=1900
     var patron=/^(([1-9]{1}[8-9]{1}[0-9]{2})|([2-9]{1}[0-9]{1}[0-9]{2}))$/;
     if(value.match(patron)){
		  if (value > year){
			 resultado=false
		  }
     }else{
   		 resultado=false
     }
  }else{
    resultado = false;
  }
	  return resultado
};
function mes_valido(value){
  var resultado = true;
  if (value != undefined && value != "" ){
	  var patron=/^((0[1-9]{1})|([1-9]){1}|(1[0-2]{1,2}))$/;
	  if(value.match(patron)){
       resultado = true;
     }else{
       resultado = false;
     }
  }else{
    resultado = false;
  }
	  return resultado
};







/*
jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
   });

  jQuery(document).ready(function($) {
        $('div.ajax-pagination a').live('click', function() {
        $('#aportes').load(this.href)
        return false
        });


      $('div.aporte a').live('click', function() {
        $('#aportes').load(this.href)
        return false
      })
  });



/*
$(document).ready(function () {
    $("#edit_localidad").validate({

        rules: {
              "localidad[descripcion]": {required: true, minlength: 6}
               }
    });
});

*/
/*
ddsmoothmenu.init({
	mainmenuid: "menu", //menu DIV id
	orientation: 'h', //Horizontal or vertical menu: Set to "h" or "v"
	classname: 'ddsmoothmenu', //class added to menu's outer DIV
	customtheme: ["#459E00", "#18374a"],
	contentsource: "markup" //"markup" or ["container_id", "path_to_menu_file"]
})
*/
