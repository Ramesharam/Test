({
	doInit : function(component, event, helper) {
		helper.loadFAQs(component);
	},
	SearchArticles : function(component, event, helper){
		var searchkey = component.find("search").get("v.value");
		helper.getSearchedArticles(component, searchkey);
	},
	expandArticle :  function(component, event, helper){
		
		var articletarget = event.currentTarget;
        var articleId = articletarget.dataset.value;
        helper.getname(component, articleId);
	}
})