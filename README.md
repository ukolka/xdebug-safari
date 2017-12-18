# xdebug-safari

To run this launch it in xcode using the following as your guidance. Look for the "Build and Run the Application" section.
https://developer.apple.com/library/content/documentation/NetworkingInternetWeb/Conceptual/SafariAppExtension_PG/CreatingandTestingYourFirstSafariAppExtension.html#//apple_ref/doc/uid/TP40017319-CH11-SW1
Not published bc I'm not paying $100 to host a free extension.


Your php.ini should look something like this.

- zend_extension = /usr/lib/php/20151012/xdebug.so
- xdebug.remote_enable = 1
- xdebug.remote_connect_back = 1

And the editor you're using should be listening for xdebug connection at (default) port 9000.
