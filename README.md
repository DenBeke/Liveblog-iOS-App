Liveblog iOS App
================

*Simple iPhone app to demonstrate WebSockets in Swift*.  
My first attempt to write an iPhone app.

This applications displays a realtime live blog using the [Liveblog](https://github.com/DenBeke/Liveblog) back-end I've written in Go.


Building
--------

Just open the `Liveblog.xcworkspace` file and build the project.
Mind that you need to run the Go back-end and change the socket url in `ViewController.swift`. Change `labs.denbeke.be:1234` to your socket url:

```Swift
let socket = WebSocket(url: NSURL(scheme: "ws", host: "labs.denbeke.be:1234", path: "/")!)
```


Acknowledgements
----------------

Liveblog uses [Starscream](https://github.com/daltoniam/Starscream) WebSocket client.

Author
------

Mathias Beke - [denbeke.be](http://denbeke.be)