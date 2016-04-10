DDH.kanji_strokeorder = DDH.kanji_strokeorder || {};

(function(DDH) {
    "use strict"
    
    console.log("DDH.kanji_strokeorder.build");
    
    DDH.kanji_strokeorder.build = function(ops) {
	return {
	    normalize: function(item){
		//use this to map data into properties req'd by template
		return {
		//	item.item: ops.data.media_item,
	//		item.item_detail.image: ops.data.media_item_detail.image,//		item.item_detail.title: ops.data.media_item_detail.title
	//		image: item.data.image
			//item.image: ops.data.media_item.image
		};
	    },

	   /*templates:{
		group: 'info'
	}*/
	    
	    
	    // Function that executes after template content is displayed
	    onShow: function() {
		
		// define any callbacks or event handlers here
		//
		// var $dom = $(".zci--'<: $ia_id :>'");
		// $dom.find(".my-special-class").click(funtcion(){
		//
		// });         
		
	    }
	};
	};
})(DDH);
