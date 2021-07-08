trigger RT_CaseTrigger on Case (before insert, after insert, before update) {
	new RT_CaseTriggerHandler().run();
}