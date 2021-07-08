public class LoginSearchQuestrade {
	@AuraEnabled
	public static List<SObject> getFaqs(){
		List<SObject> lstOfFAQ = new List<SObject>();
		Set<String> articleNumberSet =new Set<String>();
		List<Count_View__c> countView = [SELECT Article_Number__c,Count__c  FROM Count_View__c ORDER BY Count__c  DESC LIMIT 3];
		for(Count_View__c obj : countView){
			articleNumberSet.add(obj.Article_Number__c);
		}
		List<QT__kav> lstQTFaq = [SELECT Id, Title from QT__kav WHERE ArticleNumber In : articleNumberSet];
		List<FAQ__kav> lstFAQFaq = [SELECT Id, Title from FAQ__kav WHERE ArticleNumber In : articleNumberSet];
		List<Basic__kav> lstBasicFaq = [SELECT Id, Title from Basic__kav WHERE ArticleNumber In : articleNumberSet];
		lstOfFAQ.addAll(lstQTFaq);
		lstOfFAQ.addAll(lstFAQFaq);
		lstOfFAQ.addAll(lstBasicFaq);
		return lstOfFAQ;
	}

	@AuraEnabled
	 public static Map<Id,String> getSearchResults(String keyForSearch){
        if(!String.isEmpty(keyForSearch)){
	        keyForSearch = '%' + keyForSearch + '%';
	        Map<Id,String> DataCategoryMap = new Map<Id,String>();
	        List<SObject> lstOfDataCategories = new List<SObject>();			
	        String dcname;
			Map<Id,String> articleWithDC = new Map<Id,String>();
			List<SObject> lstOfQueriedArticles = new List<SObject>();
			List<QT__DataCategorySelection> lstDataCategoryHelp = [SELECT ParentId,DataCategoryName FROM QT__DataCategorySelection];
			List<FAQ__DataCategorySelection> lstDataCategoryFAQ = [SELECT ParentId,DataCategoryName FROM FAQ__DataCategorySelection];
			List<Basic__DataCategorySelection> lstDataCategoryBasic = [SELECT ParentId,DataCategoryName FROM Basic__DataCategorySelection];
			lstOfDataCategories.addAll(lstDataCategoryHelp);
			lstOfDataCategories.addAll(lstDataCategoryFAQ);
			lstOfDataCategories.addAll(lstDataCategoryBasic);
			for(SObject dcl : lstOfDataCategories){
				if(DataCategoryMap.containsKey((Id)(dcl.get('ParentId')))){
					dcname = DataCategoryMap.get((String)(dcl.get('ParentId')));
					DataCategoryMap.put((Id)(dcl.get('ParentId')), dcname + ' | '+(String)(dcl.get('DataCategoryName')));
				}
				else
			    DataCategoryMap.put((Id)(dcl.get('ParentId')),(String)(dcl.get('DataCategoryName')));
			}
			List<QT__kav> articleQt = [SELECT Id, Title FROM QT__kav WHERE Title LIKE: keyForSearch];
			List<FAQ__kav> articleFAQ = [SELECT Id, Title FROM FAQ__kav WHERE Title LIKE: keyForSearch];
			List<Basic__kav> articleBasic = [SELECT Id, Title FROM Basic__kav WHERE Title LIKE: keyForSearch];
			lstOfQueriedArticles.addAll(articleQt);
			lstOfQueriedArticles.addAll(articleFAQ);
			lstOfQueriedArticles.addAll(articleBasic);
			for(SObject qtart: lstOfQueriedArticles){
			    if(DataCategoryMap.containsKey((Id)(qtart.get('Id')))) {
			        articleWithDC.put((Id)(qtart.get('Id')), (String)(qtart.get('Title')) +' | '+DataCategoryMap.get((Id)(qtart.get('Id'))));
			    }
			    else{
			    	articleWithDC.put((Id)(qtart.get('Id')), (String)(qtart.get('Title')));
			    }
			}
			return articleWithDC;
	    }else{
	    	return null;
		}
    }

    @AuraEnabled
    public static List<SObject> getArticleBody(Id articleId){
    	List<SObject> lstOfArticleBody = new List<SObject>();

    	List<QT__kav> lstQTcountUpdate = [SELECT ArticleNumber FROM QT__kav WHERE Id =: articleId];
    	List<FAQ__kav> lstFAQcountUpdate = [SELECT ArticleNumber FROM FAQ__kav WHERE Id =: articleId];
    	List<Basic__kav> lstBasiccountUpdate = [SELECT ArticleNumber FROM Basic__kav WHERE Id =: articleId];
		Count_View__c upCount = new Count_View__c();
		if(lstQTcountUpdate.size()>0){
				Count_View__c[] count = [SELECT Id,Count__c, Article_Number__c From Count_View__c WHERE Article_Number__c =: lstQTcountUpdate[0].ArticleNumber];
				if(count.size()>0){
		    		upCount.Id =count[0].Id;
		    		upCount.Count__c = count[0].Count__c + 1;
				    upCount.Article_Number__c = count[0].Article_Number__c;
				}
				else{
		    			upCount.Count__c = 1;
		    			upCount.Article_Number__c = lstQTcountUpdate[0].ArticleNumber;
		    		}
		}else if(lstFAQcountUpdate.size()>0){
			Count_View__c[] count = [SELECT Id,Count__c, Article_Number__c From Count_View__c WHERE Article_Number__c =: lstFAQcountUpdate[0].ArticleNumber];
				if(count.size()>0){
		    		upCount.Id =count[0].Id;
		    		upCount.Count__c = count[0].Count__c + 1;
				    upCount.Article_Number__c = count[0].Article_Number__c;
				}else{
					upCount.Count__c = 1;
		    		upCount.Article_Number__c = lstFAQcountUpdate[0].ArticleNumber;
		    	}
		}else if(lstBasiccountUpdate.size()>0){
				Count_View__c[] count = [SELECT Id,Count__c, Article_Number__c From Count_View__c WHERE Article_Number__c =: lstBasiccountUpdate[0].ArticleNumber];
				if(count.size()>0){
		    		upCount.Id =count[0].Id;
		    		upCount.Count__c = count[0].Count__c + 1;
				    upCount.Article_Number__c = count[0].Article_Number__c;
				}else{
						upCount.Count__c = 1;
		    			upCount.Article_Number__c = lstBasiccountUpdate[0].ArticleNumber;
		    		}
		}
		UPSERT upCount;
		List<QT__kav> lstQTArticleBody = [SELECT KnowledgeArticleId FROM QT__kav WHERE Id =: articleId];
    	List<FAQ__kav> lstFAQArticleBody = [SELECT KnowledgeArticleId FROM FAQ__kav WHERE Id =: articleId];
    	List<Basic__kav> lstBasicArticleBody = [SELECT KnowledgeArticleId FROM Basic__kav WHERE Id =: articleId];
		lstOfArticleBody.addAll(lstQTArticleBody);
		lstOfArticleBody.addAll(lstFAQArticleBody);
		lstOfArticleBody.addAll(lstBasicArticleBody);
		return lstOfArticleBody;
    }
}