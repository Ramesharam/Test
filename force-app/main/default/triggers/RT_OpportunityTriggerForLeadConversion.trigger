trigger RT_OpportunityTriggerForLeadConversion on Opportunity (before insert, after insert) {
    new RT_OppTriggerLeadConversionHandler().run();
}