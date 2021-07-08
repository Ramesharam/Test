public class Downloadattachment {
  public static string DownloadAttachment(Id DownloadAttachmentID)
   {
    ContentVersion oldCV = [Select Id,Title from ContentVersion Where ContentDocumentId=:DownloadAttachmentID and IsLatest = true ];
    String fullFileURL = URL.getSalesforceBaseUrl().toExternalForm();
    String URlDownload = fullFileURL+'/sfc/servlet.shepherd/version/download/'+oldCV.Id;
    system.debug('Download URL:' +URlDownload);
    return URlDownload;
    } 
}