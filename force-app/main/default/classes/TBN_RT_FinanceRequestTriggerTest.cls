@isTest
private class TBN_RT_FinanceRequestTriggerTest {
    @isTest static void TestForInsertComments(){
        Case cse=new Case();
        INSERT cse;
        CaseComment caseCommenttoAdd1 = new CaseComment(CommentBody = 'Testing Comment', ParentId = cse.Id);
        INSERT caseCommenttoAdd1;
        CaseComment caseCommenttoAdd2 = new CaseComment(CommentBody = 'Testing Comment 2', ParentId =cse.Id);
        INSERT caseCommenttoAdd2;
        Finance_Req__c financeRecord = new Finance_Req__c(Historical_caseId__c = cse.Id);
        Insert financeRecord;
        Finance_Req__c financeObj = [SELECT Internal_comments__c
                                        FROM Finance_Req__c
                                        WHERE Historical_caseId__c =:financeRecord.Historical_caseId__c];
        System.assertEquals('Testing Comment 2\nTesting Comment',financeObj.Internal_comments__c);    
        Case case2 = new Case();
        INSERT case2;
        CaseComment caseCommenttoAdd3 = new CaseComment(CommentBody = 'Testing Comment 3', ParentId = case2.Id);
        INSERT caseCommenttoAdd3;
         financeRecord.Historical_caseId__c = case2.Id;
        UPDATE financeRecord;
         Finance_Req__c financeObj1 = [SELECT Internal_comments__c
                                        FROM Finance_Req__c
                                        WHERE Historical_caseId__c =:financeRecord.Historical_caseId__c ];
        System.assertEquals('Testing Comment 3\nTesting Comment 2\nTesting Comment',financeObj1.Internal_comments__c); 
        
    }
    @isTest static void TestForEmptyCaseId(){
        Case cse=new Case();
        INSERT cse;
        CaseComment caseCommenttoAdd1 = new CaseComment(CommentBody = 'Testing Comment', ParentId = cse.Id);
        INSERT caseCommenttoAdd1;
        Finance_Req__c financeRecord = new Finance_Req__c(Historical_caseId__c = cse.Id);
        INSERT financeRecord;
        Finance_Req__c financeRecord2 = new Finance_Req__c(Historical_caseId__c = ' ');
        INSERT financeRecord2;
        financeRecord.Historical_caseId__c = financeRecord2.Historical_caseId__c;
        Update financeRecord;
        List<Finance_Req__c> lstFinanceObj = [SELECT Internal_comments__c
                                        FROM Finance_Req__c
                                        WHERE Historical_caseId__c =: financeRecord.Historical_caseId__c];
        System.assertEquals(0,lstFinanceObj.size());
    }
    @isTest static void TestAttachment(){
    	Case cse=new Case();
        insert cse;
 
        Attachment attach=new Attachment();   	
    	attach.Name='Unit Test Attachment';
    	Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
    	attach.body=bodyBlob;
        attach.parentId=cse.id;
        insert attach;
        Finance_Req__c financeRecord = new Finance_Req__c(Historical_caseId__c = cse.id);
        INSERT financeRecord;    	
    	List<Attachment> attachments=[select id, name from Attachment where parent.id=:financeRecord.id];
    	System.assertEquals(1, attachments.size());
    }
}