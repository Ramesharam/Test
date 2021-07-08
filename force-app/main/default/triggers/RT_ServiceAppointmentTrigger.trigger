trigger RT_ServiceAppointmentTrigger on ServiceAppointment (after Update) {
	new RT_ServiceAppointmentTriggerHandler().run();
}