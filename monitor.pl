#!/usr/bin/perl
use Mail::Sender;


#config section
$sender = new Mail::Sender
{smtp => 'localhost',
 from=>'webmaster@test.com'};
$mailaddr = 'test@test.com';
$logpath = 'tail -f -n 1 /home/x/www/log/test_tornado.log|';
$title = "alert";
$level = "ERROR";
$keypath = "";



#process
open(FD,$logpath) ;
while (1){
    my $in = <FD>;
    $in =~/($level.*)($keypath).*/ or next;
    print $in;
    $sender->MailMsg(
        {to=>$mailaddr,
         subject=>$title,
         msg => $in
        });
    sleep(1);
}
