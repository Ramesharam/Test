public class RT_PGI_CompanyTriggerHandler extends TriggerHandler {
    public override void beforeInsert(){
        //handlerInsert((List<PGi_Company__c>) trigger.new);
        populateRelatedAccount();
    }
    public override void afterInsert(){
    	updatePgiContract((List<PGI_Company__c>) Trigger.new);
    }
    private void populateRelatedAccount(){
        
        Set<String> accountSFDCIds = new Set<String>();
        Set<Id> accountIds = new Set<Id>();
        Map<String,Id> sfdcAcountIdMap = new Map<String,Id>();
        
        
        
        for(Account account : [SELECT Id,Name, SFDC_Account_ID__c
                               FROM Account]){
                                   accountIds.add(account.Id);
                                   sfdcAcountIdMap.put(account.SFDC_Account_ID__c,account.Id);
                                   
                                   if(!String.isBlank(account.SFDC_Account_ID__c))
                                       accountSFDCIds.add(account.SFDC_Account_ID__c);
                                   
                               }
        for(PGi_Company__c pgiCompany : (List<PGI_Company__c>) Trigger.new){
            
            if(!String.isBlank(pgiCompany.CorpCust_SF_Account_ID__c) && pgiCompany.CorpCust_SF_Account_ID__c.startsWith('001') &&  accountIds.contains(pgiCompany.CorpCust_SF_Account_ID__c)) {
                pgiCompany.Related_Account__c = pgiCompany.CorpCust_SF_Account_ID__c; 
            }else if(String.isBlank(pgiCompany.CorpCust_SF_Account_ID__c) && sfdcAcountIdMap.containsKey(pgiCompany.SF_Account_ID__c) &&  !String.isBlank(pgiCompany.SF_Account_ID__c) && accountSFDCIds.contains(pgiCompany.SF_Account_ID__c)){
                pgiCompany.Related_Account__c = sfdcAcountIdMap.get(pgiCompany.SF_Account_ID__c);
            }
            
           
        }
        
        
    }
    private void updatePgiContract(List<PGi_Company__c> newPGIList){
    	Set<Id> opportunityIds = new Set<Id>();
    	Set<Id> OppSFId = new Set<Id>();
    	for(PGi_Company__c obj : newPGIList){
    		opportunityIds.add(obj.Direct_SF_Oppty_ID__c);
    		oppSFId.add(obj.SF_Opportunity_ID__c);
    	}
    	Map<Id,Set<PGI_Contract__c>> opportPGiContratMap = new Map<Id,Set<PGI_Contract__c>>();
        for(Opportunity opportunity : [SELECT Id, (SELECT Id,PGi_Company__c FROM Sales_Contracts__r)
                                       FROM Opportunity Where (Id IN : opportunityIds) OR Id IN: oppSFId]){
                                           
										//opportunityIds.add(opportunity.Id);
                                           
                                           if(!opportPGiContratMap.containsKey(opportunity.Id))
                                               opportPGiContratMap.put(opportunity.Id, new Set<PGI_Contract__c>{opportunity.Sales_Contracts__r});
                                           else
                                               opportPGiContratMap.get(opportunity.Id).add(opportunity.Sales_Contracts__r);
                                       }
        system.debug('===opportPGiContratMap='+opportPGiContratMap);
    	List<PGI_Contract__c> pgiContractUpdateList = new List<PGI_Contract__c>();
        for(PGi_Company__c pgiCompany : newPGIList){
            system.debug('Pgi company trigger=>'+pgiCompany);
        	
            //system.debug('Pgi company pgiContractList=>'+pgiContractList);
            if(!String.isBlank(pgiCompany.Direct_SF_Oppty_ID__c) && pgiCompany.Direct_SF_Oppty_ID__c.startsWith('006') &&  opportunityIds.contains(pgiCompany.Direct_SF_Oppty_ID__c)){
                List<PGI_Contract__c> pgiContractList = new List<PGI_Contract__c>( (Set<PGI_Contract__c>)JSON.deserialize(JSON.serialize(opportPGiContratMap.get(pgiCompany.Direct_SF_Oppty_ID__c)), Set<PGI_Contract__c>.class) );
                if(pgiContractList.size() == 1){
                    pgiContractList[0].PGi_Company__c = pgiCompany.Id;
                    pgiContractUpdateList.add(pgiContractList[0]);
                }
                
            }else if(!String.isBlank(pgiCompany.SF_Opportunity_ID__c) && oppSFId.contains(pgiCompany.SF_Opportunity_ID__c) && pgiCompany.SF_Opportunity_ID__c.startsWith('006')){
               List<PGI_Contract__c> pgiContractList = new List<PGI_Contract__c>( (Set<PGI_Contract__c>)JSON.deserialize(JSON.serialize(opportPGiContratMap.get(pgiCompany.SF_Opportunity_ID__c)), Set<PGI_Contract__c>.class) );
               if(pgiContractList.size() == 1){
	                pgiContractList[0].PGi_Company__c = pgiCompany.Id;
	                pgiContractUpdateList.add(pgiContractList[0]);
	             }
	         }
        }
        system.debug('++==Upadt'+pgiContractUpdateList);
        UPDATE pgiContractUpdateList;
    }
    
}
//	private void handlerInsert(List<PGi_Company__c> newPGIList){
//		Set<Id> pgiExternalIdSet = new Set<Id>();
//		Set<String> pgiSFAccountIdsSet = new Set<String>();
//		Set<Id> pgiOppotunityIdSet = new Set<Id>();
//		for(PGi_Company__c obj :newPGIList){
//			pgiExternalIdSet.add(obj.CorpCust_SF_Account_ID__c);
//			pgiSFAccountIdsSet.add(obj.SF_Account_ID__c);
//			pgiOppotunityIdSet.add(obj.Direct_SF_Oppty_ID__c);
//		}
//		List<Account> accObjList = new List<Account>([SELECT Id,SFDC_Account_ID__c 
//														FROM Account 
//														WHERE (Id IN :pgiExternalIdSet) OR 
//														(SFDC_Account_ID__c IN :  pgiSFAccountIdsSet)]);
//		for( Account objAcc : accObjList ){
//			for(PGi_Company__c objPgi : newPGIList){
//				if(objPgi.CorpCust_SF_Account_ID__c == objAcc.Id){
//					objPgi.Related_Account__c = objAcc.Id;
//				}
//				else if((objPgi.SF_Account_ID__c != null)&&(objPgi.SF_Account_ID__c == objAcc.SFDC_Account_ID__c)){
//					objPgi.Related_Account__c = objAcc.Id;
//				}
//			}
//		}
//		List<PGI_Contract__c> objContractlist =[Select id, Name, PGi_Company__c  
//												From PGI_Contract__c
//												Where Opportunity__c IN : pgiOppotunityIdSet];
//			System.debug('===>>'+objContractlist);
//			System.debug('size=>'+objContractlist.size());
//		if(objContractlist.size()==1){
//			for(PGI_Contract__c objContract :objContractlist){
//				for(PGi_Company__c objPgi : newPGIList){
//					objContract.PGi_Company__c = objPgi.Name;
//				}
//			}
//		}
//		//for(PGi_Company__c objPgi : newPGIList ){	
//		//	for(Opportunity opportunity : opportunityRecord){
//		//		system.debug('==opportunity==>'+opportunity);
//		//		List<PGI_Contract__c> objContractlist = opportunity.Sales_Contracts__r;
//		//		system.debug('==objContractlist==>'+objContractlist);
//		//		system.debug('==size==>'+objContractlist.size());
//		//		if(objContractlist.size()==1){
//		//			objContractlist.Name =objPgi.Name;
//		//		}
//		//	}
//		//}


//		//Set<Id> contractIdSet = new Map<Id,PGI_Contract__c >([SELECT Id FROM PGI_Contract__c]).keySet();
//		//List<PGI_Contract__c> objContractlist =[SELECT Opportunity__c, Count(Id)
//		//											FROM PGI_Contract__c
//		//											GROUP BY Opportunity__c
//		//											HAVING Count(Id) = 1];
//		//Map<Id, AggregateResult> objContractlist = new Map<Id, AggregateResult>([SELECT Id,Opportunity__c, Count()
//		//											FROM PGI_Contract__c
//		//											GROUP BY Opportunity__c
//		//											HAVING Count(Id) = 1]);
//		//System.debug('iiiimapi=>'+objContractlist);

//		//for(PGI_Contract__c p :objContractlist){
//		//	System.debug('++Size==>'+p);
//		//}
//		//for(PGi_Company__c pgiObject : newPGIList){

//		//}
//	}
//}