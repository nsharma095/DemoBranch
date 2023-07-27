trigger ContactTrigger on Contact (after insert, after update) {
        
        ContactTriggerHandler conHandler = new ContactTriggerHandler();
        if(trigger.isafter && trigger.isupdate){
            conHandler.isAfterUpdate(Trigger.OldMap,Trigger.NewMap);
        }else if(trigger.isAfter && trigger.isInsert){
            conHandler.isAfterInsert(Trigger.NewMap);
        }
}