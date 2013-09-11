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


