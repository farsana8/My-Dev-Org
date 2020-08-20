global  class clearUsage  implements Schedulable
{
    List<Device__c> dev_list=[select id,Usage__c,Previous_Usage__c from Device__c];
    double amt;
    global void execute(System.SchedulableContext ctx)
    {
        sendMail();
        for(device__c dev: dev_list)
        {
            
            dev.Previous_Usage__c=dev.Usage__c;
            dev.Usage__c=0;
        }
        Update dev_list;
    }
    public void sendMail() 
    {
        datetime d1 = datetime.now();
        datetime dt=datetime.newInstance(d1.Year(), d1.Month()-1,d1.day());
        Integer numberOfDays = Date.daysInMonth(dt.year(), dt.month());
        string st=String.valueOf(dt.format('MMMM'));
        String period=st +'  1 - '+st+' '+numberOfDays;
        String bill_date = (d1.day()+10 +'/'+d1.month()+'/'+d1.year());
        String due_date = (d1.day()+20 +'/'+d1.month()+'/'+d1.year());
        list<contact> address_list=[select Name,Email,Phone,MailingAddress from contact where Title='Smart Home'];
        AggregateResult Lis=[select sum(Total_usage__c) c from Room__c];
        Integer unit= Integer.valueOf(Lis.get('c'));
        double Bill_amount=current_bill(unit);
        list< Messaging.SingleEmailMessage> message = new list<Messaging.SingleEmailMessage>();
        for(contact c:address_list)
        {
            Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
            m.toAddresses = new String[] {c.Email};
            m.optOutPolicy = 'FILTER';
            m.subject = 'Current Bill';
            String htmlBody = '';
            htmlBody = '<html><body><h2>Kerala State Electricity Board</h2><h3>General Details</h3><table  style="width:60%" ><tr><td>Customer Name</td><td><b>'+c.Name+'</b></td></tr><tr><td>Address</td><td><b>Cochin University of Science and Technology,South Kalamassery, Kalamassery, Kochi, Kerala 682022</b></td></tr><tr><td>Phone</td><td><b>'+c.phone+'</b></td></tr><tr><td>Email</td><td><b>'+c.Email+'</b></td></tr></table><h3>Payment Details</h3><table style="width:60%"border="1"><tr><td><b>Period</b></td><td>'+period+'</td></tr><tr><td><b>Bill Date</b></td><td>'+bill_date+'</td></tr><tr><td><b>Due Date</b></td><td>'+due_date+'</td></tr><tr><td><b>Units</b></td><td>'+unit+'</td></tr><tr><td><b>Total Amount Due</b></td><td>'+bill_amount+'</td></tr></table><h4>"Electricity Is Precious-dont Waste It! Todays Wastage is Tommorows Shortage..."</h4></body></html>'; 
            m.setHtmlBody(htmlBody);
            message.add(m);
        }
        Messaging.SendEmailResult[] results = Messaging.sendEmail(message);
        if (results[0].success)
        {
            System.debug('The email was sent successfully.');
        } 
        else
        {
            System.debug('The email failed to send: ' + results[0].errors[0].message);
        }
    }
    public double current_bill(integer unit)
    {      
        if(unit <= 50)
        {
            amt = unit * 0.50;
        }
        else if(unit <= 150)
        {
            amt = 25 + ((unit-50) * 0.75);
        }
        else if(unit <= 250)
        {
            amt = 100 + ((unit-150) * 1.20);
        }
        else
        {
            amt = 220 + ((unit-250) * 1.50);
        }
        System.debug('Electricity Bill:'+amt);
        return amt;
	}
}