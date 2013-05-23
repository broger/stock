function Pager(tableName, itemsPerPage) {
    this.tableName = tableName;
    this.itemsPerPage = itemsPerPage;
    this.currentPage = 1;
    this.pages = 0;
    this.inited = false;

    this.showRecords = function(from, to) {
        var rows = document.getElementById(tableName).rows;
        // i starts from 1 to skip table header row
        for (var i = 1; i < rows.length; i++) {
            if (i < from || i > to)
                rows[i].style.display = 'none';
            else
                rows[i].style.display = '';
        }
    }

    this.showPage = function(pageNumber) {
    	if (! this.inited) {
    		alert("Error 1 !");
    		return;
    	}
    	this.currentPage = pageNumber;
    	if (this.currentPage >= 1){
          var newPageAnchor = document.getElementById('pg'+this.currentPage);
          newPageAnchor.className = 'pg-selected';
          for (var page = 1; page <= this.pages; page++) {
            if (page != this.currentPage){
              var oldPageAnchor = document.getElementById('pg'+page);
              oldPageAnchor.className = 'pg-normal';
            }
          }
    	 }

        var from = (pageNumber - 1) * itemsPerPage + 1;
        var to = from + itemsPerPage - 1;
        this.showRecords(from, to);

    }

    this.prev = function() {
        if (this.currentPage > 1)
            this.showPage(this.currentPage - 1);
    }

    this.next = function() {
        if (this.currentPage < this.pages) {
            this.showPage(this.currentPage + 1);
        }
    }

    this.init = function() {
        var rows = document.getElementById(tableName).rows;
        var records = (rows.length - 1);
        this.pages = Math.ceil(records / itemsPerPage);
        this.inited = true;
    }
//resultset_next
//bullet_go
//control_play_blue
    this.showPageNav = function(pagerName, positionId) {
      	if (! this.inited) {
      		alert("Error 2 !");
    	  	return;
    	  }
    	  var element = document.getElementById(positionId);
  	    var pagerHtml = '';
     	  pagerHtml += '<b><span onclick="' + pagerName + '.prev();" class="pg-normal" style="size:12px;" onmouseover="this.style.cursor=\'pointer\'"><img src="/images/22x22/resultset_previous.png">Anterior</span></b> | ';
//     	  pagerHtml += '<b><span onclick="' + pagerName + '.prev();" class="pg-normal" style="size:12px;" onmouseover="this.style.cursor=\'pointer\'"> << Anterior </span></b> | ';
        for (var page = 1; page <= this.pages; page++)
            pagerHtml += '<span id="pg' + page + '" class="pg-normal" onclick="' + pagerName + '.showPage(' + page + ');"  style="size:12px;" onmouseover="this.style.cursor=\'pointer\'">' + page + '</span> | ';
            pagerHtml += '<b><span onclick="'+pagerName+'.next();" class="pg-normal" style="size:12px;" onmouseover="this.style.cursor=\'pointer\'"> Siguiente <img src="/images/22x22/resultset_next.png"></span></b>';
            element.innerHTML = pagerHtml;
    }
}
