

## Task



The included API endpoint returns, amongst other data, an array of news stories (assets).



You are tasked with creating an iPhone app that consumes the provided API and displays a list of news articles to the user, ideally in a TableView or CollectionView (UIKit). Tapping a story should present the asset’s URL in a WKWebView or an alternate.



## Requirements



* The list of articles should display at least the following fields:

-- headline

-- theAbstract

-- byLine



* Display the latest article first in the list, use article's 'timeStamp'



* If an 'asset' has 'relatedImages', display the smallest image available as a thumbnail on the cell

* Images should be loaded asynchronously and cached



* The style of cells is up to you, with necessary padding and layout.

* For UI use storyboards, xibs or layout programmatically as needed, but it should adapt to all iPhone screen sizes



* Comment your code, so it's understandable in six months



* Make sure to include Unit tests as part of the solution - we thoroughly review unit tests and coverage!

* Add at least two UI tests to verify UI is functional and/or cover some important user flow



* Use Xcode 13.x (stable), please specify code compilation notes in your submission.



Please feel free to ask if you have any questions interpreting this document!



### Bonus



* Using CollectionView implementation instead TableView for the list of articles





## Submission Notes



* Code Compilation instructions for the IDE/Plugin expected, dependency management, etc

* Short description explaining architecture (e.g View, ViewModel...)

* Any 3rd party libraries used and rational

* Explain what each test does in comments or in a document format

* Explain any additional features covered - apart the requirements given above



* Please either share your repository (public repo preferred) or use a service like Dropbox to share the file.



## How we evaluate



We want you to succeed! We aim to evaluate each submission with the same criteria, they are:



 * *requirements* you've build the right product, attention to details!

 * *code architecture* appropriate design patterns used (MVVM, router, co-ordinator, service, interactor ...) - we prefer the MVVM architecture is used as a core interaction for screens

 * *code style* idiomatic, safe, clean, concise.

 * *unit tests* coverage, stable, reliable, maintainable, mocked where required

 * *user experience* responsive, user-centric design.





## Resources



API Endpoint:

https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full

