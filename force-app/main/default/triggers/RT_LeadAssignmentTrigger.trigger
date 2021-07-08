trigger RT_LeadAssignmentTrigger on Lead (before insert, after insert, after update) {
    new RT_LeadAssignmentTriggerHandler().run();
}