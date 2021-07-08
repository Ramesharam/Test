public class CustomObjectEmailExample {
    public PageReference sendingMail() {		
        
        EmailTemplate emailTemplate = [SELECT Id, body, Subject,HtmlValue, Name FROM EmailTemplate WHERE Id = '00X0o0000023GgcEAE'];
        Messaging.reserveSingleEmailCapacity(1);
        Savepoint sp = Database.setSavepoint();
        Messaging.SingleEmailMessage tempEmail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{'invalid@emailaddr.es'};
            tempEmail.setToAddresses(toAddresses);
        tempEmail.setUseSignature(false);
        tempEmail.setSaveAsActivity(false);
        tempEmail.setSenderDisplayName('Test');
        tempEmail.setTargetObjectId('0030o00002feSfO');
        tempEmail.setTemplateId(emailTemplate.Id);
        tempEmail.setWhatId('0010o00002FPXLfAAP');
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {tempEmail});
        /*List<Messaging.SendEmailResult> results;// = Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {tempEmail});
        try {
            results =  Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {tempEmail});
        } catch (exception e) {
            //results =  Messaging.sendEmail(new List<Messaging.SingleEmailMessage> {tempEmail});
            System.debug('in catch===>'+tempEmail.getHtmlBody());
        }*/
        Database.rollback(sp);
        System.debug('===>'+tempEmail.getHtmlBody());
        
        Messaging.reserveSingleEmailCapacity(1);
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses1 = new String[]{'invalid@emailaddr.es'};
            mail.setToAddresses(toAddresses1);
        mail.setUseSignature(false);
        mail.setSaveAsActivity(false);
        mail.setSenderDisplayName('MMPT');
        mail.setTargetObjectId('0030o00002feSfO');
        mail.setTemplateId(emailTemplate.Id);
        mail.setWhatId('0010o00002FPXLfAAP');
        
        Savepoint sp1 = Database.setSavepoint();
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
        Database.rollback(sp1);
        
        system.debug('plain=>'+mail.getPlainTextBody());
            system.debug('html=>'+ mail.getHTMLBody());
           system.debug('subject=>'+ mail.getSubject());

        
        return null;
    }
}