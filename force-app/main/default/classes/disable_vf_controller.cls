public class disable_vf_controller {
public integer acclimit { get; set;}
    public integer total { get; set;}
    public list<account> acclist { get; set;}
     public Attachment account1 { get; set;}
    public Attachment account2 { get; set;}
    public disable_vf_controller(){
        acclimit = 5;
        total = [select count() from account];
        acclist = [select id, name from account limit :acclimit];
    }
     
    public void allacc(){
        acclist = [select id, name from account];
    }
}