@isTest
private class LoginSearchQuestradeTest {
	@testSetup static void setup() {
		QT__kav articleTest1 = new QT__kav(Title = 'abc',UrlName='abc');
		INSERT articleTest1;
		QT__kav articleTest2 = new QT__kav(Title = 'opop',UrlName='pop');
		INSERT articleTest2;
        FAQ__kav articleTest3 = new FAQ__kav(title = 'article3', UrlName='art3');
        INSERT articleTest3;
        Basic__kav articleTest4 = new Basic__kav(title = 'article4', UrlName='art4');
		INSERT articleTest4;
        QT__DataCategorySelection dataCategory1 = new QT__DataCategorySelection(ParentId=articleTest1.Id, DataCategoryName='app_Science',DataCategoryGroupName='Science');
		INSERT dataCategory1;
		QT__DataCategorySelection dataCategory2 = new QT__DataCategorySelection(ParentId=articleTest1.Id, DataCategoryName='Service',DataCategoryGroupName='Marketing');
		INSERT dataCategory2;
		//QT__DataCategorySelection dataCategory3 = new QT__DataCategorySelection(ParentId=articleTest2.Id, DataCategoryName='app_Science',DataCategoryGroupName='Science');
		//INSERT dataCategory3;
		KbManagement.PublishingService.publishArticle([SELECT Id,Title,KnowledgeArticleId FROM QT__kav WHERE id = :articleTest1.Id][0].KnowledgeArticleId, true);
		KbManagement.PublishingService.publishArticle([SELECT Id,Title,KnowledgeArticleId FROM QT__kav WHERE id = :articleTest2.Id][0].KnowledgeArticleId, true);
        KbManagement.PublishingService.publishArticle([SELECT Id,Title,KnowledgeArticleId FROM FAQ__kav WHERE id = :articleTest3.Id][0].KnowledgeArticleId, true);
        KbManagement.PublishingService.publishArticle([SELECT Id,Title,KnowledgeArticleId FROM Basic__kav WHERE id = :articleTest4.Id][0].KnowledgeArticleId, true);
	}
	@isTest static void testMethodForSearch(){
		QT__kav article = [Select Id, Title From QT__kav WHERE Title ='abc'];
		String strkey='abc';
		Map<Id,String> mapSearchResult = new Map<Id,String>();
		mapSearchResult =LoginSearchQuestrade.getSearchResults(strkey);
		//System.assertEquals(article.Id, mapSearchResult[0].get(key));
		system.debug('===>'+LoginSearchQuestrade.getSearchResults(' '));
		
		
	}
	@isTest static void testMethodForgetFaq(){
		LoginSearchQuestrade.getFaqs();
	}
	@isTest static void testMethodForgetArticlebody(){
		QT__kav article = [Select Id, KnowledgeArticleId, Title From QT__kav WHERE Title ='abc'];
		system.debug('=====22222=>'+LoginSearchQuestrade.getArticleBody(article.Id));
		List<QT__kav> getKnowledgId = LoginSearchQuestrade.getArticleBody(article.Id);
		System.assertEquals(article.KnowledgeArticleId, getKnowledgId[0].KnowledgeArticleId);

		QT__kav article2 = [Select Id, KnowledgeArticleId, Title From QT__kav WHERE Title ='opop'];
		List<QT__kav> getKnowledgId2 = LoginSearchQuestrade.getArticleBody(article2.Id);
		System.assertEquals(article2.KnowledgeArticleId, getKnowledgId2[0].KnowledgeArticleId);
        
        FAQ__kav article3 = [Select Id, KnowledgeArticleId, Title From FAQ__kav WHERE Title ='article3'];
		List<FAQ__kav> getKnowledgId3 = LoginSearchQuestrade.getArticleBody(article3.Id);
		System.assertEquals(article3.KnowledgeArticleId, getKnowledgId3[0].KnowledgeArticleId);
        
        Basic__kav article4 = [Select Id, KnowledgeArticleId, Title From Basic__kav WHERE Title ='article4'];
		List<Basic__kav> getKnowledgId4 = LoginSearchQuestrade.getArticleBody(article4.Id);
		System.assertEquals(article4.KnowledgeArticleId, getKnowledgId4[0].KnowledgeArticleId);
	}
}