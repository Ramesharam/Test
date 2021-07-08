trigger RT_LeadTrigger on Lead (before insert, after insert, after update) {
    new RT_LeadTriggerHandler().run();
}