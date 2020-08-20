global with sharing class MFILoginController
{
    //Input variables
    global String input {get; set;}
    public String startURL {get; set;}
    public List<Auth.VerificationMethod> methods;
    public String error;
    global MFILoginController()
    {
    }
    global PageReference login()
    {
        List<User> users = null;
        // Empty input
        if(input == null || input == '')
        {
            error = 'Enter Username';
            return null;
        }
        users = [select name, id, email from User where username=:input];
        if(users == null || users.isEmpty())
        {
            error = 'Can\'t find a user';
            return null;
        }
        ID uid = users[0].id;
          //  Customize Login Pages in Apex for Full Control Passwordless Login Page Using Custom Login Pages
            if (startURL == null) startURL = '/';
        // Check which verification methods the user has already registered
        TwoFactorMethodsInfo AvailableMethods = [select
                                                 HasUserVerifiedMobileNumber,
                                                 HasUserVerifiedEmailAddress,
                                                 HasSalesforceAuthenticator,
                                                 HasTotp,
                                                 HasU2F from TwoFactorMethodsInfo where userId=:uid];
        // If no verification method is available, prompt the user to enter a password
        // and invoke the site.login(usr,pwd) method
        // if(AvailableMethods.size() == 0)
        // Add verification methods in priority order
        methods = new List<Auth.VerificationMethod>();
        if(AvailableMethods.HasUserVerifiedMobileNumber)
            methods.add(Auth.VerificationMethod.SMS);
        if(AvailableMethods.HasUserVerifiedEmailAddress)
            methods.add(Auth.VerificationMethod.EMAIL);
        if(AvailableMethods.HasSalesforceAuthenticator)
            methods.add(Auth.VerificationMethod.SALESFORCE_AUTHENTICATOR);
        if(AvailableMethods.HasTotp)
            methods.add(Auth.VerificationMethod.U2F);
        if(AvailableMethods.HasU2F)
            methods.add(Auth.VerificationMethod.U2F);
        return Site.passwordlessLogin(uid, methods, startURL);
    }
}