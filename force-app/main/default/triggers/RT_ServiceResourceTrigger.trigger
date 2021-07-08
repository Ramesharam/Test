trigger RT_ServiceResourceTrigger on ServiceResource (before insert, after Insert) {
	new RT_ServiceResourceTrggerHandler().run();
}