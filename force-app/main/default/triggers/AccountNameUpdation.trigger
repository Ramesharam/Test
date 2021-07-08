trigger AccountNameUpdation on Account (before insert, after insert) {
AccountNameUpdationHandler accountObj = new AccountNameUpdationHandler();
    if(Trigger.isBefore){
        
    }else if(Trigger.isAfter){
        accountObj.updatename();
    }
}