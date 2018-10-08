Omnis help library
==================
In the subfolder ```omnishelp``` you will find my example help library for Omnis Studio 9.0

The techniques used work in most versions of Omnis Studio except for opening up the internal browser window which is only available since Omnis Studio 8. You can find an Omnis Studio 6.1 copy of this library that opens up an external browser in my 2015 session folder.

In order to use the help system you must first remove Omnis' own help.lbs from the startup folder of Omnis Studio. Make sure to remove this in both the ```Application Support```/```AppData``` folder and the ```firstruninstall``` folder. 

You can then use this help library as a replacement.

Keep in mind that pressing F1 in design mode will always attempt to open up Omnis' internal help. This right now redirects to the online help Omnis provides on their website.

For your application help you can add an $openhelp method to your startup task and ensure that the $helpfoldername property of your library is set to the name of the task instance or you can use the build in browser to open up an online help page by setting the URL in the settings.

For the session I demoed DocuWiki as a possible platform for authoring your online help as well as did a quick review of Sphynx.

Links
=====
https://www.dokuwiki.org/dokuwiki
http://www.sphinx-doc.org/en/master/
https://omnis.net/documentation/index.jsp


