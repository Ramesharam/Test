({
	loadFAQs : function(component){
		var action = component.get('c.getFaqs');
		action.setCallback(this, function(response){
			var FAQs = response.getReturnValue();
			component.set('v.FAQ', FAQs);
		})
		$A.enqueueAction(action);
	},
	getSearchedArticles : function(component, searchkey) {
		
		var action = component.get('c.getSearchResults');
		action.setParams({
            keyForSearch: searchkey
        });

        action.setCallback(this, function(response) {
            var articleList = [];
			var returnedArticles = response.getReturnValue();
			for(var key in returnedArticles){
			articleList.push({value:returnedArticles[key], key:key});
			}
			component.set("v.SearchResults", articleList);         
		})
        $A.enqueueAction(action);
	},
	
	
	getname : function(component, articleId){
		var action = component.get('c.getArticleBody');
		action.setParams({
            articleId: articleId
        });
        action.setCallback(this, function(response) {
        	console.log("--->>>>",response.getReturnValue());
            var aBody = response.getReturnValue();
            console.log('---->',aBody[0].KnowledgeArticleId);
            window.open('/'+'knowledge/articlePrintableView.apexp?id='+aBody[0].KnowledgeArticleId,"_blank", "toolbar=yes,scrollbars=yes,resizable=yes,top=500,left=500,width=400,height=400");
         })
        $A.enqueueAction(action);
	}
})