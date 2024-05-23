🐦
SayIT

It's a crrosplatform app (web app and mobile app) developped by the triodev team. 
Technologies: Flutter (dart) and Firebase

The project is also available at: sayt.haroldraj.dev



Introduction
Skyler White acquired SayIT in May 2022 in order to revolute this famous social
network.
SayIT is a social network created in 2006 by Werner Heisenberg, the social network
pretend to be a public place where everybody is able to debate on SayIT where EACH
post ( also called as a SIT , cannot exceed 140 characters to improve and optimize
each post content.
Before becoming a Business Women in New York, she used to be a accountant for
some privates company in Albuquerque such as Fuel pump or an Industrial.
Behond the financial aspect, Skyler is convinced about transparency and preserve
confidentiality and integrity of the customer’s Data.
The new brand of SayIT is: Speech, with trust
 .

Preamble
All technologies used should permit to guarantee the confidentiality, and the public trust.
They also need to innovate and perfectly fitted for your need.
MicroServices architecture will be appreciated if needed.
User’s management ( 2 points )
Login Registration ( 1 point )
Your app must permit registration and login.
The email address should be validated thanks a confirmation mail.
Login with Google & Facebook account ( 1 point )
You must also permit to a user to login thought Google & Facebook to improve the
registration & login process
SIT Management ( 2 points )

Users can create SIT either from the Web Interface, the mobile app, or thought the
SayIT API.
All SIT should be inserted into your confident and distributed storage.
Definition of a
 SIT
      id
      type ( sit or a resit )
      “sit”
      “resit” ( it create a sort of duplication of a
       sit
       while keeping the reference of
      content:
      IF it’s a
       sit
       , the content is a string of 140 characters maximum
      IF it’s a
       resit
       , the content is the ID of the initial
       sit
      reply_to: ID of another
       sit
      A sit can be liked by Users.
      
      
Applications ( 6 points )
The application should be available for both desktop as web application which must be
totally responsive to work on a mobile browser.
Feed generation ( 3 points )
The app load a SIT feed which is generated thanks artificial intelligence.
In our mind, the behaviour is the following: “The last sit which gonna interest the user”.

 
You are in charge to develop the AI.
It’s the homepage of a logged user.

Account management ( 1 point )
You must permit to the user to edit his mail address.
All mail address edition result to a mail confirmation as mentioned in the registration.

Author page overview ( 1 point )
You must permit to visit the page of a user IF he configured his profile as public.
Then you will be able to see his SIT, like them or comment them

Notification ( 1 point )
When you observe thanks your AI a post which will have more than 90% to interest him
should trigger a notification on the mobile app or the desktop website.
When a user make a SIT mentionning the user ( when a sit contain the following
pattern: @USERNAME ) a notification must be done to the @USERNAME to alert him.

Infrastructure ( 5 points )
Scalability and high availability ( 3 points )
Your infrastructure must be highly scalable and must be fault tolerant.


You must also develop a solution to easily setup new server inside your infrastructure
thanks automation tool ( no manual setup will be accepted except setup the OS ).
If your infrastructure is not scallable, no point will be attributed.

User’s Security ( 2 points )
Your application should be protected, all customers data must of course, be encrypted
inside the storage solution.
An anonym user should not be able to access to data inside your Database except by
making clean request thought the DBMS.
To resume, the storage must be encrypted.
Keep in mind to apply GDPR inside your project.
If your project is not GDPR compliant, it will not be evaluated.



