public class ContactTriggerHandler{
        public void isAfterUpdate(Map<Id,Contact> oldMap, Map<Id,Contact>newMap){
            Map<Id,String> accConType = new Map<Id,String>();
            for(Id id : oldMap.keySet()){
                if(oldMap.get(id).Contact_Type__c != newMap.get(id).Contact_Type__c){
                    System.debug('-->'+newMap.get(id).Contact_Type__c);
                    accConType.put(newMap.get(id).AccountId,newMap.get(id).Contact_Type__c);
                }
            }
            
            if(accConType.size() > 0){
                updateAccount(accConType);
            }
            
            
        }
        
        public void isAfterInsert(Map<Id,Contact> newMap){
            Map<Id,String> accConType = new Map<Id,String>();
            for(Contact Con : newMap.values()){
                if(Con.Contact_Type__c == 'Customer'){
                    accConType.put(con.AccountId, con.Contact_Type__c);
                }
            }
            if(accConType.size() > 0){
                updateAccount(accConType);
            }
        }
        
        public void updateAccount(Map<Id,String> accConType){
            List<Account> accList = new List<Account>();
            for(Account acc : [Select Id,Has_Customer__c from Account where Id IN : accConType.keySet()]){
                if(accConType.get(acc.Id) == 'Customer'){
                    acc.Has_Customer__c = true;
                    accList.add(acc);
                }else if(acc.Has_Customer__c == true){
                    acc.Has_Customer__c = false;
                    accList.add(acc);
                }
            }
            if(accList.size() > 0){
                update accList;
            }
        }
}