trigger RT_OpportunityTriggerOwner on Opportunity (before insert, after insert,after update, before update) {
        new RT_OpportuntityTriggerOwnerHandler().run();
}